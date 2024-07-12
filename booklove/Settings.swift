//
//  Settings.swift
//  booklove
//
//  Created by Moritz on 12.07.24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundBlurElement()
                
                VStack(spacing: 20) {
                    Text("Settings.")
                        .font(.system(size: 32, weight: .regular, design: .serif))
                    
                        .foregroundColor(.black)
                    Spacer()
                    NavigationLink(destination: AccountView()) {
                        Text("Account")
                            .font(.system(size: 32, weight: .regular, design: .serif))
                            .foregroundColor(.black)
                    }
                    Text("Book Vendor")
                        .font(.system(size: 32, weight: .regular, design: .serif)).foregroundStyle(.black)
                    Link("Feedback", destination: URL(string: "mailto:feedback@example.com")!)
                        .font(.system(size: 32, weight: .regular, design: .serif))
                        .foregroundColor(.black)
                    Button(action: {
                        let activityVC = UIActivityViewController(activityItems: ["Check out this awesome app!"], applicationActivities: nil)
                        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
                    }) {
                        Text("Tell A Friend")
                            .font(.system(size: 32, weight: .regular, design: .serif))
                            .foregroundColor(.black)
                    }
                    Link("Terms Of Service", destination: URL(string: "https://example.com/tos")!)
                        .font(.system(size: 32, weight: .regular, design: .serif))
                        .foregroundColor(.black)
                    Link("Privacy Policy", destination: URL(string: "https://example.com/privacy")!)
                        .font(.system(size: 32, weight: .regular, design: .serif))
                        .foregroundColor(.black)
                    Text("Sign Out")
                        .font(.system(size: 32, weight: .regular, design: .serif))
                        .foregroundColor(.red)
                    
                    Spacer()
                }.padding(.all)
            }
        }
    }
}

struct AccountView: View {
    var body: some View {
        ZStack {
            BackgroundBlurElement()
            VStack(spacing: 50) {
                
                Text("Account")
                    .font(.system(size: 32, weight: .regular, design: .serif))
                    .foregroundColor(.black)
                
                Text("Set New Name")
                    .font(.system(size: 32, weight: .regular, design: .serif))
                Text("Download My Data")
                    .font(.system(size: 32, weight: .regular, design: .serif))
                Text("Delete Account")
                    .font(.system(size: 32, weight: .regular, design: .serif))
                    .foregroundColor(.red)
                
                Spacer()
            }
            .padding(.leading, 18)
            .padding([.top, .bottom, .trailing])
        }
    }
}

#Preview {
    SettingsView()
}
