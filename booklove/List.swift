//
//  List.swift
//  booklove
//
//  Created by Moritz on 11.07.24.
//



import SwiftUI

struct BookItem: Identifiable {
    let id = UUID()
    let title: String
    let author: String
    let year: Int
}

struct List: View {
    let books: [BookItem] = [
        BookItem(title: "Pride and Prejudice", author: "Jane Austen", year: 1813),
        BookItem(title: "Sense and Sensibility", author: "Jane Austen", year: 1811),
        BookItem(title: "Emma", author: "Jane Austen", year: 1815),
        BookItem(title: "Persuasion", author: "Jane Austen", year: 1818),
        BookItem(title: "Mansfield Park", author: "Jane Austen", year: 1814),
        BookItem(title: "Northanger Abbey", author: "Jane Austen", year: 1818)
    ]
    
    var body: some View {
        ZStack {
            // Background Color
            BackgroundBlurElement()
                .edgesIgnoringSafeArea(.all)
            ScrollView {
            VStack(alignment: .leading) {
                
                        
                        Text("Your\nBooks")
                            .font(.system(size: 64, weight: .bold, design: .serif))
                            .foregroundColor(.orange)
                            
                            .padding(.top, 100)
                    
                
                Text("By Genre")
                    .font(.system(size: 24, weight: .regular, design: .serif))
                    .foregroundColor(.black)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(["Adventure", "Horror", "Comedy", "History"], id: \.self) { genre in
                            Text(genre)
                                .font(.system(size: 18, weight: .bold, design: .serif))
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(Color.black)
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }
                    }
                    .padding(.vertical, 10)
                }
                .padding(.bottom, 20)
                
                
                
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
            }
            .padding(.horizontal, 20)
        }.safeAreaInset(edge: .top) {
            ZStack {
                Rectangle()
                    .fill(.clear)
                    .background(Color.white.opacity(1))
                    .blur(radius: 10)
                    .frame(height: 0)
            }
        }
    }
}


#Preview {
    List()
}
