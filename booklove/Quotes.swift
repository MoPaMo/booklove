import SwiftUI

struct Quotes: View {
    var body: some View {
        ZStack {
            // Background Color
            BackgroundBlurElement()
            ScrollView{
                VStack(spacing: 20) {
                    
                    // Header
                    Text("booklove.")
                        .font(.system(size: 64, weight: .bold, design: .serif))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding(.top, 20).padding(.bottom, 50)
                    QuoteItem()
                    QuoteItem()
                    QuoteItem()
                    QuoteItem()
                    
                }
            }
            VStack{
                HStack{
                    Spacer()
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(7), Color.white.opacity(7)]),
                                               startPoint: .topLeading,
                                               endPoint: .bottomTrailing)
                            )
                            .frame(width: 32, height: 32)
                            .blur(radius: 10)
                        
                        Image(systemName: "plus.circle.fill").font(.system(size: 32))
                    }
                    

                }.padding()
                Spacer()
            }
        }
    }
    
}

struct QuoteItem: View {
    var body: some View {
        GeometryReader { geometry in
        // Main Content
        HStack() {
            
                ZStack{ //card
                    ZStack {
                        // Shape with shadow
                        RoundedRectangle(cornerRadius: 37)
                            .fill(Color.white.opacity(0.1))
                            
                            .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
                            .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 4)
                        
                        // Transparent card
                        RoundedRectangle(cornerRadius: 37)
                            .fill(Color.white.opacity(0.55)).blur(radius: /*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                            
                            .mask(RoundedRectangle(cornerRadius: 37))
                    }
                    VStack (alignment: .leading){
                        // Quote
                        Text("      You must allow me to tell you how ardently I love and admire you.")
                            .font(.system(size: 40, weight: .ultraLight, design: .serif)).lineSpacing(-1)
                            .foregroundColor(.black)
                            
                        Spacer()
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
                            .kerning(-2)
                    }.padding()
                    VStack{
                        HStack{
                            Spacer()
                            ZStack {
                                Circle()
                                    .fill(
                                        LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.white.opacity(0.3)]),
                                                       startPoint: .topLeading,
                                                       endPoint: .bottomTrailing)
                                    )
                                    .frame(width: 70, height: 70)
                                    .blur(radius: 10)
                                
                                Image("memoji_placeholder")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 60, height: 60)
                            }.offset(x:30,y:-30)
                            
                                
                        }
                        Spacer()
                    }
                }.frame(width: geometry.size.width*0.75).padding()
                // Interaction Buttons
                VStack {
                    Image(systemName: "heart").padding(.bottom, 10)
                    Image(systemName: "bookmark").padding(.bottom, 10)
                    Image(systemName: "square.and.arrow.up")
                    Spacer()
                    Image(systemName: "flag")
                }.padding(.vertical, 30)
                .font(.system(size: 32))
                .foregroundColor(.black)
        }
            
            
            Spacer()
        }.frame(height: 512)
    }
}
#Preview {
    Quotes()
}
