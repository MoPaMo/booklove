//
//  List.swift
//  booklove
//
//  Created by Moritz on 11.07.24.
//

import SwiftUI
import Alamofire

struct BookItem: Identifiable, Decodable {
    let id: UUID
    let title: String
    let author: String
    let year: String
    
    init(id: UUID = UUID(), title: String, author: String, year: String="sometime") {
        self.id = id
        self.title = title
        self.author = author
        self.year = year
    }
}


struct List: View {
    @State private var isSheetPresented = false
    @State var books: [BookItem] = []
    @State private var isLoading = true
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background Color
                BackgroundBlurElement(option: 2)
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
                        
                        if isLoading {
                            LoadingSkeleton()
                        } else {
                            VStack(alignment: .leading, spacing: 10) {
                                ForEach(books) { book in
                                    VStack(alignment: .leading) {
                                        NavigationLink(destination:Book( book:book.id)) {
                                            VStack(alignment: .leading) {
                                                Text(book.title)
                                                    .font(.system(size: 24, weight: .bold, design: .serif))
                                                    .foregroundColor(.cyan).multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                                                
                                                Text("\(book.author), \(book.year)")
                                                    .font(.system(size: 18, weight: .light, design: .serif))
                                                    .foregroundColor(.black).multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                                            }
                                        }
                                    }
                                    .padding(.bottom, 10)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "magnifyingglass.circle.fill")
                            .foregroundColor(.black)
                            .font(.system(size: 32))
                            .padding()
                            .onTapGesture {
                                isSheetPresented = true
                            }
                    }
                    Spacer()
                }
            }
            .sheet(isPresented: $isSheetPresented) {
                SearchView()
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
            .onAppear(perform: fetchBooks)
        }
    }
    
    func fetchBooks() {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(SecureStorage.get() ?? "")",
            "Content-Type": "application/json"
        ]
        AF.request("https://api.booklove.top/user/list", method: .post, encoding: JSONEncoding.default, headers: headers).responseDecodable(of: Response.self) { response in
            switch response.result {
            case .success(let responseData):
                // Access the nested data
                books = responseData.data.books.map { k in
                    return BookItem(id: k.id, title: k.title,
                                    author: k.author,
                                    year: k.year ?? "sometime")
                }
                isLoading = false
                
            case .failure(let error):
                print("Error: \(error)")
                isLoading = false
            }
        }
    }
}

#Preview {
    List()
}


struct LoadingSkeleton: View {
    @State private var isAnimating = false
    let items:Int;
    init(i_items:Int=5){
        items = i_items
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(0..<items) { _ in
                VStack(alignment: .leading, spacing: 5) {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 30)
                        .opacity(isAnimating ? 0.6 : 1.0)
                        .animation(Animation.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: isAnimating)

                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 20)
                        .opacity(isAnimating ? 0.6 : 1.0)
                        .animation(Animation.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: isAnimating)
                }
                .padding(.vertical, 5)
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
}
