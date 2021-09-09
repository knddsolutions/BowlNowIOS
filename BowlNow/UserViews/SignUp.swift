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
    @Binding var isShowingWelcome: Bool
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                VStack {
                    HStack {
                        Button(action: {self.isShowingWelcome.toggle()}) {
                            Image(systemName: "chevron.left.2")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                        }.frame(maxWidth: .infinity, alignment: .leading)
                        Image("BowlNow_Logo")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 50)
                        Text("")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }.frame(maxWidth: .infinity)
                    .padding()
                    Divider()
                    NavigationLink(destination: CenterRegister(isShowingCenter: $isShowingCenter), isActive: $isShowingCenter) { EmptyView()}
                    NavigationLink(destination: UserRegister(isShowingUser: $isShowingUser), isActive: $isShowingUser) { EmptyView()}
                    VStack {
                        UserAccountInfo()
                        CenterAccountInfo()
                        UserButton(isShowingUser: $isShowingUser)
                            .frame(maxWidth: .infinity, maxHeight: geometry.size.height/7, alignment: .center)
                            .background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                            .cornerRadius(10)
                            .padding([.top,.bottom])
                        CenterButton(isShowingCenter: $isShowingCenter)
                            .frame(maxWidth: .infinity, maxHeight: geometry.size.height/7, alignment: .center)
                            .background(Color(red: 131/255, green: 202/255, blue: 238/255, opacity: 1.0))
                            .cornerRadius(10)
                    }.padding()
                    Spacer()
                }.navigationBarTitle("",displayMode: .inline)
                .navigationBarHidden(true)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Welcome")
                            .bold()
                            .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                    }
                }
            }
        }
    }
}

struct UserAccountInfo: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("BowlNow ")
                .bold()
                .font(.largeTitle)
                .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
            + Text("is a platform designed and developed for bowlers by bowlers. Our main goal is to enhance the bowling experience for both bowling centers and the customers they serve.")
                .bold()
        }.frame(maxWidth:.infinity, alignment: .leading)
        .padding([.top])
    }
}

struct CenterAccountInfo: View {
    var body: some View {
        VStack() {
            Text("Register ")
                .bold()
                .font(.largeTitle)
                .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
            + Text("for our platform by tapping below if you are new user. Keep in mind that center registration is only for proprietors looking to add their center to our program. Everyone else is considered a user!")
                .bold()
        }.frame(maxWidth:.infinity, alignment: .leading)
        .padding([.top,.bottom])
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
                .frame(minWidth: 100, maxWidth: .infinity, minHeight: 40, maxHeight: .infinity, alignment: .center)
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
                .frame(minWidth: 100, maxWidth: .infinity, minHeight: 40, maxHeight: .infinity, alignment: .center)
        }
    }
}
