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
    let isbn: String
    let year: String?
    let description: String
    let genres: [String]
    let userBooks: [UserBook]
    let userliked: Bool

    func toBookItem() -> BookItem {
        return BookItem(id: id, title: title, author: author, year: year ?? "sometime")
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
    @State var isbn = ""
    @State private var isButtonPressed = false
    @State private var errorMessage: String? // State variable for error messages
    @State var liked = false;
    var bookID: String

    init(book: UUID) {
        self.bookID = book.uuidString
    }

    var body: some View {
        ZStack {
            BackgroundBlurElement()
            ScrollView {
                VStack {
                    if let errorMessage = errorMessage {
                        Spacer()
                        Image(systemName: "exclamationmark.triangle")
                        Text(errorMessage)
                            .font(.system(size: 20, weight: .light, design: .monospaced))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding()
                        Spacer()
                    } else if let bookItem = bookItem {
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
                            Text(fullText.prefix(200)+((fullText.count > 200) ?"... " : ""))
                                .font(.system(size: 16, weight: .light, design: .serif))
                                .foregroundColor(.black)
                                + Text(fullText.count > 200 ? " more" : "")
                                    .font(.system(size: 16, weight: .bold, design: .serif))
                                    .foregroundColor(.blue)
                        }
                        .onTapGesture {
                            isSheetPresented = true
                        }
                        HStack {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 161, height: 53)
                                    .background(liked ? .red : .white )
                                    .cornerRadius(21)
                                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.20), radius: 6, y: 2)
                                Image(systemName: "bookmark")
                                    .font(.system(size: 20))
                                    .foregroundColor(liked ? .white : .black)
                            }
                            .frame(width: 161, height: 53).onTapGesture {
                                liked = !liked;
                                like_book(id: bookItem.id, like:liked)
                            }.sensoryFeedback(.success, trigger: liked)
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 161, height: 53)
                                    .background(.white)
                                    .cornerRadius(21)
                                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.20), radius: 6, y: 2)
                                    .scaleEffect(isButtonPressed ? 0.9 : 1.0) // Apply scale effect
                                    .animation(.spring(response: 0.2, dampingFraction: 0.5), value: isButtonPressed) // Animation when button is pressed
                                Image(systemName: "cart")
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)
                            }
                            .frame(height: 53)
                            .onTapGesture {
                                isButtonPressed = true // Trigger animation
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    isButtonPressed = false // Reset animation
                                }

                                let userDefaults = UserDefaults.standard
                                let vendorURL = userDefaults.string(forKey: "vendorURL")
                                
                                if let vendorURL = vendorURL, let url = URL(string: vendorURL + isbn) {
                                    // Open the vendor URL
                                    UIApplication.shared.open(url)
                                } else {
                                    // Fallback to Amazon search URL
                                    let amazonSearchURL = "https://www.amazon.com/s?k=\(isbn)"
                                    if let url = URL(string: amazonSearchURL) {
                                        UIApplication.shared.open(url)
                                    }
                                }
                            }
                        }
                    } else {
                        Spacer()
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
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(SecureStorage.get() ?? "")",
            "Content-Type": "application/json"
        ]
        AF.request(url, headers: headers).responseDecodable(of: BookResponse.self) { response in
            switch response.result {
            case .success(let data):
                self.bookItem = data.toBookItem()
                self.bookGenres = data.genres
                self.comments = data.userBooks
                self.fullText = data.description
                self.isbn = data.isbn
                self.liked = data.userliked
                self.errorMessage = nil // Clear error message on success
            case .failure(let error):
                print(error)
                print(error.localizedDescription)
                self.errorMessage = "Error fetching book data: \(error.localizedDescription)"
            }
        }
    }
}

func like_book(id:UUID, like:Bool=true)  {
    let url = (like ? "https://api.booklove.top/book/like/" :"https://api.booklove.top/book/dislike/") + id.uuidString
    let headers: HTTPHeaders = [
        "Authorization": "Bearer \(SecureStorage.get() ?? "")",
        "Content-Type": "application/json"
    ]
    AF.request(url, method:.get, headers: headers).responseString {
        response in
        switch response.result {
          case .success(let responseBody):
              print("Response body: \(responseBody)")
            if(responseBody=="success")
            {
                
            }
              // Do something with the response body string
          case .failure(let error):
              print("Error: \(error)")
              // Handle the error
          }
    }
}
#Preview {
    Book(book: UUID.init(uuidString: "933952f3-a265-4dc0-b2f6-0179c7e29529") ?? UUID())
}
