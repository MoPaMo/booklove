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
            
            BackgroundBlurElement()
            
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
