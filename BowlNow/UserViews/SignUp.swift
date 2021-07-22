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
                    Spacer()
                        VStack {
                            UserAccountInfo()
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
                                    .padding(.horizontal)
                                Text("Or")
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                                Divider()
                                    .frame(maxWidth:.infinity, maxHeight:2)
                                    .background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                                    .padding(.horizontal)
                            }.padding(.top, 20)
                            .padding(.bottom, 20)
                            CenterAccountInfo()
                            CenterButton(isShowingCenter: $isShowingCenter)
                                .frame(maxWidth: .infinity, maxHeight: geometry.size.height/7, alignment: .center)
                                .background(Color(red: 131/255, green: 202/255, blue: 238/255, opacity: 1.0))
                                .cornerRadius(10)
                                .sheet(isPresented: $isShowingCenter) {
                                    CenterRegister()
                                }
                        }.padding()
                        Spacer()
                }.background(Image("retro_background")
                                .resizable()
                                .aspectRatio(geometry.size, contentMode: .fill)
                                .edgesIgnoringSafeArea(.bottom).opacity(0.1))
                .navigationBarTitle("",displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Welcome")
                            .bold()
                            .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Image("BowlNow_Logo")
                            .resizable()
                            .frame(width:30, height: 30)
                            .scaledToFit()
                    }
                }
            }
        }
    }
}

struct UserAccountInfo: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("User Accounts: ")
                .font(.title)
                .bold()
                .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                .padding(.bottom)
            Text("A user account is intended for all levels of bowlers who desire to visit and join loyalty programs at a nearby BowlNow registered bowling center!")
                .frame(maxWidth:.infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
        }.frame(maxWidth:.infinity, alignment: .leading)
        .padding([.top,.bottom])
    }
}

struct CenterAccountInfo: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Center Accounts: ")
                .font(.title)
                .bold()
                .foregroundColor(Color(red: 131/255, green: 202/255, blue: 238/255, opacity: 1.0))
                .padding(.bottom)
            Text("This form is for bowling centers ONLY who wish to join our program. Please signup with your centers information to give your customers access to loyalty, coupons and other exciting programs!")
                .frame(maxWidth:.infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
        }.frame(maxWidth:.infinity, alignment: .leading)
        .padding(.bottom)
    }
}

struct UserButton: View {
    @Binding var isShowingUser: Bool
    var body: some View {
        Button(action: {
            self.isShowingUser.toggle()
        }) {
            Text("User Registration")
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
            Text("Center Registration")
                .foregroundColor(.white)
                .bold()
        }
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
