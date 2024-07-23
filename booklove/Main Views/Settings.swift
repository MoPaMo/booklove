//
//  Settings.swift
//  booklove
//
//  Created by Moritz on 12.07.24.
//

import SwiftUI
import UIKit
import Alamofire
import QuickLook


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
                    Link("Feedback", destination: URL(string: "mailto:booklove@duck.com?subject=Feedback")!)
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
                    NavigationLink(destination: AcknowledgementsView()){
                        Text("Acknowledgments")
                            .font(.system(size: 32, weight: .regular, design: .serif))
                            .foregroundColor(.black)
                    }
                    Link("Terms Of Service", destination: URL(string: "https://api.booklove.top/docs/tos")!)
                        .font(.system(size: 32, weight: .regular, design: .serif))
                        .foregroundColor(.black)
                    Link("Privacy Policy", destination: URL(string: "https://api.booklove.top/docs/privacy")!)
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





// Account View
struct AccountView: View {
    @State private var showDeleteConfirmation = false
    @State private var showDeleteSuccessAlert = false
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appState:AppState

    var body: some View {
        ZStack {
            BackgroundBlurElement().edgesIgnoringSafeArea(.all)
            VStack(spacing: 50) {
                Text("Account.")
                    .font(.system(size: 32, weight: .regular, design: .serif))
                    .foregroundColor(.black)
                Spacer()
                NavigationLink(destination: SettingsName()) {
                    Text("Set New Name & Book")
                        .font(.system(size: 32, weight: .regular, design: .serif)).foregroundStyle(.black)
                }
                NavigationLink(destination: ProfilePickerSettingsView()) {
                    Text("Set New Avatar")
                        .font(.system(size: 32, weight: .regular, design: .serif))
                        .foregroundStyle(.black)
                }
                Link("Download My Data", destination: URL(string: "https://api.booklove.top/download-my-data/\(SecureStorage.get()?.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")")!)
                    .font(.system(size: 32, weight: .regular, design: .serif))
                    .foregroundColor(.black)
                
                Button(action: {
                    showDeleteConfirmation = true
                }) {
                    Text("Delete Account")
                        .font(.system(size: 32, weight: .regular, design: .serif))
                        .foregroundColor(.red)
                }
                
                Spacer()
            }
            .padding(.leading, 18)
            .padding([.top, .bottom, .trailing])
        }
        .confirmationDialog("Are you sure you want to delete your account?", isPresented: $showDeleteConfirmation, titleVisibility: .visible) {
            Button("Delete", role: .destructive) {
                deleteAccount()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This action cannot be undone.")
        }
        .alert("Account Deleted", isPresented: $showDeleteSuccessAlert) {
            Button("OK") {
                presentationMode.wrappedValue.dismiss()
            }
        } message: {
            Text("Your account has been successfully deleted.")
        }
    }
    
    func deleteAccount() {
        guard let token = SecureStorage.get() else {
            print("No token found")
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request("https://api.booklove.top/account/delete", method: .delete, headers: headers)
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    print("Account deleted successfully")
                    showDeleteSuccessAlert = true;
                    SecureStorage.logout()
                    appState.isLoggedIn = false
                    appState.userID = ""
                    appState.token = ""
                    appState.currentScreen = .welcome
                    
                case .failure(let error):
                    print("Failed to delete account: \(error.localizedDescription)")
                    // Here you might want to show an error alert to the user
                }
            }
    }
}


struct AcknowledgementsView: View {
    var body: some View {
        ZStack {
            BackgroundBlurElement().edgesIgnoringSafeArea(.all)
            VStack(spacing: 50) {
               
                Text("""
                    This Project uses data from the OpenLibrary API.
                     
                    
                    This Project uses Alamofire
                    
                     Copyright (c) 2014-2022 Alamofire Software Foundation (http://alamofire.org/)

                     Permission is hereby granted, free of charge, to any person obtaining a copy
                     of this software and associated documentation files (the "Software"), to deal
                     in the Software without restriction, including without limitation the rights
                     to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
                     copies of the Software, and to permit persons to whom the Software is
                     furnished to do so, subject to the following conditions:

                     The above copyright notice and this permission notice shall be included in
                     all copies or substantial portions of the Software.

                     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
                     IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
                     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
                     AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
                     LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
                     OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
                     THE SOFTWARE.
                    """)
                    .font(.system(size: 16, weight: .regular, design: .monospaced))
                    .foregroundColor(.black)
               
                
                Spacer()
            }
            .padding(.leading, 18)
            .padding([.top, .bottom, .trailing])
        }
    }
}

struct VendorView: View {
    @State private var selected: String
    @State private var customVendorName: String = ""
    @State private var customVendorURL: String = ""
    @State private var showingCustomVendorSheet: Bool = false
    @State private var vendors: [String: String]
    
    init() {
        let savedVendors = UserDefaults.standard.dictionary(forKey: "customVendors") as? [String: String] ?? [:]
        let defaultVendors: [String: String] = [
            "Amazon": "https://www.amazon.com/s?k=",
            "eBay": "https://www.ebay.com/sch/i.html?_nkw=",
            "bookshop.org": "https://bookshop.org/search?keywords=",
            "Thrift Books": "https://www.thriftbooks.com/browse/?b.search=",
            "Better World Books" : "https://www.betterworldbooks.com/search/results?q="
        ]
        self.vendors = defaultVendors.merging(savedVendors) { (_, new) in new }
        self._selected = State(initialValue: UserDefaults.standard.string(forKey: "vendorName") ?? "Amazon")
    }
    
    var body: some View {
        ZStack {
            BackgroundBlurElement().edgesIgnoringSafeArea(.all)
            VStack(spacing: 50) {
                Text("Vendor")
                    .font(.system(size: 32, weight: .regular, design: .serif))
                    .foregroundColor(.black)
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                        ForEach(Array(vendors.keys.sorted()), id: \.self) { title in
                            VendorButton(title: title, selected: $selected, vendors: $vendors)
                        }
                        AddCustomVendorButton(showingCustomVendorSheet: $showingCustomVendorSheet)
                    }
                    .padding()
                }
                
                Spacer()
                
                VStack(spacing: 10) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.system(size: 15, design: .serif))
                    Text("We do not earn money from book sales.")
                        .font(.system(size: 15, design: .serif))
                    Button("Suggest A Vendor") {
                        if let url = URL(string: "mailto:booklove@duck.com?subject=Vendor%20Suggestion&body=Vendor%20Name%3A%0AVendor%20URL%3A%0AContext%3A") {
                            UIApplication.shared.open(url)
                        }
                    }
                    .font(.system(size: 20, design: .serif))
                    .underline()
                    .foregroundStyle(.black)
                }
                .padding(.bottom)
            }
            .padding(.leading, 18)
            .padding([.top, .bottom, .trailing])
        }
        .sheet(isPresented: $showingCustomVendorSheet) {
            CustomVendorSheet(vendors: $vendors, selected: $selected, showingSheet: $showingCustomVendorSheet)
        }
    }
}

struct VendorButton: View {
    let title: String
    @Binding var selected: String
    @Binding var vendors: [String: String]
    
    var body: some View {
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
                .font(.system(size: 24, design: .serif))
                .foregroundColor(.black)
        }
        .onTapGesture {
            UserDefaults.standard.set(title, forKey: "vendorName")
            UserDefaults.standard.set(vendors[title], forKey: "vendorURL")
            selected = title
        }
    }
}

struct AddCustomVendorButton: View {
    @Binding var showingCustomVendorSheet: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 34)
                .fill(Color.white)
                .frame(width: 161, height: 161)
                .shadow(color: Color.black.opacity(0.2), radius: 6, y: 2)
            
            VStack {
                Image(systemName: "plus")
                    .font(.system(size: 40))
                Text("Add Custom")
                    .font(.system(size: 20, design: .serif))
            }
            .foregroundColor(.black)
        }
        .onTapGesture {
            showingCustomVendorSheet = true
        }
    }
}

struct CustomVendorSheet: View {
    @Binding var vendors: [String: String]
    @Binding var selected: String
    @Binding var showingSheet: Bool
    @State private var customVendorName: String = ""
    @State private var customVendorURL: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Add Custom Vendor")) {
                    TextField("Vendor Name", text: $customVendorName)
                    TextField("Search URL", text: $customVendorURL)
                }
                
                Button("Add Vendor") {
                    if !customVendorName.isEmpty && !customVendorURL.isEmpty {
                        vendors[customVendorName] = customVendorURL
                        selected = customVendorName
                        UserDefaults.standard.set(customVendorName, forKey: "vendorName")
                        UserDefaults.standard.set(customVendorURL, forKey: "vendorURL")
                        UserDefaults.standard.set(vendors, forKey: "customVendors")
                        showingSheet = false
                    }
                }
            }
            .navigationBarTitle("Custom Vendor", displayMode: .inline)
            .navigationBarItems(trailing: Button("Cancel") {
                showingSheet = false
            })
        }
    }
}

struct ProfilePickerSettingsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var selectedAvatar: String?
    @State var loading = false
    var avatars = avatarURLs
    
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
                ZStack{
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
                
            }.mask(
                VStack(spacing: 0) {
                    LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom)
                        .frame(height: 20)
                    Rectangle().fill(Color.black)
                    LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .top, endPoint: .bottom)
                        .frame(height: 20)
                }
            )
                
                
                
                Button(action: {
                    
                    if let selected = selectedAvatar {
                        loading = true
                        print("Confirmed avatar: \(selected)")
                        
                            let headers: HTTPHeaders = [
                                "Authorization": "Bearer \(SecureStorage.get() ?? "")",
                                "Content-Type": "application/json"
                            ]
                        AF.request("https://api.booklove.top/set/image", method: .post, parameters:["url":selected], encoder: JSONParameterEncoder.default, headers: headers).responseString { response in
                                switch response.result {
                                case .success(let _data):
                                    loading=false
                                    self.presentationMode.wrappedValue.dismiss()
                                case .failure(let _error):
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

struct SettingsName: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var name = ""
    @State private var favoriteBook = ""
    @State private var showContinueButton = false
    @State private var loading = false
    var body: some View {
        ZStack {
            BackgroundBlurElement()
            VStack {
                Text("booklove.")
                    .font(.system(size: 64, weight: .bold, design: .serif))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                Text("Set a new name and a new favorite book")
                    .font(.system(size: 32, weight: .light, design: .rounded))
                    .multilineTextAlignment(.center)
                    .padding(.top, 10).padding(.bottom)
                Spacer()
                VStack(spacing: 20) {
                    HStack {
                        Text("Name")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size:22, design:.serif))
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        VStack(spacing: 0) {
                            TextField("", text: $name)
                                .padding(.vertical, 20)
                                .multilineTextAlignment(.trailing)
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray)
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.5)
                    }
                }
                .padding()
                VStack(spacing: 20) {
                    HStack {
                        Text("Favourite book")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size:22, design:.serif))
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        VStack(spacing: 0) {
                            TextField("", text: $favoriteBook)
                                .padding(.vertical, 10)
                                .multilineTextAlignment(.trailing)
                                .font(.system(size: 20))
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray)
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.5)
                    }
                }
                .padding()
                Spacer()
                
                
                
                if showContinueButton {
                    Button(action: {
                        if((name != "") && (favoriteBook != "")){
                        let headers: HTTPHeaders = [
                            "Authorization": "Bearer \(SecureStorage.get() ?? "")",
                            "Content-Type": "application/json"
                        ]
                        loading = true;
                        AF.request("https://api.booklove.top/set/name-book", method: .post, parameters:["name":name, "book":favoriteBook], encoder: JSONParameterEncoder.default, headers: headers).responseString { response in
                                switch response.result {
                                case .success(let _responseData):
                                    loading = false
                                    self.presentationMode.wrappedValue.dismiss()
                                case .failure(let _error):
                                    loading = false
                                }
                            
                        }}
                        
                    }) {
                        if(!loading){
                        Text("Continue")
                            .font(.system(size: 20, weight: .semibold, design:.serif))
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .cornerRadius(10)}
                        else{
                            ProgressView().font(.system(size: 20, weight: .semibold, design:.serif))
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.black)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                }
            }
        }
        .onChange(of: name) {
            updateContinueButtonVisibility()
        }
        .onChange(of: favoriteBook) {
            updateContinueButtonVisibility()
        }
    }
    
    private func updateContinueButtonVisibility() {
        showContinueButton = !name.isEmpty && !favoriteBook.isEmpty
    }
}






#Preview {
    SettingsView().environmentObject(AppState())
}
