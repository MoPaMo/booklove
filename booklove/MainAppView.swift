//
//  MainAppView.swift
//  booklove
//
//  Created by Moritz on 14.07.24.
//

import SwiftUI

struct MainAppView: View {
    @StateObject private var appState = AppState()
    
    var body: some View {
        switch appState.currentScreen {
        case .welcome:
            Welcome(appState: appState)
        case .setup:
            Setup(appState: appState)
        case .genres:
            Genres(appState: appState)
        case .main:
            GeneralView()
        }
    }
}
