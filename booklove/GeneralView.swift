//
//  GeneralView.swift
//  booklove
//
//  Created by Moritz on 11.07.24.
//

import SwiftUI

struct GeneralView: View {
    @EnvironmentObject var tabViewModel: TabViewModel
    var body: some View {
        TabView (selection: $tabViewModel.selectedTab){
            Feed()
                .tabItem {
                    Image(systemName: "sparkles")
                    Text("Feed")
                }.tag(0)

            Quotes()
                .tabItem {
                    Image(systemName: "quote.bubble.fill")
                    Text("Quotes")
                }.tag(1)
            List()
                .tabItem {
                    Image(systemName: "books.vertical")
                    Text("List")
                }.tag(2)
            UserProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }.tag(3)
        }
    }
}

#Preview {
    GeneralView().environmentObject(TabViewModel())
}

