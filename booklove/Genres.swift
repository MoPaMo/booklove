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

    var body: some View {
        ZStack {
            BackgroundBlurElement()
            VStack {
                Text("booklove.")
                    .font(.system(size: 64, weight: .bold, design: .serif))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                Text("Let's get to know your reading tastes!") .font(.system(size: 32, weight: .light, design: .rounded))
                    .multilineTextAlignment(.center)
                    .padding(.top, 10)
                Spacer()
                
                        LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ]) {
                        ForEach(bookGenres, id:\.self){ genre in
                            
                            Text(genre)
                                .font(.system(size:20, design:.serif)).padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Capsule().fill(Color.black))
                                .foregroundColor(.white)
                        }
                    }
                Spacer()
                Text("pick some genres")
                    .font(.system(size: 28, weight: .medium, design: .rounded))
                
            }
        }.padding()
    }
}
#Preview {
    Genres()
}
