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
}

class AppState: ObservableObject {
    @Published var currentScreen: AppScreen = .welcome
}
