//
//  Home.swift
//  BowlNow
//
//  Created by Kyle Cermak on 2/6/21.
//

import SwiftUI
import Kingfisher

struct Home: View {
    
    @State private var isShowingAccount: Bool = false
    @State private var isShowingHelp: Bool = false
    @State var Points: Int = UserDefaults.standard.integer(forKey: "Points")
    @State var Banner: String = UserDefaults.standard.string(forKey: "BannerURL") ?? ""
    @State var Fname: String = UserDefaults.standard.string(forKey: "Fname") ?? ""
    @State var Lname: String = UserDefaults.standard.string(forKey: "Lname") ?? ""
    @State var url: URL?
    @Binding var rootIsActive:Bool
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        GeometryReader { geometry in
                VStack {
                    NavigationLink(destination: MyAccount(rootIsActive: self.$rootIsActive), isActive: $isShowingAccount) { EmptyView() }
                    NavigationLink(destination: Help(), isActive: $isShowingHelp) { EmptyView() }
                    VStack {
                        KFImage(url)
                            .placeholder {
                            // Placeholder while downloading.
                                VStack {
                                    Image(systemName: "arrow.2.circlepath.circle")
                                        .font(.largeTitle)
                                        .opacity(0.3)
                                    Text("Loading Image...")
                                    }
                            }.resizable()
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
                            .padding()
                        Divider()
                        Spacer()
                    }.frame(width: geometry.size.width, height: geometry.size.height/2)
                    .background(Image("retro_background")
                                    .resizable()
                                    .scaledToFill()
                                    .opacity(0.1))
                    Spacer()
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(0..<4) {_ in
                                Text("Center Info Goes here")
                            }.frame(width: geometry.size.width/1.1, height: geometry.size.height/3, alignment: .center)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .padding()
                        }
                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(.white))
                    Spacer()
                }.navigationBarTitle("",displayMode: .inline)
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Image("BowlNow_Logo")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 40)
                            .padding()
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("My Centers")
                                .font(.headline)
                                .bold()
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            self.isShowingHelp.toggle()
                        }) {
                            Text("Support")
                                .font(.headline)
                        }
                    }
                }
        }.onAppear(perform: {
            url = URL(string: Banner)
        })
    }
}

