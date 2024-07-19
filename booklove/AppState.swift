//
//  AppState.swift
//  booklove
//
//  Created by Moritz on 14.07.24.
//

import SwiftUI

enum AppScreen {
    case welcome
    case setup
    case genres
    case main
    case loading
}

class AppState: ObservableObject {
    @Published var currentScreen: AppScreen = .loading
    @Published var isLoggedIn: Bool = false
    @Published var userID: String = ""
    @Published var token: String = ""
    @Published var name: String = ""
    init() {
        let token = SecureStorage.get()
        let id = SecureStorage.getID()
        
        if id != nil && token != nil{
            self.isLoggedIn = true
            self.userID = token!
            self.token = token!

        }
        self.currentScreen = self.isLoggedIn ? .main : .welcome
        
    }
}
