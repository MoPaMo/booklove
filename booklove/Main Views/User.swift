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
struct DataResponse: Decodable {
    var user: User
    var genres: [String]
    var books: [BookItem]?
    var followed: Bool
    var followers: [simpleUserData]?
}
struct UserProfileView: View {
    @State private var followed = false
    @State private var isSheetPresented = false
    @State private var isShareSheetPresented = false
    @State private var user: User?
    @State private var genres: [String] = []
    @State private var books: [BookItem] = []
    @State private var follow_loading = false;
    var userID: UUID
    var appuserID: UUID
    var isownaccount: Bool
    init(userID: UUID) {
        self.appuserID = UUID(uuidString: SecureStorage.getID() ?? "") ?? UUID()
        self.userID = userID
        self.isownaccount = self.userID == self.appuserID
    }
    @State var followers:[simpleUserData]=[]
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
                            .padding(.bottom).onTapGesture {
                                fetchUserProfile()
                            }

                        if let user = user {
                            HStack(spacing: 15) {
                                // Profile Picture
                                if (user.profile_image_url != "_default") {
                                    AsyncImage(url: URL(string: user.profile_image_url)) { image in
                                        image.resizable()
                                    } placeholder: {
                                        Image("memoji_placeholder").resizable()
                                    }.aspectRatio(contentMode: .fill)
                                        .frame(width: 70, height: 70)
                                        .clipShape(Circle())
                                        .shadow(radius: 5)
                                } else {
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
                                    
                                    follow_request()
                                }) {
                                    if(!follow_loading){
                                    Image(systemName: followed ? "heart.fill" : "heart")
                                        .font(.title2)
                                        .foregroundColor(.red)}
                                    else{
                                        ProgressView()
                                    }
                                }
                            }
                            .disabled(follow_loading)
                            .padding()
                            .background(Color.white.opacity(0.5).blur(radius: 10))
                            .cornerRadius(10)
                        }

                        VStack(alignment: .leading) {
                            Text("Favourite Genres").font(.system(size: 20, weight: .light))

                            if genres.isEmpty {
                                Text("\(Image(systemName: "nosign")) No genres yet")
                                    .font(.system(size: 16, weight: .regular, design: .monospaced))
                                    .foregroundColor(.gray)
                                    .padding(.top, 10)
                            } else {
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
                        }
                        .padding(.leading)

                        VStack {
                            HStack {
                                Text("Friends").font(.system(size: 20, weight: .light))
                                Spacer()
                                NavigationLink(destination: AllFollowersView(followers: self.followers)) {
                                    Text("See all").font(.system(size: 20, weight: .light, design: .rounded)).foregroundColor(.blue)
                                }
                            }
                            .padding(.horizontal)

                            ZStack {
                                ForEach(Array(self.followers.prefix(5).enumerated()), id: \.element.id) { index, follower in
                                    NavigationLink(destination: UserProfileView(userID: follower.id)) {
                                        AsyncImage(url: URL(string: follower.profile_image_url)) { phase in
                                            switch phase {
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                            case .failure(_), .empty:
                                                Image("memoji_placeholder")
                                                    .resizable()
                                            @unknown default:
                                                Image("memoji_placeholder")
                                                    .resizable()
                                            }
                                        }
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 61, height: 61)
                                        .background(Color(red: 0.8, green: 0.8, blue: 0.8))
                                        .clipShape(Circle())
                                        .offset(x: CGFloat(index * 35))
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
                        }

                        VStack(alignment: .leading) {
                            HStack {
                                Text("Books").font(.system(size: 20, weight: .light)).multilineTextAlignment(.leading)
                                Spacer()
                            }
                            if books.isEmpty {
                                Text("\(Image(systemName: "nosign")) Looks like this reader doesn't have any books in their list yet. You can befriend them to recommend some!")
                                    .font(.system(size: 16, weight: .regular, design: .monospaced))
                                    .foregroundColor(.gray)
                                    .padding(.top, 10).multilineTextAlignment(.center)
                            } else {
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
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.horizontal)

                VStack {
                    HStack {
                        Spacer()
                        if (!isownaccount){
                            Button(action: {
                                let textToShare = "\(user?.name ?? "Reader") on booklove. "
                                let activityVC = UIActivityViewController(activityItems: ["booklove://book/?id=\(user?.id.uuidString ?? "error")", textToShare], applicationActivities: nil)
                                UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
                            }) {Image(systemName: "square.and.arrow.up.circle.fill")
                                    .foregroundColor(.black)
                                    .font(.system(size: 32))
                                .padding()}
                        }else{
                        Image(systemName:  "gearshape.circle.fill")
                            .foregroundColor(.black)
                            .font(.system(size: 32))
                            .padding()}
                    }
                    Spacer()
                }
                .onTapGesture {
                    if (isownaccount) {
                        isSheetPresented = true
                    }
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
            .sheet(isPresented: $isShareSheetPresented) {
                ShareSheet(activityItems: [
                    isownaccount ? "Come join me on booklove: new books, new friends" : "Check out this user on booklove: new books, new friends",
                    URL(string: "https://api.booklove.com/join/user/" + userID.uuidString)!
                ])
            }
        }
        
        .task {
            fetchUserProfile()
        }
    }

    private func fetchUserProfile() {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(SecureStorage.get() ?? "")",
            "Content-Type": "application/json"
        ]
        AF.request("https://api.booklove.top/user/\(userID.uuidString)", method: .get, headers: headers).responseDecodable(of: UserProfileResponse.self) { response in
            switch response.result {
            case .success(let data):
                self.user = data.data.user
                self.genres = data.data.genres
                self.books = data.data.books ?? []
                self.followed = data.data.followed
                self.followers = data.data.followers ?? []
            case .failure(let error):
                print(error)
            }
        }
    }
    func follow_request(){
        if(isownaccount){
            follow_loading = true;
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(SecureStorage.get() ?? "")",
                "Content-Type": "application/json"
            ]
            AF.request("https://api.booklove.top/\(followed ? "unfollow" : "follow")/\(userID.uuidString)", method: .get, headers: headers).responseString{ response in
                switch response.result {
                case .success(let _data):
                    followed.toggle()
                    follow_loading = false
                case .failure(let error):
                    follow_loading = false
                    print(error)
                }
                
            }
        }
    }
}

struct simpleUserData : Codable {
    var id: UUID
    var name: String
    var profile_image_url: String
}

struct UserProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(userID: UUID(uuidString: SecureStorage.getID() ?? "") ?? UUID())
    }
}


struct AllFollowersView: View {
    let followers: [simpleUserData]
    
    var body: some View {
        ZStack{
            BackgroundBlurElement(option: 3)
            ScrollView {
                if followers.isEmpty {
                    VStack {
                        Spacer()
                        Text("This user doesn't have any friends yet, be the first to become friends with them!")
                            .font(.system(size: 20, design: .monospaced))
                            .foregroundColor(.secondary).padding()
                        Spacer()
                    }
                } else {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 20) {
                        ForEach(followers, id: \.id) { follower in
                            NavigationLink(destination: UserProfileView(userID: follower.id)) {
                                VStack {
                                    AsyncImage(url: URL(string: follower.profile_image_url)) { phase in
                                        switch phase {
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                        case .failure(_), .empty:
                                            Image("memoji_placeholder")
                                                .resizable()
                                        @unknown default:
                                            Image("memoji_placeholder")
                                                .resizable()
                                        }
                                    }
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
                                    
                                    Text(follower.name)
                                        .font(.caption)
                                        .lineLimit(1)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                }
            }
        }
    }
}
