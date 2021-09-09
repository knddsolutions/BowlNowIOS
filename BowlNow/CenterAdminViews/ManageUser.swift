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
    @State private var accountPoints: String = ""
    @Binding var accountEditIsActive: Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    Text("\(accountName)'s Account Overview")
                        .font(.title2)
                        .bold()
                        .padding(.top)
                        .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                    Divider()
                        .padding(.bottom)
                    NavigationLink(destination: AddPoints(user: $user, accountEditIsActive: $accountEditIsActive), isActive: $isShowingAddPoints) { EmptyView() }
                    NavigationLink(destination: RedeemPoints(accountEditIsActive: $accountEditIsActive, user: $user), isActive: $isShowingRedeemPoints) { EmptyView() }
                    LinearGradient(gradient: Gradient(colors: [(Color(red: 131/255, green: 202/255, blue: 238/255, opacity: 1.0)), (Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))]),
                                   startPoint: .leading,
                                   endPoint: .trailing)
                        .mask(Text("\(accountPoints)")
                                .font(.system(size: 80))
                                .bold())
                        .frame(maxHeight: geometry.size.height/8)
                        .padding()
                    Text("What would you like to do with this account?")
                        .font(.headline)
                        .bold()
                        .padding()
                    Group {
                        Button(action: {
                            isShowingAddPoints.toggle()
                        }) {
                            VStack {
                                Divider()
                                HStack {
                                    Text("Add Points")
                                        .font(.title3)
                                        .bold()
                                        .foregroundColor(.blue)
                                        .padding()
                                    Spacer()
                                    Text("+")
                                        .font(.title3)
                                        .bold()
                                        .foregroundColor(.blue)
                                        .padding()
                                }
                                Divider()
                            }
                        }.frame(maxWidth: .infinity, alignment: .center)
                        Button(action: {
                            isShowingRedeemPoints.toggle()
                        }) {
                            VStack {
                                Divider()
                                HStack {
                                    Text("Redeem Points")
                                        .font(.title3)
                                        .bold()
                                        .foregroundColor(.blue)
                                        .padding()
                                    Spacer()
                                    Text("-")
                                        .font(.title3)
                                        .bold()
                                        .foregroundColor(.blue)
                                        .padding()
                                }
                                Divider()
                            }
                        }.frame(maxWidth: .infinity, alignment: .center)
                        Button(action: {
                            //DO SOMETHING
                        }) {
                            VStack {
                                Divider()
                                HStack {
                                    Text("Use A Coupon")
                                        .font(.title3)
                                        .bold()
                                        .foregroundColor(.blue)
                                        .padding()
                                    Spacer()
                                    Image(systemName: "qrcode")
                                        .foregroundColor(.blue)
                                        .padding()
                                }
                                Divider()
                            }
                        }.frame(maxWidth: .infinity, alignment: .center)
                    }
                    Spacer()
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Done Editing This Account")
                            .font(.title2)
                            .foregroundColor(.white)
                            .bold()
                    }.frame(maxWidth: .infinity, maxHeight: geometry.size.height/12, alignment: .center)
                    .background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                    .cornerRadius(10)
                    .padding([.horizontal, .top])
                }
            }
        }.navigationBarTitle("",displayMode: .inline)
        .navigationBarHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("\(accountName)'s Account")
                    .bold()
                    .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
            }
        }
        .onAppear(perform: {
            PullUserData()
        })
    }
    
    func PullUserData() {
        accountName = user[1]
        accountEmail = user[2]
        accountPoints = user[4]
    }
}


