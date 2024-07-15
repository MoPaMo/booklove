//
//  bookloveApp.swift
//  booklove
//
//  Created by Moritz on 10.07.24.
//

import SwiftUI

@main
struct bookloveApp: App {
    @StateObject private var tabViewModel = TabViewModel()
    var body: some Scene {
        WindowGroup {
            MainAppView().environmentObject(tabViewModel)
        }
    }
}
class TabViewModel: ObservableObject {
    @Published var selectedTab = 0
}
