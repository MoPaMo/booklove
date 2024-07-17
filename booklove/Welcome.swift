import SwiftUI
import AuthenticationServices

struct Welcome: View {
    @State private var showActionSheet = false
    @ObservedObject var appState: AppState

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
                
                SignInWithAppleButton(appState: appState)
                    .frame(width: 280, height: 45)
                
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

    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        let button = ASAuthorizationAppleIDButton(type: .default, style: .whiteOutline)
        button.addTarget(context.coordinator, action: #selector(Coordinator.didTapButton), for: .touchUpInside)
        return button
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(appState: appState)
    }

    class Coordinator: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
        @ObservedObject var appState: AppState

        init(appState: AppState) {
            self.appState = appState
        }

        @objc func didTapButton() {
            let request = ASAuthorizationAppleIDProvider().createRequest()
            request.requestedScopes = []
            
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        }

        func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
            if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                let userIdentifier = appleIDCredential.user
                
                // Handle user data, e.g., send it to the backend or save locally
                // For example, transition to the next screen
                DispatchQueue.main.async {
                    self.appState.currentScreen = .setup
                }
            }
        }

        func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
            // Handle error
            print("Sign in with Apple errored: \(error)")
        }

        func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
            return UIApplication.shared.windows.first!
        }
    }
}
