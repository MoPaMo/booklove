//
//  Genres.swift
//  booklove
//
//  Created by Moritz on 12.07.24.
//

import SwiftUI

struct Genres: View {
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
                    ], spacing: 16) {
                        ForEach(0..<16) { index in
                            
                            Text("Item \(index)")
                        }
                    }
                Spacer()
                Text("pick some genres")
                    .font(.system(size: 28, weight: .medium, design: .rounded))
                    .padding(.bottom, 40)
                
            }
        }
    }
}
#Preview {
    Genres()
}
