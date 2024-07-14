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
                HStack(alignment: .top, spacing: 16) {
                    VStack(alignment: .leading) {
                        Text("Pride and Prejudice")
                            .font(.system(size: 40, weight: .bold, design: .serif))
                            .foregroundColor(Color(red: 0.20, green: 0.68, blue: 0.90))
                            .multilineTextAlignment(.leading)
                        Text("Jane Austen, 1813")
                            .font(.system(size: 20, weight: .light, design: .monospaced))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                    }
                    Spacer()
                }.padding(.leading)
                Rectangle()
                .foregroundColor(.clear)
                .frame(width: 287, height: 0.5)
                .overlay(Rectangle()
                .stroke(.black, lineWidth: 0.50))
                Text("Mr Bennet, owner of the Longbourn estate in Hertfordshire, has five daughters, but his property is entailed and can only be passed to a male heir. His wife also lacks an inheritance, so his family faces... more").font(.system(size: 16, weight: .light, design: .serif)).foregroundColor(.black).padding(.leading)
               
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
                }.padding(.top)
                Rectangle()
                .foregroundColor(.clear)
                .frame(width: 287, height: 0.5)
                .overlay(Rectangle()
                    .stroke(.black, lineWidth: 0.50)).padding(.vertical)
                
                HStack(spacing: 0) {  // No spacing between elements
                            Text("Read by")
                        .font(.system(size: 24, weight: .light))
                                .foregroundColor(.black)
                            
                            ZStack {
                                Image("memoji_placeholder")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 44, height: 44).background(Color(red: 0.8, green: 0.8, blue: 0.8))
                                    .clipShape(Circle())
                                    .offset(x: 0).shadow(
                                        color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 4
                                        )

                                Image("memoji_placeholder")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 44, height: 44).background(Color(red: 0.8, green: 0.8, blue: 0.8))
                                    .clipShape(Circle())
                                    
                                    .offset(x: 25).shadow(
                                        color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 4
                                        )

                                Image("memoji_placeholder")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 44, height: 44).background(Color(red: 0.8, green: 0.8, blue: 0.8))
                                    .clipShape(Circle())
                                    .offset(x: 50).shadow(
                                        color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 4
                                        )

                            }.padding(.horizontal)
                    Spacer()
                }.padding(.leading)
            }.padding(.all)
            
                    
                    
                
            
        }
    }
}

#Preview {
    Book()
}
