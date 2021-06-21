//
//  SignUp.swift
//  ThePerfectGame
//
//  Created by Kyle Cermak on 1/24/21.
//

import SwiftUI

struct SignUp: View {
    @State private var Email: String = ""
    @State private var Password: String = ""
    @State private var isShowingCenter: Bool = false
    @State private var isShowingUser: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                VStack {
                    PlatformInfo()
                    VStack {
                        Spacer()
                        VStack {
                            UserButton(isShowingUser: $isShowingUser)
                                .frame(maxWidth: .infinity, maxHeight: geometry.size.height/7, alignment: .center)
                                .background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                                .cornerRadius(10)
                                .sheet(isPresented: $isShowingUser) {
                                    UserRegister()
                                }
                            HStack {
                                Divider()
                                    .frame(maxWidth:.infinity, maxHeight:2)
                                    .background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                                    .padding()
                                Text("Or")
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                                Divider()
                                    .frame(maxWidth:.infinity, maxHeight:2)
                                    .background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                                    .padding()
                            }
                            CenterButton(isShowingCenter: $isShowingCenter)
                                .frame(maxWidth: .infinity, maxHeight: geometry.size.height/7, alignment: .center)
                                .background(Color(red: 131/255, green: 202/255, blue: 238/255, opacity: 1.0))
                                .cornerRadius(10)
                                .sheet(isPresented: $isShowingCenter) {
                                    CenterRegister()
                                }
                        }.padding()
                        Spacer()
                    }.navigationBarTitle("",displayMode: .inline)
                }.background(Image("retro_background")
                                .resizable()
                                .aspectRatio(geometry.size, contentMode: .fill)
                                .edgesIgnoringSafeArea(.all).opacity(0.1))
                
            }
        }
    }
}

struct PlatformInfo: View {
    var body: some View {
        VStack {
            HStack {
                Text("Welcome")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth:.infinity, alignment: .leading)
                    .padding()
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                Spacer()
                Image("BowlNow_Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 50)
                    .padding()
            }
            Text("Our platform creates an opportunity for the bowling community to earn and redeem rewards at their favorite centers. Made for bowlers, by bowlers, our mission is to provide a custom platform of inclusivity, support and feedback!")
                .font(.subheadline)
                .frame(maxWidth:.infinity, alignment: .leading)
                .padding([.horizontal,.bottom])
                .foregroundColor(.black)
            Text("Please start by creating an account below: ")
                .font(.subheadline)
                .frame(maxWidth:.infinity, alignment: .leading)
                .padding([.horizontal,.bottom])
                .foregroundColor(.black)
        }
    }
}

struct UserButton: View {
    @Binding var isShowingUser: Bool
    var body: some View {
        Button(action: {
            self.isShowingUser.toggle()
        }) {
            Text("User Account")
                .foregroundColor(.white)
                .bold()
        }
    }
}

struct CenterButton: View {
    @Binding var isShowingCenter: Bool
    var body: some View {
        Button(action: {
            self.isShowingCenter.toggle()
        }) {
            Text("Bowling Center").foregroundColor(.white).bold()
        }
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
