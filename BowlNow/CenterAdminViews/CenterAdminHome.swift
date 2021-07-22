//
//  CenterAdminHome.swift
//  BowlNow
//
//  Created by Kyle Cermak on 4/16/21.
//

import SwiftUI
import UIKit
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
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack {
                    VStack {
                        NavigationLink(destination: ManageUser(user: $user), isActive: $isShowingManageUser) { EmptyView() }
                        CenterLogo()
                            .padding(.top, 50)
                        Divider()
                            .padding(.horizontal)
                        Textinfo()
                        Button(action:  {
                            self.isShowingScanner.toggle()
                        }) {
                            Text("Scan A QR Code")
                                .bold()
                                .foregroundColor(.white)
                        }.frame(maxWidth: .infinity, maxHeight: geometry.size.height/9, alignment: .center)
                        .background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                        .cornerRadius(10)
                        .padding()
                        .sheet(isPresented: $isShowingScanner) {
                            CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: self.handleScan)
                        }
                        Button(action:  {
                            self.isShowingScanner.toggle()
                        }) {
                            Text("Coming Soon...")
                                .bold()
                                .foregroundColor(.white)
                        }.frame(maxWidth: .infinity, maxHeight: geometry.size.height/9, alignment: .center)
                        .background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        Spacer()
                    }.background(Image("retro_background")
                                    .resizable()
                                    .aspectRatio(geometry.size, contentMode: .fill)
                                    .edgesIgnoringSafeArea(.all).opacity(0.1))
                }.frame(width: geometry.size.width, height: geometry.size.height/1.15, alignment: .center)
                .background(Color.white)
                .cornerRadius(30)
                CenterAdminInfo()
                Spacer()
            }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            .background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
        }.edgesIgnoringSafeArea(.all)
        .navigationBarTitle("")
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
    var body: some View {
        VStack {
            Text("Admin: \(Fname) \(Lname)")
                .font(.title2)
                .bold()
                .padding()
                .foregroundColor(.white)
        }
    }
}

struct Textinfo: View {
    var body: some View {
        Text("What would you like to do today?")
            .frame(maxWidth:.infinity, alignment: .leading)
            .padding([.horizontal])
            .foregroundColor(.black)
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
        }.padding(.horizontal)
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
