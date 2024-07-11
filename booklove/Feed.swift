import SwiftUI

struct BookLoveView: View {
    var body: some View {
        ZStack {
            // Background Color
            Color(red: 1, green: 0.98, blue: 0.98)
                .edgesIgnoringSafeArea(.all)
            
            // Background Blur Elements
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 307.14682, height: 292.85287)
                .background(
                    Image("blur_base")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 307.14682, height: 292.85287)
                        .clipped()
                )
                .cornerRadius(65)
                .shadow(color: .white.opacity(0.25), radius: 3, x: -10, y: 4)
                .blur(radius: 6)
                .rotationEffect(Angle(degrees: -58.16))
                .offset(x: -130, y: -300)
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 375.42, height: 341.27)
                .background(
                    Image("blur_hex")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                )
                .cornerRadius(65)
                .offset(x: 130, y: 300)
                .rotationEffect(.degrees(-6.25))
                .blur(radius: 6)
            
            VStack {
                Text("booklove.")
                    .font(.system(size: 64, weight: .bold, design: .serif))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        Text("Jane Appleseed")
                            .font(.system(size: 20, weight: .regular, design: .serif))
                            .foregroundColor(.blue)
                    }
                    
                    Text("is reading:")
                        .font(.system(size: 16, weight: .regular, design: .monospaced))
                        .foregroundColor(.black)
                    
                    Text("Pride and Prejudice")
                        .font(.system(size: 24, weight: .bold, design: .serif))
                        .foregroundColor(.blue)
                    
                    Text("Jane Austen, 1813")
                        .font(.system(size: 18, weight: .regular, design: .serif))
                        .foregroundColor(.black)
                    
                    Text("""
                    Mr Bennet, owner of the Longbourn estate in Hertfordshire, has five daughters, but his property is entailed and can only be passed to a male heir. His wife also lacks an inheritance, so his family faces becoming poor upon his death. Thus, it is imperative that at least one of the daughters marry well to support the others, which is a primary motivation driving the plot.
                    """)
                        .font(.system(size: 14, weight: .regular, design: .serif))
                        .foregroundColor(.black)
                        .padding(.top, 10)
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                HStack {
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width: 24, height: 24)
                    Spacer()
                    Image(systemName: "bookmark")
                        .resizable()
                        .frame(width: 24, height: 24)
                    Spacer()
                    Image(systemName: "square.and.arrow.up")
                        .resizable()
                        .frame(width: 24, height: 24)
                    Spacer()
                    Image(systemName: "text.bubble")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
                
                Spacer()
            }
        }
    }
}

#Preview {
    BookLoveView()
}
