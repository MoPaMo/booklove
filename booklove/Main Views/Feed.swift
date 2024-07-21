import SwiftUI
import Alamofire

struct Feed: View {
    @State private var isSheetPresented = false;
    
    @EnvironmentObject var tabViewModel: TabViewModel
    @State var boooks: [BookEntry] = []
    var body: some View {
        NavigationView {
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
                    ForEach (boooks)
                        {boook in
                            bookloverecommendedBook(book: boook.book, desc: boook.desc).padding(.bottom)}
                    Text("More content coming soon :)")
                    /*singleBookReview(book:BookItem(title: "Pride and Prejudice", author: "Jane Austen", year: "1813")).padding(.bottom)
                    recommendedUsers().padding(.leading, 30).background(Color.white.opacity(0.9).blur(radius: 1))
                    
                        .cornerRadius(10)
                    singleBookReview(book:BookItem(title: "Sense and Sensibility", author: "Jane Austen", year: "1811")).padding(.bottom)
                    
                    singleBookReview(book: BookItem(title: "Northanger Abbey", author: "Jane Austen", year: "1818"))
                    Text("This is a prototype app.")
                        .padding()
                        .background(Color.red.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .transition(.opacity)*/
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
            }
            .safeAreaInset(edge: .top) {
                ZStack {
                    Rectangle()
                        .fill(.clear)
                        .background(Color.white.opacity(1))
                        .blur(radius: 10)
                        .frame(height: 0)
                }
            }.onAppear(perform: fetchBooks)
        }
    }
    func fetchBooks (){
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(SecureStorage.get() ?? "")",
            "Content-Type": "application/json"
        ]
        AF.request("https://api.booklove.top/recommendations", method: .get, encoding: JSONEncoding.default, headers: headers).responseDecodable(of: ResponseModel.self) { response in
            switch response.result {
            case .success(let responseData):
                print(responseData)
                self.boooks = responseData.data
            case .failure(let error):
                print(error)
            }
            
        }
    }
}

struct singleBookReview : View{
    @EnvironmentObject var tabViewModel: TabViewModel
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
                
                NavigationLink(destination: UserProfileView(userID: UUID(uuidString: SecureStorage.getID() ?? "") ?? UUID() ))
                {
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
                
            }
            
            
            
            NavigationLink(destination: Book(book: UUID.init(uuidString: "933952f3-a265-4dc0-b2f6-0179c7e29529") ?? UUID())){
                VStack (alignment: .leading){
                    Text(book.title)
                        .font(.system(size: 24, weight: .heavy, design: .serif))
                        .foregroundColor(.cyan).padding(.bottom, -10)
                    
                    Text("\(book.author), \(book.year)")
                        .font(.system(size: 18, weight: .light, design: .monospaced))
                    .foregroundColor(.black).kerning(-2)}}.buttonStyle(PlainButtonStyle())
            
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
struct bookloverecommendedBook: View {
    @EnvironmentObject var tabViewModel: TabViewModel
    var book: BookItem
    var desc: String
    
    var body: some View {
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
                    
                    Image("Icon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                        .cornerRadius(23)
                }
                
                VStack(alignment: .leading) {
                    Text("booklove")
                        .font(.system(size: 24, weight: .bold, design: .serif))
                        .foregroundColor(.mint)
                    
                    Text("recommends for you:")
                        .font(.system(size: 16, weight: .light, design: .rounded))
                        .foregroundColor(.black)
                }
                .padding(.leading, 10)
            }
            
            NavigationLink(destination: Book(book: book.id)) {
                VStack(alignment: .leading) {
                    Text(book.title)
                        .font(.system(size: 24, weight: .heavy, design: .serif))
                        .foregroundColor(.cyan)
                        .padding(.bottom, -10)
                    
                    Text("\(book.author), \(book.year)")
                        .font(.system(size: 18, weight: .light, design: .monospaced))
                        .foregroundColor(.black)
                        .kerning(-2)
                    
                    Text(desc)
                        .font(.system(size: 16, weight: .light, design: .serif))
                        .foregroundColor(.black)
                        .lineLimit(3)
                        .truncationMode(.tail)
                        .padding(.top, 1)
                    
                    if desc.count > 200 {
                        Text("more")
                            .font(.system(size: 16, weight: .bold, design: .serif))
                            .foregroundColor(.blue)
                    }
                }
            }
            .buttonStyle(PlainButtonStyle())
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: 0.5)
                .overlay(Rectangle().stroke(.black, lineWidth: 0.5))
                .padding(.vertical, 2)
            
            HStack {
                Image(systemName: "heart")
                    .font(.system(size: 32))
                    .foregroundColor(.black)
                
                Image(systemName: "bookmark")
                    .font(.system(size: 32))
                    .foregroundColor(.black)
                
                Button(action: {
                    let textToShare = "\(book.title) by \(book.author) on booklove. "
                    let activityVC = UIActivityViewController(activityItems: ["booklove://book/?id=\(book.id.uuidString)", textToShare], applicationActivities: nil)
                    UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
                }){
                    Image(systemName: "square.and.arrow.up")
                        .font(.system(size: 32)).foregroundColor(.black)
                }
                Spacer()
                
                Image(systemName: "flag")
                    .font(.system(size: 32))
                    .foregroundColor(.black)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 33)
    }
}

struct recommendedUsers: View {
    @EnvironmentObject var tabViewModel: TabViewModel

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


struct BookEntry: Codable, Identifiable {
    let id = UUID()
    let book: BookItem
    let desc: String
}

struct ResponseModel: Codable{
    let data: [BookEntry]
}

#Preview {
    Feed().environmentObject(TabViewModel())
}
