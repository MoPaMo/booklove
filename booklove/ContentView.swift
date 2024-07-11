//
//  ContentView.swift
//  booklove
//
//  Created by Moritz on 10.07.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        
        ZStack {
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 307.14682, height: 292.85287)
                .background(
                    Image("blur_base")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 307.1468200683594, height: 292.8528747558594)
                        .clipped()
                )
                .cornerRadius(65)
                .shadow(color: .white.opacity(0.25), radius: 3, x: -10, y: 4)
                .blur(radius: 6)
                .rotationEffect(Angle(degrees: -58.16)).position(x: -41, y: 213.92)
            
            Rectangle()
            .foregroundColor(.clear)
            .frame(width: 375.42, height: 341.27)
            .background(
            Image("blur_hex")
            )
            .cornerRadius(65)
            .offset(x: 0.75, y: -56.23)
            .rotationEffect(.degrees(-6.25))
            .blur(radius: 6).position(x:425, y: 700)
            
            Text("book\nlove.")
                .font(.system(size: 64, weight: .bold, design: .serif))
                .lineSpacing(-50)
                .fontWeight(.bold)
                .fontDesign(.serif)
                .dynamicTypeSize(.xLarge)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .frame(width: 158, height: 158, alignment: .topLeading)
        }
        .frame(width: 393, height: 852)
        .background(Color(red: 1, green: 0.98, blue: 0.98))
        
        
    }
}

#Preview {
    ContentView()
}
