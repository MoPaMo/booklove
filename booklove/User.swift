import SwiftUI
import Alamofire


struct User: Decodable {
    var id: UUID
    var name: String
    var profile_image_url: String
    var favorite_book: String
}

struct UserProfileResponse: Decodable {
    var data: DataResponse
}
struct DataResponse : Decodable{
    var user: User
    var genres: [String]
    var books: [BookItem]?
}
struct UserProfileView: View {
    @State private var followed = false
    @State private var isSheetPresented = false
    @State private var user: User?
    @State private var genres: [String] = []
    @State private var books: [BookItem] = []
    var userID :UUID
    init(userID:UUID=SecureStorage.getID()){
        self.userID=userID
    }
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundBlurElement(option: 3)
                
                ScrollView {
                    VStack {
                        Text("booklove.")
                            .font(.system(size: 64, weight: .bold, design: .serif))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding(.top, 20)
                            .padding(.bottom)
                        
                        if let user = user {
                            HStack(spacing: 15) {
                                // Profile Picture
                                if(user.profile_image_url=="_default")
                                {AsyncImage(url: URL(string: user.profile_image_url)) { image in
                                    image.resizable()
                                } placeholder: {
                                    Image("memoji_placeholder").resizable()
                                }.aspectRatio(contentMode: .fill)
                                        .frame(width: 70, height: 70)
                                        .clipShape(Circle())
                                        .shadow(radius: 5)
                                }
                                else{
                                    Image("memoji_placeholder").resizable().aspectRatio(contentMode: .fill)
                                        .frame(width: 70, height: 70)
                                        .clipShape(Circle())
                                        .shadow(radius: 5)
                                }
                                
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    // User Name
                                    Text(user.name)
                                        .font(.system(size: 30, weight: .bold, design: .serif))
                                        .foregroundColor(.mint)
                                    
                                    // Favourite Book
                                    Text("\(Image(systemName: "book.circle.fill")) \(user.favorite_book)")
                                        .font(.system(size: 18, weight: .regular))
                                        .foregroundColor(.black)
                                }
                                
                                Spacer()
                                
                                // Follow Button
                                Button(action: {
                                    followed.toggle()
                                }) {
                                    Image(systemName: followed ? "heart.fill" : "heart")
                                        .font(.title2)
                                        .foregroundColor(.red)
                                }
                            }
                            .padding()
                            .background(Color.white.opacity(0.5).blur(radius: 10))
                            .cornerRadius(10)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Favourite Genres").font(.system(size: 20, weight: .light))
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(genres, id: \.self) { genre in
                                        Text(genre)
                                            .font(.system(size: 15, weight: .bold, design: .serif))
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 8)
                                            .background(Color.black)
                                            .foregroundColor(.white)
                                            .cornerRadius(20)
                                    }
                                }
                            }
                            .padding(.bottom, 20)
                        }
                        .padding(.leading)
                        
                        HStack {
                            Text("Friends").font(.system(size: 20, weight: .light))
                            Spacer()
                            Text("See all").font(.system(size: 20, weight: .light, design: .rounded)).foregroundColor(.blue)
                        }
                        .padding(.horizontal)
                        
                        HStack {
                            Spacer()
                            ZStack {
                                ForEach(0 ..< 5) { item in
                                    NavigationLink(destination: ProfileView()) {
                                        Image("memoji_placeholder")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 61, height: 61)
                                            .background(Color(red: 0.8, green: 0.8, blue: 0.8))
                                            .clipShape(Circle())
                                            .offset(x: CGFloat(item * 35))
                                            .shadow(
                                                color: Color(red: 0, green: 0, blue: 0, opacity: 0.25),
                                                radius: 4,
                                                y: 4
                                            )
                                    }
                                }
                            }
                            .padding(.trailing, (61 + 5 * 35) / 2)
                            .padding(.leading, 0)
                            Spacer()
                        }
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Books").font(.system(size: 20, weight: .light)).multilineTextAlignment(.leading)
                                Spacer()
                            }
                            VStack(alignment: .leading, spacing: 10) {
                                ForEach(books) { book in
                                    VStack(alignment: .leading) {
                                        Text(book.title)
                                            .font(.system(size: 24, weight: .bold, design: .serif))
                                            .foregroundColor(.cyan)
                                        
                                        Text("\(book.author), \(book.year)")
                                            .font(.system(size: 18, weight: .light, design: .serif))
                                            .foregroundColor(.black)
                                    }
                                    .padding(.bottom, 10)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.horizontal)
                
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "gearshape.circle.fill")
                            .foregroundColor(.black)
                            .font(.system(size: 32))
                            .padding()
                    }
                    Spacer()
                }
                .onTapGesture {
                    isSheetPresented = true
                }
            }
            .safeAreaInset(edge: .top) {
                ZStack {
                    Rectangle()
                        .fill(.clear)
                        .background(Color.white.opacity(1))
                        .blur(radius: 10)
                        .frame(height: 0)
                }
            }
            .sheet(isPresented: $isSheetPresented) {
                SettingsView()
            }
        }
        .onAppear {
            fetchUserProfile()
            //fetchBooks()
        }
    }
    
    private func fetchUserProfile() {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(SecureStorage.get() ?? "")",
            "Content-Type": "application/json"
        ]
        AF.request("https://api.booklove.top/user/self", method:.get, headers: headers).responseDecodable(of: UserProfileResponse.self) { response in
            switch response.result {
            case .success(let data):
                self.user = data.data.user
                self.genres = data.data.genres
                self.books = data.data.books ?? []
            case .failure(let error):
                print(error)
            }
        }
    }
    /*
    private func fetchBooks() {
        AF.request("https://api.booklove.top/users/self").responseDecodable(of: [BookItem].self) { response in
            switch response.result {
            case .success(let data):
                self.books = data
            case .failure(let error):
                print(error)
            }
        }
    }
     */
}

struct UserProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
