//
//  CenterAdminHome.swift
//  BowlNow
//
//  Created by Kyle Cermak on 4/16/21.
//

import SwiftUI
import UIKit
import MessageUI
import CodeScanner
import Kingfisher

struct CenterAdminHome: View {
    @State private var isShowingManageUser: Bool = false
    @State private var isShowingScanner: Bool = false
    @State private var accountName: String = ""
    @State private var accountEmail: String = ""
    @State private var accountMoid: String = ""
    @State private var accountPoints: String = ""
    @State private var user: Array<String> = []
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                VStack {
                    ScrollView {
                        NavigationLink(destination: ManageUser(user: $user, accountEditIsActive: $isShowingManageUser), isActive: $isShowingManageUser) { EmptyView() }
                        CenterLogo()
                        Textinfo(Info: "Admin Options")
                        Button(action:  {
                            self.isShowingScanner.toggle()
                        }) {
                            VStack {
                                Divider()
                                HStack {
                                Text("Scan A QR Code")
                                    .font(.title3)
                                    .bold()
                                    .foregroundColor(.blue)
                                    .padding()
                                    Spacer()
                                    Image(systemName: "arrow.right")
                                        .foregroundColor(.blue)
                                        .padding(.trailing)
                                }
                                Divider()
                            }
                        }.frame(maxWidth: .infinity, alignment: .center)
                        .sheet(isPresented: $isShowingScanner) {
                            CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: self.handleScan)
                                .edgesIgnoringSafeArea(.all)
                        }
                        Button(action:  {
                            self.isShowingScanner.toggle()
                        }) {
                            VStack {
                                Divider()
                                HStack {
                                Text("Coming Soon...")
                                    .font(.title3)
                                    .bold()
                                    .foregroundColor(.blue)
                                    .padding()
                                    Spacer()
                                    Image(systemName: "arrow.right")
                                        .foregroundColor(.blue)
                                        .padding(.trailing)
                                }
                                Divider()
                            }
                        }.frame(maxWidth: .infinity, alignment: .center)
                        Button(action:  {
                            let mailtoString = "mailto:k.development@knddsolutions.com?subject=Admin Support&body=Dear BowlNow,".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

                            let mailtoUrl = URL(string: mailtoString!)!
                            if UIApplication.shared.canOpenURL(mailtoUrl) {
                                    UIApplication.shared.open(mailtoUrl, options: [:])
                            }
                        }) {
                            VStack {
                                Divider()
                                HStack {
                                    Text("Send Support Request")
                                        .font(.title3)
                                        .bold()
                                        .foregroundColor(.blue)
                                        .padding()
                                        Spacer()
                                    Image(systemName: "arrow.right")
                                        .foregroundColor(.blue)
                                        .padding(.trailing)
                                }
                                Divider()
                            }
                        }.frame(maxWidth: .infinity, alignment: .center)
                        Textinfo(Info: "Admin Info")
                            .padding(.top)
                        VStack(alignment: .leading, spacing: 10) {
                            Divider()
                            CenterAdminInfo()
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                            }) {
                                Text("Log Me Out")
                                    .bold()
                                    .foregroundColor(.white)
                            }.frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                            .background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                            .cornerRadius(10)
                            .padding([.top,.bottom])
                            Divider()
                        }.frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    }
                }
            }.navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
    }
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        isShowingScanner.toggle()
        
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 6 else {
                return
            }

            user = details
            
            self.isShowingManageUser.toggle()
        case .failure(let error):
            print(error)
        }
    }
}

struct CenterAdminInfo: View {
    @State var Fname: String = UserDefaults.standard.string(forKey: "Fname") ?? ""
    @State var Lname: String = UserDefaults.standard.string(forKey: "Lname") ?? ""
    @State var Email: String = UserDefaults.standard.string(forKey: "storeEmail") ?? ""
    @State var CenterName: String = UserDefaults.standard.string(forKey: "CenterName") ?? ""
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Admin: ")
                    .font(.subheadline)
                    .bold()
                Spacer()
                Text("\(Fname) \(Lname)")
                    .font(.subheadline)
                    .bold()
            }
            HStack {
                Text("Center: ")
                    .font(.subheadline)
                    .bold()
                Spacer()
                Text("\(CenterName)")
                    .font(.subheadline)
                    .bold()
            }
            HStack {
                Text("Email: ")
                    .font(.subheadline)
                    .bold()
                Spacer()
                Text("\(Email)")
                    .font(.subheadline)
                    .bold()
            }
        }
    }
}

struct Textinfo: View {
    var Info: String
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
                Text(Info)
                    .font(.title)
                    .bold()
                    .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
        }.frame(maxWidth: .infinity, alignment: .leading)
        .padding([.horizontal,.top])
    }
}

struct CenterLogo: View {
    @State private var BannerURL: String = UserDefaults.standard.string(forKey: "BannerURL") ?? ""
    @State private var url: URL?
    var body: some View {
        VStack {
            KFImage(url)
                .placeholder {
                // Placeholder while downloading.
                Image(systemName: "arrow.2.circlepath.circle")
                    .font(.largeTitle)
                    .opacity(0.3)
                }
                .resizable()
                .retry(maxCount: 3, interval: .seconds(5))
                .onSuccess { r in
                    // r: RetrieveImageResult
                    print("success: \(r)")
                }
                .onFailure { e in
                    // e: KingfisherError
                    print("failure: \(e)")
                }
                .cancelOnDisappear(true)
                .resizable()
                .scaledToFit()
        }.padding()
        .onAppear(perform: {
            url = URL(string: BannerURL)
        })
    }
}

struct CenterAdminHome_Previews: PreviewProvider {
    static var previews: some View {
        CenterAdminHome()
    }
}
