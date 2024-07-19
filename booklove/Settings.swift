//
//  Settings.swift
//  booklove
//
//  Created by Moritz on 12.07.24.
//

import SwiftUI
import UIKit

struct ShareSheet: UIViewControllerRepresentable {
    
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil
    
    @Environment(\.presentationMode) var presentationMode

    class Coordinator: NSObject, UIPopoverPresentationControllerDelegate {
        var parent: ShareSheet

        init(parent: ShareSheet) {
            self.parent = parent
        }

        func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        controller.popoverPresentationController?.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}

    static func dismantleUIViewController(_ uiViewController: UIActivityViewController, coordinator: Coordinator) {
        uiViewController.dismiss(animated: true)
    }
}

struct SettingsView: View {
    @State private var isShowingShareSheet = false
    @EnvironmentObject var appState: AppState
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundBlurElement().edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Text("Settings.")
                        .font(.system(size: 32, weight: .regular, design: .serif))
                        .foregroundColor(.black)
                    Spacer()
                    NavigationLink(destination: AccountView()) {
                        Text("Account")
                            .font(.system(size: 32, weight: .regular, design: .serif))
                            .foregroundColor(.black)
                    }
                    NavigationLink(destination: VendorView()) {
                        Text("Book Vendor")
                            .font(.system(size: 32, weight: .regular, design: .serif))
                            .foregroundStyle(.black)
                    }
                    Link("Feedback", destination: URL(string: "mailto:feedback@example.com")!)
                        .font(.system(size: 32, weight: .regular, design: .serif))
                        .foregroundColor(.black)
                    Button(action: {
                        isShowingShareSheet = true
                    }) {
                        Text("Tell A Friend")
                            .font(.system(size: 32, weight: .regular, design: .serif))
                            .foregroundColor(.black)
                    }
                    .sheet(isPresented: $isShowingShareSheet) {
                        ShareSheet(activityItems: ["Hey, come join me on booklove! booklove: new books, new friends.", URL(string: "https://get.booklove.top")!])
                            .presentationDetents([.medium, .large])
                            .presentationDragIndicator(.hidden)
                    }
                    Link("Terms Of Service", destination: URL(string: "https://example.com/tos")!)
                        .font(.system(size: 32, weight: .regular, design: .serif))
                        .foregroundColor(.black)
                    Link("Privacy Policy", destination: URL(string: "https://example.com/privacy")!)
                        .font(.system(size: 32, weight: .regular, design: .serif))
                        .foregroundColor(.black)
                    Text("Sign Out")
                        .font(.system(size: 32, weight: .regular, design: .serif))
                        .foregroundColor(.red).onTapGesture {
                            appState.isLoggedIn=SecureStorage.logout();
                            appState.userID=SecureStorage.get() ?? ""
                            appState.currentScreen = .welcome
                            
                        }
                    
                    Spacer()
                }
                .padding(.all)
            }
        }
    }
}

struct AccountView: View {
    var body: some View {
        ZStack {
            BackgroundBlurElement().edgesIgnoringSafeArea(.all)
            VStack(spacing: 50) {
               
                Text("Account.")
                    .font(.system(size: 32, weight: .regular, design: .serif))
                    .foregroundColor(.black)
                Spacer()
                Text("Set New Name")
                    .font(.system(size: 32, weight: .regular, design: .serif))
                Text("Download My Data")
                    .font(.system(size: 32, weight: .regular, design: .serif))
                Text("Delete Account")
                    .font(.system(size: 32, weight: .regular, design: .serif))
                    .foregroundColor(.red)
                
                Spacer()
            }
            .padding(.leading, 18)
            .padding([.top, .bottom, .trailing])
        }
    }
}

struct VendorView: View{
    @State var selected: String
    var vURL: String
    let searchURLs: [String: String] = [
        "Amazon": "https://www.amazon.com/s?k=",
        "eBay": "https://www.ebay.com/sch/i.html?_nkw=",
        "bookshop.org": "https://bookshop.org/search?keywords=",
        "Thrift Books": "https://www.thriftbooks.com/browse/?b.search=",
    ]
    init(){
        vURL = UserDefaults.standard.string(forKey: "vendorURL") ?? "https://www.amazon.com/s?k="
        selected = UserDefaults.standard.string(forKey: "vendorName") ?? "Amazon"

    }
    var body: some View{
        
        ZStack{
            BackgroundBlurElement().edgesIgnoringSafeArea(.all)
            VStack(spacing: 50) {
                
                Text("Vendor")
                    .font(.system(size: 32, weight: .regular, design: .serif))
                    .foregroundColor(.black)
                
                LazyVGrid(columns:[
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 10) {
                    ForEach(["Amazon", "eBay", "bookshop.org", "Thrift Books"], id: \.self) { title in
                        ZStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 34)
                                    .fill(Color.white)
                                    .frame(width: 161, height: 161)
                                    .shadow(color: Color.black.opacity(0.2), radius: 6, y: 2)
                                RoundedRectangle(cornerRadius: 34)
                                    .stroke(Color.black, lineWidth: selected == title ? 2 : 0)
                                    .frame(width: 161, height: 161)
                            }
                                
                            Text(title)
                                .font(.system(size: 24, design:.serif))
                                .foregroundColor(.black)
                        }.onTapGesture {
                            UserDefaults.standard.set(title, forKey: "vendorName")
                            print(UserDefaults.standard.string(forKey: "vendorName")as Any)
                            UserDefaults.standard.set(searchURLs[title], forKey: "vendorURL")
                            selected = title
                            
                        }
                    }
                }
                .padding()
                Spacer()
                VStack (spacing:10){
                    Image(systemName: "exclamationmark.triangle")
                        .font(.system(size:15, design:.serif))
                    Text("We do not earn money from book sales.")
                        .font(.system(size:15, design:.serif))
                    Button(action: {
                        let email = "vendor@booklove.top"
                        if let url = URL(string: "mailto:\(email)") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Text("Suggest A Vendor")
                            .font(.system(size:20, design:.serif))
                            .underline().foregroundStyle(.black)
                    }
                    
                }.padding(.bottom)
            }.padding(.leading, 18)
                .padding([.top, .bottom, .trailing])
                
                
            }
            
        }
    }


#Preview {
    SettingsView().environmentObject(AppState())
}
