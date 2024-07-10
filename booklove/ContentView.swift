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
                .shadow(color: .white.opacity(0.25), radius: 3, x: 0, y: 4)
                .blur(radius: 6)
                .rotationEffect(Angle(degrees: -58.16))
            
            Text("book\nlove.")
                    .font(.system(size: 64, weight: .bold, design: .serif))
                    .foregroundColor(.black)
                    .frame(width: 158, height: 158, alignment: .topLeading)
        }
        .frame(width: 393, height: 852)
        .background(Color(red: 1, green: 0.98, blue: 0.98))
        
        
    }
}

#Preview {
    ContentView()
}
