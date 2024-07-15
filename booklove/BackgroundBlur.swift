//
//  BackgroundBlur.swift
//  booklove
//
//  Created by Moritz on 12.07.24.
//

import SwiftUI

struct BackgroundBlurElement: View {
    var option: Int
    
    init(option: Int = 1) {
        self.option = option
    }
    
    var body: some View {
        ZStack {
            Color(red: 1, green: 0.98, blue: 0.98)
                .edgesIgnoringSafeArea(.all)
            
            if option == 2 {
                secondBackground
            } else {
                defaultBackground
            }
        }
    }
    
    var defaultBackground: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 307.14682, height: 292.85287)
                .background(
                    Image("blur_base")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 307.14682, height: 292.85287)
                        .clipped()
                )
                .cornerRadius(65)
                .shadow(color: .white.opacity(0.25), radius: 3, x: -10, y: 4)
                .blur(radius: 6)
                .rotationEffect(Angle(degrees: -58.16))
                .offset(x: -130, y: -300)
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 375.42, height: 341.27)
                .background(
                    Image("blur_hex")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                )
                .cornerRadius(65)
                .offset(x: 130, y: 300)
                .rotationEffect(.degrees(-6.25))
                .blur(radius: 6)
        }
    }
    
    var secondBackground: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 350, height: 330)
                .background(
                    Image("blur3")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 350, height: 330)
                        .clipped()
                )
                .cornerRadius(50)
                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                .blur(radius: 4)
                .rotationEffect(Angle(degrees: 30))
                .offset(x: 100, y: -250)
            
            Circle()
                .foregroundColor(.clear)
                .frame(width: 300, height: 300)
                .background(
                    Image("blur1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                )
                .blur(radius: 5)
                .offset(x: -120, y: 280)
        }
    }
}

#Preview {
    BackgroundBlurElement()
}

#Preview {
    BackgroundBlurElement(option: 2)
}
