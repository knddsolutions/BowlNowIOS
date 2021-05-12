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
    @State private var isShowingAbout: Bool = false
    @State var FirstInitial: String = ""
    @State var LastInitial: String = ""
    @State var Fname: String = UserDefaults.standard.string(forKey: "Fname") ?? ""
    @State var Lname: String = UserDefaults.standard.string(forKey: "Lname") ?? ""
    @State var Points: String = UserDefaults.standard.string(forKey: "Points") ?? ""
    @Binding var rootIsActive:Bool
    @Environment(\.presentationMode) var presentationMode
    
    var BannerURL: URL? {
        URL(string: UserDefaults.standard.string(forKey: "BannerURL") ?? "")
    }
    
    var Name: String {
        UserDefaults.standard.string(forKey: "Fname") ?? ""
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top){
                Circle()
                    .frame(width: geometry.size.width, height: geometry.size.width)
                    .offset(y: -300).foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0)).edgesIgnoringSafeArea(.all)
                VStack {
                    Text("\(FirstInitial)\(LastInitial)")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                }
                VStack {
                    NavigationLink(destination: MyAccount(rootIsActive: self.$rootIsActive), isActive: $isShowingAccount) { EmptyView() }
                    NavigationLink(destination: AboutUs(), isActive: $isShowingAbout) { EmptyView() }
                        HStack {
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(systemName: "escape")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(Color(red: 131/255, green: 202/255, blue: 238/255, opacity: 1.0))
                                    .frame(width: geometry.size.width/9, height: geometry.size.height/16, alignment: .center)
                            }.offset(y: -10)
                            Spacer()
                            Button(action: {
                                self.isShowingAbout.toggle()
                            }) {
                                Image(systemName: "info.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(Color(red: 131/255, green: 202/255, blue: 238/255, opacity: 1.0))
                                    .frame(width: geometry.size.width/8, height: geometry.size.height/15, alignment: .center)
                            }.offset(y: 25)
                            Button(action: {
                                self.isShowingAccount.toggle()
                            }) {
                                Image(systemName: "person.crop.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(Color(red: 131/255, green: 202/255, blue: 238/255, opacity: 1.0))
                                    .frame(width: geometry.size.width/8, height: geometry.size.height/15, alignment: .center)
                            }.offset(y: -10)
                        }.padding(.horizontal)
                        Spacer()
                        KFImage(BannerURL)
                            .placeholder {
                            // Placeholder while downloading.
                            Image(systemName: "arrow.2.circlepath.circle")
                                .font(.largeTitle)
                                .opacity(0.3)
                        }
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
                        Spacer()
                        HStack {
                            Image(systemName: "star.fill").resizable().scaledToFit().frame(width: geometry.size.width/5, height: geometry.size.height/20, alignment: .center).foregroundColor(.yellow)
                            Spacer()
                            Text("\(Points)")
                                .font(.title)
                                .padding()
                            Spacer()
                            Image(systemName: "star.fill").resizable().scaledToFit().frame(width: geometry.size.width/5, height: geometry.size.height/20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(.yellow)
                        }.background(LinearGradient(gradient: Gradient(colors: [(Color(red: 131/255, green: 202/255, blue: 238/255, opacity: 1.0)), (Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))]), startPoint: .leading, endPoint: .trailing)).cornerRadius(20)
                    ScrollView {
                        VStack {
                            Text("All other information goes here...")
                                .padding()
                        }
                    }.frame(width: geometry.size.width, height: geometry.size.height/2)
                    .background(Color.white)
                }
            }.background(Image("retro_background")
                            .resizable()
                            .aspectRatio(geometry.size, contentMode: .fill)
                            .edgesIgnoringSafeArea(.all)
                            .opacity(0.1))
            .navigationBarHidden(true)
        }.onAppear(perform: {
            self.FirstInitial = String(Fname.prefix(1))
            self.LastInitial = String(Lname.prefix(1))
        })
    }
}

