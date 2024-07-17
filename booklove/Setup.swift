//
//  Setup.swift
//  booklove
//
//  Created by Moritz on 14.07.24.
//

import SwiftUI

struct Setup: View {
    @ObservedObject var appState: AppState
    @State private var name = ""
    @State private var favoriteBook = ""
    @State private var showContinueButton = false
    
    var body: some View {
        ZStack {
            BackgroundBlurElement()
            VStack {
                Text("booklove.")
                    .font(.system(size: 64, weight: .bold, design: .serif))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                Text("Tell us something about yourself!")
                    .font(.system(size: 32, weight: .light, design: .rounded))
                    .multilineTextAlignment(.center)
                    .padding(.top, 10).padding(.bottom)
                Spacer()
                VStack(spacing: 20) {
                    HStack {
                        Text("What can we call you?")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size:22, design:.serif))
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        VStack(spacing: 0) {
                            TextField("", text: $name)
                                .padding(.vertical, 20)
                                .multilineTextAlignment(.trailing)
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray)
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.5)
                    }
                }
                .padding()
                VStack(spacing: 20) {
                    HStack {
                        Text("What is your favourite book?")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size:22, design:.serif))
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        VStack(spacing: 0) {
                            TextField("", text: $favoriteBook)
                                .padding(.vertical, 10)
                                .multilineTextAlignment(.trailing)
                                .font(.system(size: 20))
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray)
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.5)
                    }
                }
                .padding()
                Spacer()
                
                
                
                if showContinueButton {
                    Button(action: {
                        appState.currentScreen = .genres
                    }) {
                        Text("Continue")
                            .font(.system(size: 20, weight: .semibold, design:.serif))
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                    .padding()
                }
            }
        }
        .onChange(of: name) { _ in
            updateContinueButtonVisibility()
        }
        .onChange(of: favoriteBook) { _ in
            updateContinueButtonVisibility()
        }
    }
    
    private func updateContinueButtonVisibility() {
        showContinueButton = !name.isEmpty && !favoriteBook.isEmpty
    }
}

//#Preview {
  //  Setup()
//}
