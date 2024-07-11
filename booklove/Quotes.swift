import SwiftUI

struct Quotes: View {
    var body: some View {
        ZStack {
            // Background Color
            Color(red: 1, green: 0.98, blue: 0.98)
                .edgesIgnoringSafeArea(.all)
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 307.14682, height: 292.85287)
                .background(
                    Image("blur_base")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 307.14682, height: 292.85287)
                        .clipped()
                )
                .cornerRadius(65)
                .shadow(color: .white.opacity(0.25), radius: 3, x: -10, y: 4)
                .blur(radius: 6)
                .rotationEffect(Angle(degrees: -58.16))
                .offset(x: -130, y: -300)
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 375.42, height: 341.27)
                .background(
                    Image("blur_hex")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                )
                .cornerRadius(65)
                .offset(x: 130, y: 300)
                .rotationEffect(.degrees(-6.25))
                .blur(radius: 6)
            
            VStack(spacing: 20) {
                
                // Header
                Text("booklove.")
                    .font(.system(size: 64, weight: .bold, design: .serif))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                
                // Main Content
                HStack( spacing: 20) {
                    VStack{ //card
                        Rectangle()
                          .foregroundColor(.clear)
                          .frame(width: 311, height: 512)
                          .background(.white.opacity(0.1))
                          .cornerRadius(37)
                          .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 4)
                        // Quote
                        Text("      You must allow me to tell you how ardently I love and admire you.")
                            .font(.system(size: 40, weight: .regular, design: .serif))
                            .foregroundColor(.black)
                            .padding(.vertical)
                        
                        Text("-Mr. Darcy")
                            .font(.system(size: 20, weight: .light, design: .rounded))
                            .foregroundColor(.black)
                        
                        // Book Information
                        Text("Pride and Prejudice")
                            .font(.system(size: 24, weight: .heavy, design: .serif))

                            .foregroundColor(.red)
                        
                        Text("Jane Austen, 1813")
                            .font(.system(size: 20, weight: .light, design: .monospaced))
                            .foregroundColor(.black)
                        .kerning(-2)}.padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(37)
                        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 4)
                    
                    // Interaction Buttons
                    VStack {
                        Image(systemName: "heart")
                        Image(systemName: "bookmark")
                        Image(systemName: "square.and.arrow.up")
                        Spacer()
                        Image(systemName: "flag")
                    }
                    .font(.system(size: 32))
                    .foregroundColor(.black)
                }
                
                
                Spacer()
            }
            .padding(.top, 50)
            
        }
    }
}


struct Feed_Previews: PreviewProvider {
    static var previews: some View {
        Quotes()
    }
}
