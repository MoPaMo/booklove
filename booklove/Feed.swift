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
                    
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .resizable().foregroundColor(.black)
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                            
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
                        
                        
                        
                        
                        Text("Pride and Prejudice")
                            .font(.system(size: 24, weight: .heavy, design: .serif))
                            .foregroundColor(.cyan).padding(.bottom, -10)
                        
                        Text("Jane Austen, 1813")
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
        }
    }
}

#Preview {
    Feed()
}
