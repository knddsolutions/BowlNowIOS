//
//  ManageUser.swift
//  BowlNow
//
//  Created by Kyle Cermak on 6/7/21.
//

import SwiftUI

struct ManageUser: View {
    @Binding var user: Array<String>
    @State var isShowingAddPoints: Bool = false
    @State var isShowingRedeemPoints: Bool = false
    @State var accountEmail: String = ""
    @State var accountName: String = ""
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack {
                    VStack {
                        Spacer()
                        Text("Manage \(accountName)'s Account")
                            .font(.title)
                            .bold()
                            .frame(maxWidth:.infinity, alignment: .leading)
                            .padding()
                            .fixedSize(horizontal: false, vertical: true)
                            .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                        Divider()
                        NavigationLink(destination: AddPoints(user: $user), isActive: $isShowingAddPoints) { EmptyView() }
                        Button(action: {
                            isShowingAddPoints.toggle()
                        }) {
                            HStack {
                                Text("Add Points")
                                    .foregroundColor(.white)
                                    .bold()
                                Image(systemName: "arrow.right")
                                    .foregroundColor(.white)
                            }
                        }.frame(maxWidth: .infinity, maxHeight: geometry.size.height/12, alignment: .center)
                        .background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                        .cornerRadius(10)
                        .padding([.horizontal, .top])
                        NavigationLink(destination: RedeemPoints(user: $user), isActive: $isShowingRedeemPoints) { EmptyView() }
                        Button(action: {
                            isShowingRedeemPoints.toggle()
                        }) {
                            HStack {
                                Text("Redeem Points")
                                    .foregroundColor(.white)
                                    .bold()
                                Image(systemName: "arrow.right")
                                    .foregroundColor(.white)
                            }
                        }.frame(maxWidth: .infinity, maxHeight: geometry.size.height/12, alignment: .center)
                        .background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                        .cornerRadius(10)
                        .padding([.horizontal, .top])
                        Spacer()
                        Button(action: {
                            print("hi")
                        }) {
                            HStack {
                                Text("Use Coupon")
                                    .foregroundColor(.white)
                                    .bold()
                                Image(systemName: "arrow.right")
                                    .foregroundColor(.white)
                            }
                        }.frame(maxWidth: .infinity, maxHeight: geometry.size.height/12, alignment: .center)
                        .background(Color(red: 131/255, green: 202/255, blue: 238/255, opacity: 1.0))
                        .cornerRadius(10)
                        .padding()
                    }.background(Image("retro_background")
                                    .resizable()
                                    .aspectRatio(geometry.size, contentMode: .fill)
                                    .edgesIgnoringSafeArea(.all).opacity(0.1))
                }.frame(width: geometry.size.width, height: geometry.size.height/1.15, alignment: .center)
                .background(Color.white)
                .edgesIgnoringSafeArea(.all)
                .cornerRadius(30)
                CenterAdminInfo()
                Spacer()
            }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            .background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
            .edgesIgnoringSafeArea(.all)
        }.edgesIgnoringSafeArea(.all)
        .navigationBarTitle("\(accountName)'s Account",displayMode: .inline)
        .onAppear(perform: {
            PullUserData()
        })
    }
    
    func PullUserData() {
        accountName = user[1]
        accountEmail = user[2]
    }
}

