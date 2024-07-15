import SwiftUI

struct Feed: View {
    @State private var isSheetPresented = false;
    var body: some View {
        ZStack {
            // Background Color
            Color(red: 1, green: 0.98, blue: 0.98)
                .edgesIgnoringSafeArea(.all)
            
            // Background Blur Elements
            BackgroundBlurElement()
            ScrollView {
                
                VStack {
                    Text("booklove.")
                        .font(.system(size: 64, weight: .bold, design: .serif))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding(.top, 20)
                    
                }
                singleBookReview(book:BookItem(title: "Pride and Prejudice", author: "Jane Austen", year: 1813)).padding(.bottom)
                recommendedUsers().padding(.leading, 30).background(Color.white.opacity(0.9).blur(radius: 1))
                
                    .cornerRadius(10)
                singleBookReview(book:BookItem(title: "Sense and Sensibility", author: "Jane Austen", year: 1811)).padding(.bottom)
                
            singleBookReview(book: BookItem(title: "Northanger Abbey", author: "Jane Austen", year: 1818))
                Text("This is a prototype app.")
                                      .padding()
                                      .background(Color.red.opacity(0.8))
                                      .foregroundColor(.white)
                                      .cornerRadius(8)
                                      .transition(.opacity)
                Spacer().padding(.vertical, 300)
            }
            VStack {
                           HStack {
                               Spacer()
                               Image(systemName: "magnifyingglass.circle.fill")
                                   .foregroundColor(.black)
                                   .font(.title)
                                   .padding().onTapGesture {
                                       isSheetPresented = true
                                   }
                           }
                           Spacer()
                       }
        }.sheet(isPresented: $isSheetPresented) {
            SearchView()
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

struct singleBookReview : View{
    var book: BookItem;
    var body: some View{
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.red.opacity(0.3)]),
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing)
                        )
                        .frame(width: 70, height: 70)
                        .blur(radius: 10)
                    
                    Image("memoji_placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                }

                
                VStack(alignment: .leading) {
                    Text("Jane Appleseed")
                        .font(.system(size: 24, weight: .bold, design: .serif))
                        .foregroundColor(.mint)
                    
                    Text("is reading:")
                        .font(.system(size: 16, weight: .light, design: .rounded))
                        .foregroundColor(.black)
                }
                .padding(.leading, 10.0)
                
            }
            
            
            
            
            Text(book.title)
                .font(.system(size: 24, weight: .heavy, design: .serif))
                .foregroundColor(.cyan).padding(.bottom, -10)
            
            Text("\(book.author), \(book.year)")
                .font(.system(size: 18, weight: .light, design: .monospaced))
                .foregroundColor(.black).kerning(-2)
            
            Text("""
        Mr Bennet, owner of the Longbourn estate in Hertfordshire, has five daughters, but his property is entailed and can only be passed to a male heir. His wife also lacks an inheritance, so his family faces becoming poor upon his death. Thus, it is imperative that at least one of the daughters marry well to support the others, which is a primary motivation driving the plot.
        """)
            .font(.system(size: 16.5, weight: .regular, design: .serif))
            .foregroundColor(.black)
            .padding(.top, 1)
        }
        .padding(.horizontal, 33)
        
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: 300, height: 0.5)
            .overlay(Rectangle()
                .stroke(.black, lineWidth: 0.50)).padding(.vertical, 2.0)
        
        HStack {
            Image(systemName: "heart")
                .font(.system(size: 32)).foregroundColor(.black)
            
            Image(systemName: "bookmark").foregroundColor(.black)
                .font(.system(size: 32))
            
            Image(systemName: "square.and.arrow.up")
                .font(.system(size: 32)).foregroundColor(.black)
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            
            Spacer()
            Image(systemName: "flag")
                .font(.system(size: 32))
        }
        
        
        .padding(.horizontal, 40)
        
        
        Spacer()
    
    }
}


struct recommendedUsers: View {
    var body: some View {
     
        VStack(alignment: .leading) {
                   Text("Like-minded readers")
                .font(.system(size: 32, design:.serif))
                       .fontWeight(.bold).foregroundColor(.mint)
                       

                   ScrollView(.horizontal, showsIndicators: false) {
                       HStack(spacing: 16) {
                           ForEach(0..<10) { _ in
                               VStack {
                                   ZStack {
                                       Circle()
                                           .fill(
                                               LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.red.opacity(0.3)]),
                                                              startPoint: .topLeading,
                                                              endPoint: .bottomTrailing)
                                           )
                                           .frame(width: 70, height: 70)
                                           .blur(radius: 10)
                                       
                                       Image("memoji_placeholder")
                                           .resizable()
                                           .aspectRatio(contentMode: .fit)
                                           .frame(width: 60, height: 60)
                                   }
                                   
                                   Text("User Name")
                                       .font(.caption)
                                       .fontWeight(.bold)
                                       .foregroundColor(.primary)
                                       .padding(.top, 4)
                               }
                               .padding(.vertical, 10) // Added padding to ensure the image is not cut off
                           }
                       }
                       .padding(.horizontal, 16)
                   }
                   .padding(.top, 8)
               }
               .padding(.vertical, 16)
    }
}


#Preview {
    Feed()
}
