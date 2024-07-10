import SwiftUI
import AuthenticationServices

struct Welcome: View {
    @State private var showActionSheet = false
    
    var body: some View {
        ZStack {
            // Background Color
            Color(red: 1, green: 0.98, blue: 0.98)
                .edgesIgnoringSafeArea(.all)
            
            // Background Blur Elements
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 307.14682, height: 292.85287)
                .background(
                    Image("blur_base")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 307.14682, height: 292.85287)
                        .clipped()
                )
                .cornerRadius(65)
                .shadow(color: .white.opacity(0.25), radius: 3, x: -10, y: 4)
                .blur(radius: 6)
                .rotationEffect(Angle(degrees: -58.16))
                .offset(x: -130, y: -300)
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 375.42, height: 341.27)
                .background(
                    Image("blur_hex")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                )
                .cornerRadius(65)
                .offset(x: 130, y: 300)
                .rotationEffect(.degrees(-6.25))
                .blur(radius: 6)
            
            VStack {
                Text("booklove.")
                    .font(.system(size: 64, weight: .bold, design: .serif))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.top, 100)
                
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
                
                SignInWithAppleButton()
                    .frame(width: 280, height: 45)
                
                Text("By signing in, you agree to be bound by our Terms of Service and accept our Privacy Policy.")
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
        .frame(width: 393, height: 852)
    }
}

struct SignInWithAppleButton: UIViewRepresentable {
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton(type: .default, style: .whiteOutline)
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {}
}

#Preview {
    Welcome()
}
