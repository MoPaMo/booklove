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
                
                VStack( spacing: 20) {
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
                .padding([.top, .bottom, .trailing]) // Only set padding for top, bottom, and trailing
                .padding(.leading, 30) // Set leading padding specifically here
            }
        }
    }
}


struct AccountView: View {
    var body: some View {
        ZStack{
            BackgroundBlurElement()
            VStack(alignment: .leading, spacing: 20) {
                
                Text("Account")
                    .font(.system(.title3, design: .serif))
                    .foregroundColor(.black)
                
                Text("Set New Name")
                    .font(.system(.title3, design: .serif))
                Text("Download My Data")
                    .font(.system(.title3, design: .serif))
                Text("Delete Account")
                    .font(.system(.title3, design: .serif))
                    .foregroundColor(.red)
                
                Spacer()
            }
            .padding(.leading, 18) // Setzt den linken Rand auf 30 Pixel
            .padding([.top, .bottom, .trailing]) // Setzt die anderen Ränder auf den Standardwert
        }
    }
}

#Preview {
    SettingsView()
}
