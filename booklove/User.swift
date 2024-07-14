import SwiftUI

struct UserProfileView: View {
    @State var followed = false;
    var body: some View {
        ZStack{
            BackgroundBlurElement()
            VStack{
                Text("booklove.")
                    .font(.system(size: 64, weight: .bold, design: .serif))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                    .padding(.bottom)
                
                HStack(spacing: 15) {
                    // Profile Picture
                    Image("memoji_placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        // User Name
                        Text("Jane Appleseed")
                            .font(.system(size: 30, weight: .bold, design: .serif))
                            .foregroundColor(.mint)
                        
                        // Favourite Book
                        Text("\(Image(systemName: "book.circle.fill")) Pride and Prejudice")
                            .font(.system( size: 18, weight:.regular))
                            .foregroundColor(.black)
                    }
                    
                    
                    Spacer()
                    
                    // Follow Button
                    Button(action: {
                        followed=(followed==false)
                    }) {
                        if(!followed){
                            Image(systemName: "heart")
                                .font(.title2)
                            .foregroundColor(.red)}
                        else{
                            Image(systemName: "heart.fill")
                                .font(.title2)
                                .foregroundColor(.red)
                        }
                    }
                }
                .padding()
                .background(Color.white.opacity(0.5).blur(radius: 10))
                
                .cornerRadius(10)
                
                Text("Favourite Genres").font(.system(size:20, weight:.light))
                
                
                HStack{
                    Text("Friends").font(.system(size:20, weight:.light))
                    
                    Spacer()
                    Text("See all").font(.system(size:20, weight:.light, design:.rounded)).foregroundColor(.blue)
                    
                }.padding(.horizontal)
                HStack {
                    Spacer()
                    
                    ZStack {
                        ForEach(0 ..< 5) { item in
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
                    .padding(.trailing, (61 + 5 * 35)/2)
                    .padding(.leading, 0)
                    
                    Spacer()
                }

                
                
                
                Text("Books").font(.system(size:20, weight:.light))
                Spacer()
            }
            
        }
    }
}

struct UserProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
