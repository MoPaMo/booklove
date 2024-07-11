import SwiftUI

struct Quotes: View {
    var body: some View {
        ZStack {
            // Background Color
            Color(red: 1, green: 0.98, blue: 0.98)
                .edgesIgnoringSafeArea(.all)
            
            // Background Blur Elements
            BlurredBackgroundElements()
            
            VStack(spacing: 20) {
                // Header
                Text("booklove.")
                    .font(.custom("NewYork", size: 55))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                // Main Content
                HStack( spacing: 20) {
                    VStack{ //card
                        // Quote
                        Text("You must allow me to tell you how ardently I love and admire you.")
                            .font(.custom("NewYorkLarge", size: 40))
                            .foregroundColor(.black)
                            .padding(.vertical)
                        
                        Text("-Mr. Darcy")
                            .font(.system(size: 20, weight: .regular, design: .rounded))
                            .foregroundColor(.black)
                        
                        // Book Information
                        Text("Pride and Prejudice")
                            .font(.custom("NewYork", size: 24))
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 0.18, blue: 0.33, alpha: 1)))
                        
                        Text("Jane Austen, 1813")
                            .font(.custom("SFMono", size: 20))
                            .foregroundColor(.black)
                        .kerning(-2)}.padding()
                        .background(Color.white.opacity(0.2))
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

struct BlurredBackgroundElements: View {
    var body: some View {
        ZStack {
            Image("blur_base")
                .resizable()
                .frame(width: 307, height: 293)
                .rotationEffect(Angle(degrees: -58))
                .offset(x: -130, y: -300)
                .blur(radius: 6)
            
            Image("blur_hex")
                .resizable()
                .frame(width: 375, height: 341)
                .rotationEffect(Angle(degrees: -6))
                .offset(x: 130, y: 300)
                .blur(radius: 6)
        }
    }
}


struct Feed_Previews: PreviewProvider {
    static var previews: some View {
        Quotes()
    }
}
