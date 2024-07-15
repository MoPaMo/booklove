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
    let sampleBooks = [
        "The Great Gatsby",
        "Moby Dick",
        "To Kill a Mockingbird",
        "1984",
        "The Catcher in the Rye",
        "Pride and Prejudice",
        "War and Peace",
        "The Odyssey"
    ]
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Search for books, authors, or readers", text: $searchText, onCommit: {
                    performSearch()
                }).focused($isFocused).onAppear(perform: {
                    isFocused=true;
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
                        Text(result)
                            .font(.system(size: 24, weight: .heavy, design: .serif))
                            .foregroundColor(.cyan).padding(.bottom, -10)
                        
                        Text("Jane Austen, 1813")
                            .font(.system(size: 18, weight: .light, design: .monospaced))
                            .foregroundColor(.black).kerning(-2)
                        
                    }
                .listStyle(PlainListStyle())

            }
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .overlay(
            BackgroundBlur()
        )
    }
    
    private func performSearch() {
        isLoading = true
        searchResults = []
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {
            let results = sampleBooks.filter { $0.localizedCaseInsensitiveContains(searchText) }
            DispatchQueue.main.async {
                searchResults = results
                isLoading = false
            }
        }
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

#Preview {
    SearchView()
}
