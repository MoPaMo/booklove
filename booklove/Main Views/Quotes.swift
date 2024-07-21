import SwiftUI
struct QuoteData : Codable {
    var Quote: String
    var character : String
    var Book : BookItem
    var id = UUID()
    var liked: Bool
    var user: simpleUserData
}

struct Quotes: View {
    var body: some View {
        ZStack {
            // Background Color
            BackgroundBlurElement(option: 2)
            ScrollView{
                VStack(spacing: 20) {
                    
                    // Header
                    Text("booklove.")
                        .font(.system(size: 64, weight: .bold, design: .serif))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding(.top, 20).padding(.bottom, 50)
                    QuoteItem(data: QuoteData(Quote:"You shall not pass", character: "Gandalf", Book: BookItem(title: "LOTR", author: "JRR Tolkiens"), liked: false, user: simpleUserData(id: UUID(), name: "Mo", profile_image_url: "_default")))
                    QuoteItem(data: QuoteData(Quote:"You shall not pass, like really really really not. I'd raTher not ssee you pass. some umlaute: äöüß€", character: "Gandalf", Book: BookItem(title: "LOTR", author: "JRR Tolkiens"), liked: false, user: simpleUserData(id: UUID(), name: "Mo", profile_image_url: "_default")))
                    QuoteItem(data: QuoteData(Quote:"You shall not pass", character: "Gandalf", Book: BookItem(title: "LOTR", author: "JRR Tolkiens"), liked: false, user: simpleUserData(id: UUID(), name: "Mo", profile_image_url: "_default")))
                    QuoteItem(data: QuoteData(Quote:"You shall not pass", character: "Gandalf", Book: BookItem(title: "LOTR", author: "JRR Tolkiens"), liked: false, user: simpleUserData(id: UUID(), name: "Mo", profile_image_url: "_default")))
                    
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
    var data: QuoteData
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
                        Text("\(Image(systemName: "quote.opening")) \(data.Quote) \(Image(systemName: "quote.closing"))" )
                            .font(.system(size: 40*text_scale(textlength: data.Quote.count), weight: .ultraLight, design: .serif)).lineSpacing(-1)
                            .foregroundColor(.black)
                            
                        Spacer()
                        Text((data.character != "") ? "~ "+data.character : "")
                            .font(.system(size: 20, weight: .light, design: .rounded))
                            .foregroundColor(.black)
                        
                        // Book Information
                        Text(data.Book.title)
                            .font(.system(size: 24, weight: .heavy, design: .serif))
                        
                            .foregroundColor(.red)
                        
                        Text("\(data.Book.author), \(data.Book.year)")
                            .font(.system(size: 20, weight: .light, design: .monospaced))
                            .foregroundColor(.black)
                            .kerning(-2)
                    }.padding()
                    NavigationLink(destination: UserProfileView(userID: data.user.id))
                    {
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
                                    
                                    Image(data.user.profile_image_url)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 60, height: 60)
                                        .accessibilityLabel("\(data.user.name)'s profile picture")
                                }.offset(x:30,y:-30)
                                
                                    
                            }
                            Spacer()
                        }
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
    func text_scale (textlength:Int) -> CGFloat{
        if (textlength<90){
            return 1
        }
        else {
            return 90/CGFloat(textlength)
        }
    }
}


#Preview {
    Quotes()
}
