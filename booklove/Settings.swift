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
            ZStack{
                BackgroundBlurElement()
                
                VStack(alignment: .leading, spacing: 20) {
                    NavigationLink(destination: AccountView()) {
                        Text("Account")
                            .font(.system(.title3, design: .serif))
                            .foregroundColor(.black)
                    }
                    Text("Book Vendor")
                        .font(.system(.title3, design: .serif))
                    Text("Feedback")
                        .font(.system(.title3, design: .serif))
                    Text("Tell A Friend")
                        .font(.system(.title3, design: .serif))
                    Text("Terms Of Service")
                        .font(.system(.title3, design: .serif))
                    Text("Privacy Policy")
                        .font(.system(.title3, design: .serif))
                    Text("Sign Out")
                        .font(.system(.title3, design: .serif))
                        .foregroundColor(.red)
                    
                    Spacer()
                }
                .padding()
                
            }
        }
    }
}

struct AccountView: View {
    var body: some View {
        ZStack{
            BackgroundBlurElement()
            VStack(alignment: .leading, spacing: 20) {
                NavigationLink(destination: SettingsView()) {
                    Text("Account")
                        .font(.system(.title3, design: .serif))
                        .foregroundColor(.black)
                }
                Text("Set New Name")
                    .font(.system(.title3, design: .serif))
                Text("Download My Data")
                    .font(.system(.title3, design: .serif))
                Text("Delete Account")
                    .font(.system(.title3, design: .serif))
                    .foregroundColor(.red)
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("Account", displayMode: .inline)
        }
    }
}

#Preview {
    SettingsView()
}
