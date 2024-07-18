//
//  Search.swift
//  booklove
//
//  Created by Moritz on 14.07.24.
//

import SwiftUI
import Alamofire

struct SearchView: View {
    @State private var searchText = ""
    @State private var isLoading = false
    @State private var searchResults: [BookItem] = []
    @FocusState private var isFocused;
    @EnvironmentObject var tabViewModel: TabViewModel

    var body: some View {
        ScrollView{
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    
                    TextField("Search for books, authors, or readers", text: $searchText, onCommit: {
                        fetchBooks()
                    }).focused($isFocused).onAppear(perform: {
                        isFocused = true
                    })
                    .font(.custom("Georgia", size: 16))
                    .padding(8)
                }
                .padding()
                .background(BlurView(style: .systemMaterial))
                .cornerRadius(10)
                .padding([.leading, .trailing], 16)
                .padding(.top, 50)
                
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else {
                    
                    ForEach(searchResults, id: \.self.id) { result in
                        VStack(alignment: .leading) {
                            Text(result.title)
                                .font(.system(size: 24, weight: .heavy, design: .serif))
                                .foregroundColor(.cyan)
                                .padding(.bottom, -10)
                            
                            Text("\(result.author), \(result.year)")
                                .font(.system(size: 18, weight: .light, design: .monospaced))
                                .foregroundColor(.black)
                                .kerning(-2)
                        }
                        .padding(.vertical, 8)
                    }
                    
                    
                }
            }
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .overlay(
                BackgroundBlur()
            )
        }
    }
    
    func fetchBooks() {
        isLoading=true;
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(SecureStorage.get() ?? "")",
            "Content-Type": "application/json"
        ]
        AF.request("https://api.booklove.top/book/search", method:.post, parameters: ["query":searchText], encoding: JSONEncoding.default, headers: headers).responseDecodable(of:Response.self)
        {response in
            switch response.result {
            case .success(let responseData):
                // Access the nested data
                isLoading=false;
                searchResults = responseData.data.books.map { k in
                    return BookItem(id: k.id, title: k.title,
                                    author: k.author,
                                    year: k.year)
                   }
                
            case .failure(let error):
                isLoading=false;
                print("Error: \(error)")
            }
        }
    }
    

}
struct Response: Codable {
    let data: DataClass
}

struct DataClass: Codable {
    let books: [BookItemRequest]
}
struct BookItemRequest: Codable {
    var id = UUID()
    let title: String
    let author: String
    let year: Int
}

struct BackgroundBlur: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Circle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.red.opacity(0.3), Color.blue.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 100, height: 100)
                    .blur(radius: 30)
                
                Spacer()
            }
            Spacer()
        }
    }
}

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}


#Preview {
    SearchView().environmentObject(TabViewModel())
}
