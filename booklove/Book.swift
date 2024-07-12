//
//  Book.swift
//  booklove
//
//  Created by Moritz on 12.07.24.
//

import SwiftUI

struct Book: View {
    var body: some View {
        ZStack {
            BackgroundBlurElement()
            VStack{
                Text("Pride and Prejudice")
                    .font(.system(size: 40, weight: .bold, design: .serif))
                    .foregroundColor(Color(red: 0.20, green: 0.68, blue: 0.90))
                Spacer()
            }.padding(.all)
            
        }
    }
}

#Preview {
    Book()
}
