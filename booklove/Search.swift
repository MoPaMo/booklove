//
//  Search.swift
//  booklove
//
//  Created by Moritz on 14.07.24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Search for books, authors, or genres", text: $searchText)
                    .font(.system(size:16, design:.serif))
                    .padding(8)
            }
            .padding()
            .background(BlurView(style: .systemMaterial))
            .cornerRadius(10)
            .padding([.leading, .trailing], 16)
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .overlay(
            BackgroundBlur()
        )
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

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}


#Preview {
    SearchView()
}
