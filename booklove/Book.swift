//
//  Book.swift
//  booklove
//
//  Created by Moritz on 12.07.24.
//

import SwiftUI
import Alamofire

// Response model to handle the server response
struct BookResponse: Decodable {
    let id: UUID
    let title: String
    let author: String
    let year: String
    let description: String
    let genres: [String]
    let userBooks: [UserBook]

    func toBookItem() -> BookItem {
        return BookItem(id: id, title: title, author: author, year: year)
    }
}

struct UserBook: Decodable {
    let userId: UUID
    let status: String
    let comment: String?
}

struct Book: View {
    @State private var isSheetPresented = false
    @State var bookItem: BookItem?
    @State var fullText = ""
    @State var bookGenres: [String] = []
    @State var comments: [UserBook] = []

    let bookID = "933952f3-a265-4dc0-b2f6-0179c7e29529"

    var body: some View {
        ZStack {
            BackgroundBlurElement()
            ScrollView {
                VStack {
                    if let bookItem = bookItem {
                        VStack(alignment: .leading) {
                            Text(bookItem.title)
                                .font(.system(size: 40, weight: .bold, design: .serif))
                                .foregroundColor(Color(red: 0.20, green: 0.68, blue: 0.90))
                                .multilineTextAlignment(.leading)
                            Text("\(bookItem.author), \(bookItem.year)")
                                .font(.system(size: 20, weight: .light, design: .monospaced))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.leading)
                        }
                        .padding(.leading)
                        .padding(.top, 50)
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 287, height: 0.5)
                            .overlay(Rectangle().stroke(.black, lineWidth: 0.50))
                        HStack {
                            Text(bookGenres.joined(separator: ", "))
                                .font(.system(size: 16, weight: .light, design: .serif))
                                .foregroundColor(.black)
                        }
                        .padding(.top)
                        HStack {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 161, height: 53)
                                    .background(.white)
                                    .cornerRadius(21)
                                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.20), radius: 6, y: 2)
                                Image(systemName: "bookmark")
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)
                            }
                            .frame(width: 161, height: 53)
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 161, height: 53)
                                    .background(.white)
                                    .cornerRadius(21)
                                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.20), radius: 6, y: 2)
                                Image(systemName: "cart")
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)
                            }
                            .frame(height: 53)
                        }
                    } else {
                        Text("Loading...")
                            .font(.system(size: 40, weight: .bold, design: .serif))
                            .foregroundColor(Color(red: 0.20, green: 0.68, blue: 0.90))
                            .multilineTextAlignment(.leading)
                    }
                }
                .padding(.all)
                .sheet(isPresented: $isSheetPresented) {
                    VStack {
                        Text(fullText)
                            .font(.system(size: 16, weight: .light, design: .serif))
                            .foregroundColor(.black)
                            .padding()
                        Spacer()
                        Button(action: {
                            isSheetPresented = false
                        }) {
                            Text("Close")
                                .font(.system(size: 16, weight: .bold, design: .serif))
                                .foregroundColor(.blue)
                        }
                        .padding()
                    }
                }
            }
        }
        .onAppear {
            fetchBookData()
        }
    }

    func fetchBookData() {
        let url = "https://api.booklove.top/book/\(bookID)"
        AF.request(url).responseDecodable(of: BookResponse.self) { response in
            switch response.result {
            case .success(let data):
                self.bookItem = data.toBookItem()
                self.bookGenres = data.genres
                self.comments = data.userBooks
                self.fullText = data.description // Use full text if available
            case .failure(let error):
                print("Error fetching book data: \(error)")
            }
        }
    }
}

#Preview {
    Book()
}
