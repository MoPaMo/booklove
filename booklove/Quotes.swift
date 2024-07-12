import SwiftUI

struct Quotes: View {
    var body: some View {
        ZStack {
            // Background Color
            BackgroundBlurElement()
            
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
                        ZStack {
                            // Shape with shadow
                            RoundedRectangle(cornerRadius: 37)
                                .fill(Color.white.opacity(0.1))
                                .frame(width: 311, height: 512)
                                .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
                                .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 4)

                            // Transparent card
                            RoundedRectangle(cornerRadius: 37)
                                .fill(Color.clear)
                                .frame(width: 311, height: 512)
                                .mask(RoundedRectangle(cornerRadius: 37))
                        }

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
