import SwiftUI

struct UserProfileHeaderView: View {
    @State var followed = false;
    var body: some View {
        HStack(spacing: 15) {
            // Profile Picture
            Image("memoji_placeholder")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .shadow(radius: 5)
            
            VStack(alignment: .leading, spacing: 5) {
                // User Name
                Text("Jane Appleseed")
                    .font(.system(size: 28, weight: .bold, design: .serif))
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
        
        .cornerRadius(10)
    }
}

struct UserProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileHeaderView()
    }
}
