//
//  BackgroundBlur.swift
//  booklove
//
//  Created by Moritz on 12.07.24.
//

import SwiftUI

struct BackgroundBlurElement: View {
    var body: some View {
        ZStack {
            Color(red: 1, green: 0.98, blue: 0.98)
                .edgesIgnoringSafeArea(.all)
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
}

#Preview {
    BackgroundBlurElement()
}
