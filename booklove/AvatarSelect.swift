import SwiftUI
import Alamofire
struct ProfilePickerView: View {
    @State private var selectedAvatar: String?
    @State var loading = false
    var avatars = [
      "https://cloud-3bai2vkkk-hack-club-bot.vercel.app/0avatar-1.png",
      "https://cloud-3bai2vkkk-hack-club-bot.vercel.app/1avatar-2.png",
      "https://cloud-3bai2vkkk-hack-club-bot.vercel.app/2avatar-3.png",
      "https://cloud-3bai2vkkk-hack-club-bot.vercel.app/3avatar-4.png",
      "https://cloud-3bai2vkkk-hack-club-bot.vercel.app/4avatar-5.png",
      "https://cloud-3bai2vkkk-hack-club-bot.vercel.app/5avatar-6.png",
      "https://cloud-3bai2vkkk-hack-club-bot.vercel.app/6avatar-7.png",
      "https://cloud-3bai2vkkk-hack-club-bot.vercel.app/7avatar-8.png",
      "https://cloud-3bai2vkkk-hack-club-bot.vercel.app/8avatar-9.png",
      "https://cloud-3bai2vkkk-hack-club-bot.vercel.app/9avatar-10.png",
      "https://cloud-qm6njabq6-hack-club-bot.vercel.app/0avatar-11.png",
      "https://cloud-qm6njabq6-hack-club-bot.vercel.app/1avatar-12.png",
      "https://cloud-qm6njabq6-hack-club-bot.vercel.app/2avatar-13.png",
      "https://cloud-qm6njabq6-hack-club-bot.vercel.app/3avatar-14.png",
      "https://cloud-qm6njabq6-hack-club-bot.vercel.app/4avatar-15.png",
      "https://cloud-qm6njabq6-hack-club-bot.vercel.app/5avatar-16.png",
      "https://cloud-qm6njabq6-hack-club-bot.vercel.app/6avatar-17.png",
      "https://cloud-qm6njabq6-hack-club-bot.vercel.app/7avatar-18.png",
      "https://cloud-qm6njabq6-hack-club-bot.vercel.app/8avatar-19.png",
      "https://cloud-qm6njabq6-hack-club-bot.vercel.app/9avatar-20.png",
      "https://cloud-hvajgpmw4-hack-club-bot.vercel.app/0avatar-21.png",
      "https://cloud-hvajgpmw4-hack-club-bot.vercel.app/1avatar-22.png",
      "https://cloud-hvajgpmw4-hack-club-bot.vercel.app/2avatar-23.png",
      "https://cloud-hvajgpmw4-hack-club-bot.vercel.app/3avatar-24.png",
      "https://cloud-1f87v8q7h-hack-club-bot.vercel.app/0avatar-25.png",
      "https://cloud-1f87v8q7h-hack-club-bot.vercel.app/1avatar-26.png",
      "https://cloud-1f87v8q7h-hack-club-bot.vercel.app/2avatar-27.png",
      "https://cloud-1f87v8q7h-hack-club-bot.vercel.app/3avatar-28.png",
      "https://cloud-1f87v8q7h-hack-club-bot.vercel.app/4avatar-29.png",
      "https://cloud-1f87v8q7h-hack-club-bot.vercel.app/5avatar-30.png",
      "https://cloud-1f87v8q7h-hack-club-bot.vercel.app/6avatar-31.png",
      "https://cloud-1f87v8q7h-hack-club-bot.vercel.app/7avatar-32.png",
      "https://cloud-1f87v8q7h-hack-club-bot.vercel.app/8avatar-33.png",
      "https://cloud-1f87v8q7h-hack-club-bot.vercel.app/9avatar-34.png",
      "https://cloud-hvajgpmw4-hack-club-bot.vercel.app/4avatar-35.png",
      "https://cloud-hvajgpmw4-hack-club-bot.vercel.app/5avatar-36.png"
    ]
    
    init(){
        avatars.remix()
    }
    var body: some View {
        
        ZStack {
            BackgroundBlurElement().edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 50) {
                Text("Choose Your Avatar")
                    .font(.system(size: 32, weight: .regular, design: .serif))
                    .foregroundColor(.black)
                ScrollView{
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 20) {
                        ForEach(avatars, id: \.self) { avatarUrl in
                            Button(action: {
                                if(!loading){
                                selectedAvatar = avatarUrl}
                            }) {
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(width: 100, height: 100)
                                        .background(Color.white)
                                        .cornerRadius(20)
                                        .shadow(color: Color.black.opacity(0.2), radius: 6, y: 2)
                                    
                                    AsyncImage(url: URL(string: avatarUrl)) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 80, height: 80)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(selectedAvatar == avatarUrl ? Color.black : Color.clear, lineWidth: 3)
                                )
                            }
                        }
                    }.padding(.horizontal).padding(.top)
                    
                }
                
                
                
                Button(action: {
                    
                    if let selected = selectedAvatar {
                        loading = true
                        print("Confirmed avatar: \(selected)")
                        
                            let headers: HTTPHeaders = [
                                "Authorization": "Bearer \(SecureStorage.get() ?? "")",
                                "Content-Type": "application/json"
                            ]
                        AF.request("https://api.booklove.top/set/image", method: .post, parameters:["url":selected], headers: headers).responseString { response in
                                switch response.result {
                                case .success(let responseData):
                                    loading=false
                                case .failure(let error):
                                    loading = false
                                }
                            
                        }
                    }
                }) {
                    if(!loading){
                    Text("Confirm Selection")
                        .font(.system(size: 20, design: .serif))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(10)}
                    else{
                        ProgressView().font(.system(size: 20, design: .serif))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                }
                .disabled(selectedAvatar == nil)
                .padding(.bottom)
            }
            .padding(.leading, 18)
            .padding([.top, .bottom, .trailing])
        }
    }
}



extension Array {
    mutating func remix() {
        for i in 0..<(self.count - 1) {
            let j = Int(arc4random_uniform(UInt32(self.count - i))) + i
            self.swapAt(i, j)
        }
    }
}


#Preview {
    ProfilePickerView()
}
