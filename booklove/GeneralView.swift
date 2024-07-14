//
//  GeneralView.swift
//  booklove
//
//  Created by Moritz on 11.07.24.
//

import SwiftUI

struct GeneralView: View {
    
    var body: some View {
        TabView {
            Feed()
                .tabItem {
                    Image(systemName: "sparkles")
                    Text("Feed")
                }

            Quotes()
                .tabItem {
                    Image(systemName: "quote.bubble.fill")
                    Text("Quotes")
                }
            List()
                .tabItem {
                    Image(systemName: "books.vertical")
                    Text("List")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
        }
    }
}

#Preview {
  GeneralView()
}

