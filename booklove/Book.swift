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
                Text("Jane Austen, 1813")
                    .font(.system(size: 20, weight: .light, design: .monospaced))
                    .foregroundColor(.black)
                Text("Mr Bennet, owner of the Longbourn estate in Hertfordshire, has five daughters, but his property is entailed and can only be passed to a male heir. His wife also lacks an inheritance, so his family faces... more").font(.system(size: 16, weight: .light, design: .serif)).foregroundColor(.black)
                HStack(){ZStack() {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 161, height: 53)
                        .background(.white)
                        .cornerRadius(21)
                        .offset(x: 0, y: 0)
                        .shadow(
                            color: Color(red: 0, green: 0, blue: 0, opacity: 0.20), radius: 6, y: 2
                        )
                    Image(systemName: "bookmark")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                        .offset(x: 0, y: 0.50)
                }
                .frame(width: 161, height: 53)
                    ZStack() {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 161, height: 53)
                            .background(.white)
                            .cornerRadius(21)
                            .offset(x: 0, y: 0)
                            .shadow(
                                color: Color(red: 0, green: 0, blue: 0, opacity: 0.20), radius: 6, y: 2
                            )
                        Image(systemName: "cart")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                            .offset(x: 0, y: 0.50)
                    }
                    .frame(width: 161, height: 53)
                }
                
            }.padding(.all)
            
        }
    }
}

#Preview {
    Book()
}
