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
    @Binding var accountEditIsActive: Bool
    @Binding var number: Int
    @State private var isLoading: Bool = false
    @State private var isSuccessful: Bool = false
    @State private var isBadRequest: Bool = false
    @State private var requestSent: Bool = false
    @State private var hasTimeElapsed = false
    @State private var offset = CGSize.zero
    var adminRequests = AdminRequests()
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Spacer()
                VStack {
                    if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color(.white)))
                        .scaleEffect(3)
                        .padding()
                    Text("Updating \(accountName)'s account...")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.white)
                    }
                    else if isSuccessful {
                        Image(systemName:"checkmark.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.green)
                            .frame(maxWidth: 150)
                            .padding(.bottom)
                            .transition(AnyTransition.slide)
                            .animation(.easeIn)
                        Text("SUCCESS!")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                            .padding(.top)
                            .transition(AnyTransition.slide)
                            .animation(.easeIn)
                        Text("Account has been updated.")
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                            .transition(AnyTransition.slide)
                            .animation(.easeIn)
                        HomeButton(goBackHome: $accountEditIsActive)
                            .padding(.top, 50)
                    }
                    else if isBadRequest {
                        Image(systemName:"xmark.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.red)
                            .frame(maxWidth: 150)
                            .padding(.bottom)
                            .transition(AnyTransition.slide)
                            .animation(.easeIn)
                        Text("FAILED!")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                            .padding(.top)
                            .transition(AnyTransition.slide)
                            .animation(.easeIn)
                        Text(message)
                            .font(.title3)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding([.horizontal,.bottom])
                            .transition(AnyTransition.slide)
                            .animation(.easeIn)
                        HomeButton(goBackHome: $accountEditIsActive)
                            .padding(.top, 50)
                    }
                }
                Spacer()
                VStack {
                    VStack  {
                        VStack(alignment: .leading)  {
                            Spacer()
                            Group {
                                Text("Review Account Info:")
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                                    .padding(.horizontal)
                                HStack {
                                    Text("Id: ")
                                        .font(.headline)
                                        .bold()
                                        .padding([.horizontal,.top])
                                    Spacer()
                                    Text("\(accountId)")
                                        .font(.headline)
                                        .bold()
                                        .padding([.horizontal,.top])
                                }
                                Divider()
                                HStack {
                                    Text("Name: ")
                                        .font(.headline)
                                        .bold()
                                        .padding([.horizontal,.top])
                                    Spacer()
                                    Text("\(accountName)")
                                        .font(.headline)
                                        .bold()
                                        .padding([.horizontal,.top])
                                }
                                Divider()
                                HStack {
                                    Text("Email: ")
                                        .font(.headline)
                                        .bold()
                                        .padding([.horizontal,.top])
                                    Spacer()
                                    Text("\(accountEmail)")
                                        .font(.headline)
                                        .bold()
                                        .padding([.horizontal,.top])
                                }
                                Divider()
                            }
                        }
                        VStack(alignment: .leading)  {
                            Spacer()
                            Group {
                                Text("Account Changes:")
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                                    .padding([.horizontal,.top])
                                HStack {
                                    Text("Points: ")
                                        .font(.headline)
                                        .bold()
                                        .padding([.horizontal, .top])
                                    Spacer()
                                    Text("\(number)")
                                        .font(.headline)
                                        .bold()
                                        .padding([.horizontal,.top])
                                }
                                Divider()
                            }
                            Spacer()
                        }
                        Text("The above changes will take effect immediately after confirmation.")
                            .font(.subheadline)
                            .padding([.horizontal, .bottom])
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                    }.frame(width: geometry.size.width, height: geometry.size.height/1.15, alignment: .center)
                    .background(Color.white)
                    .edgesIgnoringSafeArea(.all)
                    .cornerRadius(30)
                    .offset(x: 0, y: offset.height * 2)
                    .gesture(
                        DragGesture()
                            .onChanged {gesture in
                                let verticalAmount = gesture.translation.height as CGFloat
                                if (verticalAmount < 0) {
                                    self.offset = gesture.translation
                                    
                                }
                            }
                            .onEnded { _ in
                                if abs(self.offset.height) > geometry.size.height/2 {
                                    self.isLoading.toggle()
                                    self.requestSent.toggle()
                                    self.offset = CGSize(width: geometry.size.width, height: geometry.size.height)
                                    delay()
                                } else {
                                    self.offset = .zero
                                }
                            })
                    Spacer()
                    if requestSent {
                        EmptyView()
                    } else {
                        VStack {
                            Image(systemName: "arrow.up")
                                .foregroundColor(.white)
                            Text("Swipe up to confirm")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }
                }
            }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            .background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("",displayMode: .inline)
            .navigationBarHidden(true)
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
    
    private func delay() {
        // Delay of 2.0 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                hasTimeElapsed = true
                adminRequests.PatchPoints(AuthToken: authToken, CenterMoid: accountCenterMoid, points: number, Moid: accountPointsMoid) {(success, message) in
                    if success == true {
                        self.title = "Success!"
                        self.message = "Account has been updated."
                        self.isSuccessful.toggle()
                    }
                    else {
                        self.title = "Failed!"
                        self.message = message
                        self.isBadRequest.toggle()
                    }
                    self.isLoading.toggle()
                }
            }
        }
    
}

struct HomeButton: View {
    @Binding var goBackHome: Bool
    var body: some View {
        Button(action: {
            self.goBackHome.toggle()
        }) {
            Spacer()
            HStack {
                Image(systemName: "arrow.left")
                    .foregroundColor(.white)
                Text("Go Back To Account")
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
            Spacer()
        }.frame(maxWidth: .infinity, alignment: .center)
    }
}

