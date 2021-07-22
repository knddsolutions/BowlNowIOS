//
//  Review.swift
//  BowlNow
//
//  Created by Kyle Cermak on 6/4/21.
//

import SwiftUI

struct Review: View {
    @Binding var user: Array<String>
    @State var authToken: String = UserDefaults.standard.string(forKey: "AuthToken") ?? ""
    @State private var accountEmail: String = ""
    @State private var accountName: String = ""
    @State private var accountId: String = ""
    @State private var accountPoints: String = ""
    @State private var accountPointsMoid: String = ""
    @State private var accountCenterMoid: String = ""
    @State private var message: String = ""
    @State private var title: String = ""
    @State private var showingAlert: Bool = false
    @Binding var number: Int
    var adminRequests = AdminRequests()
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack(alignment: .leading)  {
                    Spacer()
                    Group {
                        Text("Review Account Info:")
                            .font(.title2)
                            .bold()
                            .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                            .padding(.horizontal)
                        HStack {
                            Text("Id: ")
                                .padding([.horizontal,.top])
                            Spacer()
                            Text("\(accountId)")
                                .padding([.horizontal,.top])
                        }
                        Divider()
                        HStack {
                            Text("Name: ")
                                .padding([.horizontal,.top])
                            Spacer()
                            Text("\(accountName)")
                                .padding([.horizontal,.top])
                        }
                        Divider()
                        HStack {
                            Text("Email: ")
                                .padding([.horizontal,.top])
                            Spacer()
                            Text("\(accountEmail)")
                                .padding([.horizontal,.top])
                        }
                        Divider()
                    }
                    Spacer()
                    Group {
                        Text("Account Changes:")
                            .font(.title2)
                            .bold()
                            .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                            .padding([.horizontal,.top])
                        HStack {
                            Text("Points: ")
                                .padding([.horizontal, .top])
                            Spacer()
                            Text("\(number)")
                                .padding([.horizontal,.top])
                        }
                        Divider()
                    }
                    Spacer()
                    Text("The above changes will take effect immediately after confirmation.")
                        .frame(maxWidth:.infinity, alignment: .leading)
                        .font(.subheadline)
                        .padding([.horizontal, .bottom])
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(.black)
                }.frame(width: geometry.size.width, height: geometry.size.height/1.15, alignment: .center)
                .background(Color.white)
                .edgesIgnoringSafeArea(.all)
                .cornerRadius(30)
                Spacer()
                VStack {
                    Image(systemName: "arrow.up")
                        .foregroundColor(.white)
                    Text("Swipe up to confirm")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                Spacer()
            }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            .background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
            .edgesIgnoringSafeArea(.all)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text((title)), message: Text((message)), dismissButton: .default(Text("OK")))
            }
            .gesture(DragGesture(minimumDistance: 20, coordinateSpace: .global)
                        .onEnded { value in
                            let horizontalAmount = value.translation.width as CGFloat
                            let verticalAmount = value.translation.height as CGFloat
                            
                            if abs(horizontalAmount) > abs(verticalAmount) {
                                print(horizontalAmount < 0 ? "left swipe" : "right swipe")
                            } else {
                                print(verticalAmount < 0 ? "up swipe" : "down swipe")
                                adminRequests.PatchPoints(AuthToken: authToken, CenterMoid: accountCenterMoid, points: number, Moid: accountPointsMoid) {(success, message) in
                                    if success == true {
                                        self.title = "Success!"
                                        self.message = "Account has been updated"
                                    }
                                    else {
                                        self.title = "Account Update Failed"
                                        self.message = message
                                    }
                                    self.showingAlert.toggle()
                                }
                            }
                        })
        }.edgesIgnoringSafeArea(.all)
        .onAppear(perform: {
            PullUserData()
        })
    }
    
    func PullUserData() {
        accountId = user[0]
        accountName = user[1]
        accountEmail = user[2]
        accountCenterMoid = user[3]
        accountPoints = user[4]
        accountPointsMoid = user[5]
    }
}

