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
                    NavigationLink(destination: AccountView()) {
                        Text("Account")
                            .font(.system(.title2, design: .serif))
                            .foregroundColor(.black)
                    }
                    Text("Book Vendor")
                        .font(.system(.title2, design: .serif))
                    Link("Feedback", destination: URL(string: "mailto:feedback@example.com")!)
                        .font(.system(.title2, design: .serif))
                    Button(action: {
                        let activityVC = UIActivityViewController(activityItems: ["Check out this awesome app!"], applicationActivities: nil)
                        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
                    }) {
                        Text("Tell A Friend")
                            .font(.system(.title2, design: .serif))
                    }
                    Link("Terms Of Service", destination: URL(string: "https://example.com/tos")!)
                        .font(.system(.title2, design: .serif))
                    Link("Privacy Policy", destination: URL(string: "https://example.com/privacy")!)
                        .font(.system(.title2, design: .serif))
                    Text("Sign Out")
                        .font(.system(.title2, design: .serif))
                        .foregroundColor(.red)
                    
                    Spacer()
                }
                .padding([.top, .bottom, .trailing])
                .padding(.leading, 30)
            }
        }
    }
}

struct AccountView: View {
    var body: some View {
        ZStack {
            BackgroundBlurElement()
            VStack(spacing: 20) {
                
                Text("Account")
                    .font(.system(.title2, design: .serif))
                    .foregroundColor(.black)
                
                Text("Set New Name")
                    .font(.system(.title2, design: .serif))
                Text("Download My Data")
                    .font(.system(.title2, design: .serif))
                Text("Delete Account")
                    .font(.system(.title2, design: .serif))
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
