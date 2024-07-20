//
//  GeneralView.swift
//  booklove
//
//  Created by Moritz on 11.07.24.
//

import SwiftUI

struct GeneralView: View {
    @EnvironmentObject var tabViewModel: TabViewModel
    @State var urlSurprise = false
    @State var actionType = ""
    @State var id:UUID = UUID()
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
            UserProfileView(userID: UUID(uuidString:SecureStorage.getID() ?? "") ?? UUID())
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }.tag(3)
        }.sheet(isPresented: $urlSurprise){
            if(actionType=="user"){
                UserProfileView(userID: id)
            }
            else if (actionType=="book"){
                
                Book(book: id)
                
            }
        }.onOpenURL { incomingURL in
            print("App was opened via URL: \(incomingURL)")
            
            handleIncomingURL(incomingURL)
        }
    }
    private func handleIncomingURL(_ url: URL) {
         guard url.scheme == "booklove" else {
             return
         }
         guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
             print("Invalid URL")
             return
         }
        guard let action = components.host, action == "user" || action == "book" else {
                   print("Unknown URL, we can't handle this one!")
                   return
               }
        self.actionType = action
        guard let _id = components.queryItems?.first(where: { $0.name == "id" })?.value else {
                    print("Recipe name not found")
                    return
                }
        self.urlSurprise=true
        self.id=UUID(uuidString: _id) ?? UUID()
        print(id, actionType)
        
     }
}

#Preview {
    GeneralView().environmentObject(TabViewModel())
}

