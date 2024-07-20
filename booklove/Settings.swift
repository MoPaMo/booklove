//
//  Settings.swift
//  booklove
//
//  Created by Moritz on 12.07.24.
//

import SwiftUI
import UIKit
import Alamofire
import MobileCoreServices


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
                    Link("Feedback", destination: URL(string: "mailto:feedback@booklove.top")!)
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
func downloadData(completion: @escaping (URL?) -> Void) {
    let url = "https://api.booklove.top/download-my-data"
    let destination: DownloadRequest.Destination = { _, _ in
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("file.zip")
        return (tempURL, [.removePreviousFile])
    }
    let headers: HTTPHeaders = [
        "Authorization": "Bearer \(SecureStorage.get() ?? "")",
        "Content-Type": "application/json"
    ]
    AF.download(url, headers: headers, to: destination).response { response in
        if response.error == nil, let tempURL = response.fileURL {
            completion(tempURL)
        } else {
            completion(nil)
        }
    }
}

struct DocumentPicker: UIViewControllerRepresentable {
    var documentURL: URL
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forExporting: [documentURL])
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: DocumentPicker
        
        init(_ parent: DocumentPicker) {
            self.parent = parent
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        }
        
        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        }
    }
}


struct AccountView: View {
    @State private var showDocumentPicker = false
    @State private var documentURL: URL?
    
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
                NavigationLink(destination: ProfilePickerSettingsView()) {
                    Text("Set New Avatar")
                        .font(.system(size: 32, weight: .regular, design: .serif))
                        .foregroundStyle(.black)
                }
                Button(action: {
                    downloadData { url in
                        if let url = url {
                            self.documentURL = url
                            self.showDocumentPicker = true
                        }
                    }
                }) {
                    Text("Download My Data")
                        .font(.system(size: 32, weight: .regular, design: .serif))
                }
                .sheet(isPresented: $showDocumentPicker) {
                    if let url = documentURL {
                        DocumentPicker(documentURL: url)
                    }
                }
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
                                case .success(let responseData):
                                    loading=false
                                    self.presentationMode.wrappedValue.dismiss()
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








#Preview {
    SettingsView().environmentObject(AppState())
}
