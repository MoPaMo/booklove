//
//  Search.swift
//  booklove
//
//  Created by Moritz on 14.07.24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var isLoading = false
    @State private var searchResults: [String] = []
    @FocusState private var isFocused;
    @EnvironmentObject var tabViewModel: TabViewModel

    var body: some View {
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
            
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            } else {
                
                    ForEach(searchResults, id: \.self) { result in
                        VStack(alignment: .leading) {
                            Text(result)
                                .font(.system(size: 24, weight: .heavy, design: .serif))
                                .foregroundColor(.cyan)
                                .padding(.bottom, -10)
                            
                            Text("Jane Austen, 1813") // Adjust or remove as per actual data structure
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
    
    func fetchBooks() {
            guard let url = URL(string: "https://api.booklove.top/book/search") else {
                print("Invalid URL")
                return
            }
            
            // Prepare the request
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // Add bearer token from SecureStorage as authorization header
            if let bearerToken = SecureStorage.get() {
                request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
            }
            
            // Create the request body
            let body: [String: Any] = [
                "query": "your_query_here"
            ]
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body)
            } catch {
                print("Error serializing JSON: \(error)")
                return
            }
            
            // Perform the request
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error fetching books: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data else {
                    print("No data received")
                    return
                }
                
                // Decode JSON response
                do {
                    let decodedResponse = try JSONDecoder().decode(BookResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.searchResults = decodedResponse.data.books
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }.resume()
        }
    

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
struct BookResponse: Codable {
    let error: Bool
    let data: BookData
}

struct BookData: Codable {
    let books: [String]
}

#Preview {
    SearchView().environmentObject(TabViewModel())
}
