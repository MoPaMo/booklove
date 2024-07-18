//
//  Profile.swift
//  booklove
//
//  Created by Moritz on 17.07.24.
//

import SwiftUI
import UIKit

struct ProfileView: View {
    @State var followed = false
    @State private var isSheetPresented = false
    let books: [BookItem] = [
        BookItem(title: "Pride and Prejudice", author: "Jane Austen", year: "1813"),
        BookItem(title: "Sense and Sensibility", author: "Jane Austen", year: "1811"),
        BookItem(title: "Emma", author: "Jane Austen", year: "1815"),
        BookItem(title: "Persuasion", author: "Jane Austen", year: "1818"),
        BookItem(title: "Mansfield Park", author: "Jane Austen", year: "1814"),
        BookItem(title: "Northanger Abbey", author: "Jane Austen", year: "1818")
    ]
    
    var body: some View {
        ZStack {
            BackgroundBlurElement(option: 3)
            
            ScrollView {
                VStack {
                    Text("booklove.")
                        .font(.system(size: 64, weight: .bold, design: .serif))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding(.top, 20)
                        .padding(.bottom)
                    
                    HStack(spacing: 15) {
                        // Profile Picture
                        Image("memoji_placeholder")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 70, height: 70)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            // User Name
                            Text("Jane Appleseed")
                                .font(.system(size: 30, weight: .bold, design: .serif))
                                .foregroundColor(.mint)
                            
                            // Favourite Book
                            Text("\(Image(systemName: "book.circle.fill")) Pride and Prejudice")
                                .font(.system(size: 18, weight: .regular))
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                        
                        // Follow Button
                        Button(action: {
                            followed.toggle()
                        }) {
                            if !followed {
                                Image(systemName: "heart")
                                    .font(.title2)
                                    .foregroundColor(.red)
                            } else {
                                Image(systemName: "heart.fill")
                                    .font(.title2)
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.5).blur(radius: 10))
                    .cornerRadius(10)
                    
                    VStack(alignment: .leading) {
                        Text("Favourite Genres").font(.system(size: 20, weight: .light))
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(["Adventure", "Horror", "Comedy", "History"], id: \.self) { genre in
                                    Text(genre)
                                        .font(.system(size: 15, weight: .bold, design: .serif))
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(Color.black)
                                        .foregroundColor(.white)
                                        .cornerRadius(20)
                                }
                            }
                        }
                        .padding(.bottom, 20)
                    }
                    .padding(.leading)
                    
                    HStack {
                        Text("Friends").font(.system(size: 20, weight: .light))
                        
                        Spacer()
                        Text("See all").font(.system(size: 20, weight: .light, design: .rounded)).foregroundColor(.blue)
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Spacer()
                        
                        ZStack {
                            ForEach(0..<5) { item in
                                Image("memoji_placeholder")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 61, height: 61)
                                    .background(Color(red: 0.8, green: 0.8, blue: 0.8))
                                    .clipShape(Circle())
                                    .offset(x: CGFloat(item * 35))
                                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 4)
                            }
                        }
                        .padding(.trailing, (61 + 5 * 35) / 2)
                        .padding(.leading, 0)
                        
                        Spacer()
                    }
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Books").font(.system(size: 20, weight: .light)).multilineTextAlignment(.leading)
                            Spacer()
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(books) { book in
                                VStack(alignment: .leading) {
                                    Text(book.title)
                                        .font(.system(size: 24, weight: .bold, design: .serif))
                                        .foregroundColor(.cyan)
                                    
                                    Text("\(book.author), \(book.year)")
                                        .font(.system(size: 18, weight: .light, design: .serif))
                                        .foregroundColor(.black)
                                }
                                .padding(.bottom, 10)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "square.and.arrow.up.circle.fill")
                        .foregroundColor(.black)
                        .font(.system(size: 32))
                        .padding()
                }
                Spacer()
            }
            .onTapGesture {
                isSheetPresented = true
            }
        }
        .safeAreaInset(edge: .top) {
            ZStack {
                Rectangle()
                    .fill(.clear)
                    .background(Color.white.opacity(1))
                    .blur(radius: 10)
                    .frame(height: 0)
            }
        }
        .sheet(isPresented: $isSheetPresented) {
            ShareSheet(activityItems: ["Check out my booklove profile!"])
        }
    }
}

#Preview {
    ProfileView()
}
