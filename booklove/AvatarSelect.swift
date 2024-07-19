import SwiftUI

struct ProfilePickerView: View {
    @State private var selectedAvatar: String?
    
    let avatars = [
        "https://cloud-3bai2vkkk-hack-club-bot.vercel.app/0avatar-1.png",
        "https://cloud-3bai2vkkk-hack-club-bot.vercel.app/1avatar-2.png",
        "https://cloud-3bai2vkkk-hack-club-bot.vercel.app/2avatar-3.png",
        "https://cloud-3bai2vkkk-hack-club-bot.vercel.app/3avatar-4.png",
        "https://cloud-3bai2vkkk-hack-club-bot.vercel.app/4avatar-5.png",
        "https://cloud-3bai2vkkk-hack-club-bot.vercel.app/5avatar-6.png",
        "https://cloud-3bai2vkkk-hack-club-bot.vercel.app/6avatar-7.png",
        "https://cloud-3bai2vkkk-hack-club-bot.vercel.app/7avatar-8.png",
        "https://cloud-3bai2vkkk-hack-club-bot.vercel.app/8avatar-9.png",
        "https://cloud-3bai2vkkk-hack-club-bot.vercel.app/9avatar-10.png"
    ]
    
    var body: some View {
        ZStack {
            BackgroundBlurElement().edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 50) {
                Text("Choose Your Avatar")
                    .font(.system(size: 32, weight: .regular, design: .serif))
                    .foregroundColor(.black)
                
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 20) {
                    ForEach(avatars, id: \.self) { avatarUrl in
                        Button(action: {
                            selectedAvatar = avatarUrl
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
                                    .stroke(selectedAvatar == avatarUrl ? Color.blue : Color.clear, lineWidth: 3)
                            )
                        }
                    }
                }
                .padding()
                
                Spacer()
                
                
                Button(action: {
                
                    if let selected = selectedAvatar {
                        print("Confirmed avatar: \(selected)")
                    }
                }) {
                    Text("Confirm Selection")
                        .font(.system(size: 20, design: .serif))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .disabled(selectedAvatar == nil)
                .padding(.bottom)
            }
            .padding(.leading, 18)
            .padding([.top, .bottom, .trailing])
        }
    }
}
