import SwiftUI
import AuthenticationServices

struct Welcome: View {
    @State private var showActionSheet = false
    @ObservedObject var appState: AppState
    @State private var loading = false

    var body: some View {
        ZStack {
            // Background Color
            Color(red: 1, green: 0.98, blue: 0.98)
                .edgesIgnoringSafeArea(.all)
            
            // Background Blur Elements
            BackgroundBlurElement()
            
            VStack {
                Text("booklove.")
                    .font(.system(size: 64, weight: .bold, design: .serif))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                
                Spacer()
                Spacer()
                
                Text("Welcome.")
                    .font(.system(size: 32, design: .serif))
                    .foregroundColor(.black)
                    .padding(.top)
                
                Spacer()
                Spacer()
                
                Text("Let's get started.")
                    .font(.system(size: 32, design: .serif))
                    .foregroundColor(.black)
                    .padding(.top, 20)
                if !loading {
                    SignInWithAppleButton(appState: appState, loading: $loading)
                        .frame(width: 280, height: 45)
                } else {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5, anchor: .center)
                }
                Text("By signing in, you agree to be bound by our Terms of Service and accept our Privacy Policy. \nClick here to review them.")
                    .font(.system(size: 16, design: .monospaced))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.top, 10)
                    .padding(.horizontal)
                    .padding(.bottom, -30)
                    .onTapGesture {
                        self.showActionSheet = true
                    }
                    .actionSheet(isPresented: $showActionSheet) {
                        ActionSheet(
                            title: Text("Important Information"),
                            message: Text("Please review our Terms of Service and Privacy Policy."),
                            buttons: [
                                .default(Text("Terms of Service")) {
                                    if let url = URL(string: "https://example.com/tos") {
                                        UIApplication.shared.open(url)
                                    }
                                },
                                .default(Text("Privacy Policy")) {
                                    if let url = URL(string: "https://example.com/privacy") {
                                        UIApplication.shared.open(url)
                                    }
                                },
                                .cancel()
                            ]
                        )
                    }
                
                Spacer()
            }
        }
    }
}

struct SignInWithAppleButton: UIViewRepresentable {
    @ObservedObject var appState: AppState
    @Binding var loading: Bool

    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        let button = ASAuthorizationAppleIDButton(type: .default, style: .whiteOutline)
        button.addTarget(context.coordinator, action: #selector(Coordinator.didTapButton), for: .touchUpInside)
        return button
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(appState: appState, loading: $loading)
    }

    class Coordinator: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
        @ObservedObject var appState: AppState
        @Binding var loading: Bool

        init(appState: AppState, loading: Binding<Bool>) {
            self._loading = loading
            self.appState = appState
        }

        @objc func didTapButton() {
            loading = true
            let request = ASAuthorizationAppleIDProvider().createRequest()
            request.requestedScopes = []
            
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        }

        func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
            if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                let identityToken = String(data: appleIDCredential.identityToken ?? Data(), encoding: .utf8) ?? ""
                let userID = appleIDCredential.user
                let urlString = "https://api.booklove.top/login/app"
                let params = ["userID": userID, "identityToken": identityToken] as [String : Any]
                
                NetworkManager.shared.fetch(urlString: urlString, method: .POST, params: params) { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let jsonResponse):
                            if let error = jsonResponse["error"] as? Bool, error {
                                let reason = jsonResponse["reason"] as? String
                                print("Error: \(reason ?? "Unknown error")")
                            } else {
                                print(jsonResponse)
                                if let data = jsonResponse["data"] as? [String: Any] {
                                    let new = data["new"] as? Bool ?? false
                                    let userID = data["userID"] as? String ?? ""
                                    
                                    print("User ID: \(userID)")
                                    
                                    self.appState.isLoggedIn = SecureStorage.set(userID)
                                    self.appState.userID = self.appState.isLoggedIn ? userID : ""
                                    if self.appState.isLoggedIn {
                                        self.appState.currentScreen = new ? .setup : .main
                                    } else {
                                        self.loading = false
                                    }
                                } else {
                                    print("No data in the response.")
                                    self.loading = false
                                }
                            }
                        case .failure(let error):
                            print("Network Error: \(error.localizedDescription)")
                            self.loading = false
                        }
                    }
                }
            }
        }

        func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
            // Handle error
            print("Sign in with Apple errored: \(error)")
            loading = false
        }

        func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
            return UIApplication.shared.windows.first!
        }
    }
}
