import SwiftUI
import Alamofire
struct QuoteData : Codable {
    var Quote: String
    var character : String
    var Book : BookItem
    var id = UUID()
    var liked: Bool
    var user: simpleUserData
    var bookSaved : Bool = false
}
struct QuoteResponse : Codable{
    var rows : [QuoteData]
}
struct Quotes: View {
    @State var rows : [QuoteData] = []
    var body: some View {
        NavigationView{
            ZStack {
                // Background Color
                BackgroundBlurElement(option: 2)
                ScrollView{
                    LazyVStack(spacing: 20) {
                        
                        // Header
                        Text("booklove.")
                            .font(.system(size: 64, weight: .bold, design: .serif))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding(.top, 20).padding(.bottom, 50).onTapGesture {
                                rows=[]
                                loadNewQuotes()
                            }
                        /*QuoteItem(quoteData: QuoteData(Quote:"You shall not pass", character: "Gandalf", Book: BookItem(title: "LOTR", author: "JRR Tolkiens"), liked: false, user: simpleUserData(id: UUID(), name: "Mo", profile_image_url: "_default")))
                         QuoteItem(quoteData: QuoteData(Quote:"You shall not pass, like really really really not. I'd raTher not ssee you pass. some umlaute: äöüß€", character: "Gandalf", Book: BookItem(title: "LOTR", author: "JRR Tolkiens"), liked: false, user: simpleUserData(id: UUID(), name: "Mo", profile_image_url: "_default")))
                         QuoteItem(quoteData: QuoteData(Quote:"You shall not pass", character: "Gandalf", Book: BookItem(title: "LOTR", author: "JRR Tolkiens"), liked: true, user: simpleUserData(id: UUID(), name: "Mo", profile_image_url: "_default")))
                         QuoteItem(quoteData: QuoteData(Quote:"You shall not pass", character: "Gandalf", Book: BookItem(title: "LOTR", author: "JRR Tolkiens"), liked: false, user: simpleUserData(id: UUID(), name: "Mo", profile_image_url: "_default")))*/
                        ForEach(rows, id: \.id){quote in
                            QuoteItem(quoteData: quote)
                        }
                        if !rows.isEmpty {
                            ProgressView()
                                .padding()
                                .onAppear {
                                    loadNewQuotes()
                                }
                        }
                    }.onAppear(perform:loadNewQuotes)
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
    func loadNewQuotes(){
        print("loading")
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(SecureStorage.get() ?? "")",
            "Content-Type": "application/json"
        ]
        AF.request("https://api.booklove.top/quote/get", method: .get, encoding: JSONEncoding.default, headers: headers).responseDecodable(of: QuoteResponse.self) { response in
            switch response.result {
            case .success(let responseData):
                print(responseData)
                self.rows.append(contentsOf:responseData.rows)
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
}

struct QuoteItem: View {
    @State var data: QuoteData
    init (quoteData:QuoteData){
        data = quoteData
    }
    var body: some View {
        GeometryReader { geometry in
        // Main Content
        HStack() {
            
                    ZStack{ //card
                        NavigationLink (destination:Book(book: data.Book.id))
                        {
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
                        }
                        NavigationLink (destination:Book(book: data.Book.id))
                        {VStack (alignment: .leading){
                            // Quote
                            Text("\(Image(systemName: "quote.opening")) \(data.Quote) \(Image(systemName: "quote.closing"))" )
                                .font(.system(size: 40*text_scale(textlength: data.Quote.count), weight: .ultraLight, design: .serif)).lineSpacing(-1).multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
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
                        }.padding()}
                        
                            VStack{
                                HStack{
                                    Spacer()
                                    NavigationLink(destination: UserProfileView(userID: data.user.id))
                                    {
                                        ZStack {
                                            Circle()
                                                .fill(
                                                    LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.white.opacity(0.3)]),
                                                                   startPoint: .topLeading,
                                                                   endPoint: .bottomTrailing)
                                                )
                                                .frame(width: 70, height: 70)
                                                .blur(radius: 10)
                                            AsyncImage(url: URL(string: data.user.profile_image_url)) { image in
                                                image.resizable()
                                            } placeholder: {
                                                Image("memoji_placeholder").resizable()
                                            }
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 60, height: 60)
                                            .accessibilityLabel("\(data.user.name)'s profile picture")
                                        }.offset(x:30,y:-30)
                                    }
                                        
                                }
                                Spacer()
                            }
                        }
                    .frame(width: geometry.size.width*0.75).padding()
                
                // Interaction Buttons
                VStack {
                    Image(systemName: data.liked ? "heart.fill" : "heart").foregroundStyle(data.liked ? .red : .black).padding(.bottom, 10).onTapGesture {
                        like_quote()
                    }.animation(.easeInOut(duration: 0.125), value: data.liked)
                    Image(systemName: data.bookSaved ? "bookmark.fill" : "bookmark").foregroundStyle(data.bookSaved ? .orange : .black).padding(.bottom, 10) .onTapGesture {
                        withAnimation(.spring()) {
                            like_book()
                        }
                    }
                    .animation(.easeInOut(duration: 0.125), value: data.bookSaved)
                    Button(action: {
                        let textToShare = "\(data.Quote) quoted by \(data.user.name) on booklove. booklove: new books, new friends"
                        let activityVC = UIActivityViewController(activityItems: [textToShare, "booklove://book/?id=\(data.Book.id.uuidString)"], applicationActivities: nil)
                        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
                    }){
                    Image(systemName: "square.and.arrow.up")}
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
     func like_quote (){
         print("liked")
         data.liked = !data.liked
         booklove.like_quote(id: data.id, like:data.liked)
        
    }
    func like_book (){
        print("liked")
        data.bookSaved = !data.bookSaved
        booklove.like_book(id: data.Book.id, like: data.bookSaved)
       
   }
}
func like_quote(id:UUID, like:Bool=true)  {
    let url = (like ? "https://api.booklove.top/book/like/" :"https://api.booklove.top/quote/unlike/") + id.uuidString
    let headers: HTTPHeaders = [
        "Authorization": "Bearer \(SecureStorage.get() ?? "")",
        "Content-Type": "application/json"
    ]
    AF.request(url, method:.get, headers: headers).responseString {
        response in
        switch response.result {
          case .success(let responseBody):
              print("Response body: \(responseBody)")
            if(responseBody=="success")
            {
                
            }
              // Do something with the response body string
          case .failure(let error):
              print("Error: \(error)")
              // Handle the error
          }
    }
}

#Preview {
    Quotes()
}
