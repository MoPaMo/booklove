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

    var body: some View {
        NavigationView {
            ZStack {
                BackgroundBlurElement()
                
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
                        ShareSheet(activityItems: ["Check out this awesome app!"])
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
                        .foregroundColor(.red)
                    
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
            BackgroundBlurElement()
            VStack(spacing: 50) {
                
                Text("Account")
                    .font(.system(size: 32, weight: .regular, design: .serif))
                    .foregroundColor(.black)
                
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
    var body: some View{
        ZStack{
            BackgroundBlurElement()
            VStack(spacing: 50) {
                
                Text("Vendor")
                    .font(.system(size: 32, weight: .regular, design: .serif))
                    .foregroundColor(.black)
                
                HStack(){ZStack() {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 161, height: 53)
                        .background(.white)
                        .cornerRadius(21)
                        .offset(x: 0, y: 0)
                        .shadow(
                            color: Color(red: 0, green: 0, blue: 0, opacity: 0.20), radius: 6, y: 2
                        )
                    Text("Amazon")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                        .offset(x: 0, y: 0.50)
                }
                .frame(width: 161, height: 53)
                    ZStack() {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 161, height: 53)
                            .background(.white)
                            .cornerRadius(21)
                            .offset(x: 0, y: 0)
                            .shadow(
                                color: Color(red: 0, green: 0, blue: 0, opacity: 0.20), radius: 6, y: 2
                            )
                        Text("eBay")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                            .offset(x: 0, y: 0.50)
                    }
                    .frame(height: 53)
                }
                
                Spacer()
            }
            .padding(.leading, 18)
            .padding([.top, .bottom, .trailing])
        }
    }
}

#Preview {
    SettingsView()
}
