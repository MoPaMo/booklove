import SwiftUI

struct Quotes: View {
    var body: some View {
        ZStack {
            // Background Color
            Color(red: 1, green: 0.98, blue: 0.98)
                .edgesIgnoringSafeArea(.all)
            
            // Background Blur Elements
            BlurredBackgroundElements()
            
            VStack(spacing: 20) {
                // Header
                Text("booklove.")
                    .font(.custom("NewYork", size: 55))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                // Main Content
                VStack(alignment: .leading, spacing: 20) {
                    // User Profile
                    HStack {
                        Image("profile")
                            .resizable()
                            .frame(width: 69, height: 69)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading) {
                            Text("Jane Appleseed")
                                .font(.system(size: 24, weight: .bold, design: .serif))
                            Text("is reading:")
                                .font(.system(size: 16, weight: .light))
                        }
                    }
                    
                    // Quote
                    Text("You must allow me to tell you how ardently I love and admire you.")
                        .font(.custom("NewYorkLarge", size: 40))
                        .foregroundColor(.black)
                        .padding(.vertical)
                    
                    Text("-Mr. Darcy")
                        .font(.system(size: 20, weight: .regular, design: .rounded))
                        .foregroundColor(.black)
                    
                    // Book Information
                    Text("Pride and Prejudice")
                        .font(.custom("NewYork", size: 24))
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 0.18, blue: 0.33, alpha: 1)))
                    
                    Text("Jane Austen, 1813")
                        .font(.custom("SFMono", size: 20))
                        .foregroundColor(.black)
                        .kerning(-2)
                    
                    // Interaction Buttons
                    HStack {
                        Image(systemName: "heart")
                        Image(systemName: "bookmark")
                        Image(systemName: "square.and.arrow.up")
                        Spacer()
                        Image(systemName: "flag")
                    }
                    .font(.system(size: 32))
                    .foregroundColor(.black)
                }
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(37)
                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 4)
                
                Spacer()
            }
            .padding(.top, 50)
            
            // Custom Tab Bar
            CustomTabBar()
        }
    }
}

struct BlurredBackgroundElements: View {
    var body: some View {
        ZStack {
            Image("blur_base")
                .resizable()
                .frame(width: 307, height: 293)
                .rotationEffect(Angle(degrees: -58))
                .offset(x: -130, y: -300)
                .blur(radius: 6)
            
            Image("blur_hex")
                .resizable()
                .frame(width: 375, height: 341)
                .rotationEffect(Angle(degrees: -6))
                .offset(x: 130, y: 300)
                .blur(radius: 6)
        }
    }
}

struct CustomTabBar: View {
    var body: some View {
        HStack {
            TabBarItem(icon: "calendar", label: "Today", isSelected: false)
            TabBarItem(icon: "quote.bubble", label: "Quotes", isSelected: true)
            TabBarItem(icon: "list.bullet", label: "List", isSelected: false)
            TabBarItem(icon: "person", label: "You", isSelected: false)
        }
        .padding()
        .background(Color.white.opacity(0.75))
        .cornerRadius(15)
        .padding(.horizontal)
        .padding(.bottom, 30)
    }
}

struct TabBarItem: View {
    let icon: String
    let label: String
    let isSelected: Bool
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.system(size: 18))
            Text(label)
                .font(.system(size: 10))
        }
        .foregroundColor(isSelected ? Color.blue : Color.gray)
    }
}

struct Feed_Previews: PreviewProvider {
    static var previews: some View {
        Quotes()
    }
}
