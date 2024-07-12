//
//  Genres.swift
//  booklove
//
//  Created by Moritz on 12.07.24.
//

import SwiftUI

struct Genres: View {
    let bookGenres = [
        "Non-Fiction", "Romance", "Mystery", "Thriller",
        "Young Adults", "Fantasy", "Classics", "Sci-Fi",
        "Adventure", "Comedy", "Horror", "Historical",
        "Self-Help", "Biography", "LGBT+", "Philosophy"
    ]
    
    @State private var selectedGenres: Set<String> = []
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
                Text("Let's get to know your reading tastes!")
                    .font(.system(size: 32, weight: .light, design: .rounded))
                    .multilineTextAlignment(.center)
                    .padding(.top, 10)
                Spacer()
                
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ]) {
                    ForEach(bookGenres, id: \.self) { genre in
                        Text(genre)
                            .font(.system(size: 20, weight: .regular, design: .serif))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(
                                Capsule()
                                    .fill(selectedGenres.contains(genre) ? Color.white : Color.black)
                                    .animation(.easeInOut(duration: 0.25), value: selectedGenres)
                            )
                            .overlay(
                                Capsule()
                                    .stroke(Color.black, lineWidth: 1)
                            )
                            .foregroundColor(selectedGenres.contains(genre) ? .black : .white)
                            .animation(.easeInOut(duration: 0.25), value: selectedGenres)
                            .onTapGesture {
                                toggleGenre(genre)
                            }
                    }
                }.padding(.horizontal, 30)
                
                Spacer()
                if (!showContinueButton) {
                    Text("pick some genres")
                        .font(.system(size: 28, weight: .medium, design: .rounded))
                }
                if showContinueButton {
                    Button("continue") {
                        
                    }
                    .font(.system(size: 28, weight: .medium, design: .rounded)).foregroundColor(.black)
                }
            }
        }.padding()
    }
    
    private func toggleGenre(_ genre: String) {
        if selectedGenres.contains(genre) {
            selectedGenres.remove(genre)
        } else {
            selectedGenres.insert(genre)
        }
        showContinue()
    }
    
    private func showContinue() {
        showContinueButton = !selectedGenres.isEmpty
    }
}

#Preview {
    Genres()
}
