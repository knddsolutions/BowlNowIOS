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
            NavigationView {
                ZStack {
                    Color.white.edgesIgnoringSafeArea(.all)
                    VStack {
                        VStack {
                            HStack {
                                Text("Welcome").font(.largeTitle).bold().frame(maxWidth:.infinity, alignment: .leading).padding().fixedSize(horizontal: false, vertical: true).foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                                Spacer()
                                Image("OpenBowl_Logo").resizable().scaledToFit().frame(maxWidth: 50).padding()
                            }
                            Text("Our platform creates an opportunity for the bowling community to earn and redeem rewards at their favorite centers. Made for bowlers, by bowlers, our mission is to provide a platform of inclusivity, support and feedback! ").frame(maxWidth:.infinity, alignment: .leading).padding([.horizontal,.bottom]).font(.subheadline).foregroundColor(.black)
                            Text("Please start by creating an account as a regular user or a bowling center below: ").frame(maxWidth:.infinity, alignment: .leading).padding([.horizontal,.bottom]).font(.subheadline).foregroundColor(.black)
                        }
                        VStack {
                            VStack {
                                NavigationLink(destination: UserRegister(), isActive: $isShowingUser) { EmptyView() }
                                Button(action: {
                                    self.isShowingUser.toggle()
                                }) {
                                    Text("User Account").foregroundColor(.white).bold()
                                }.frame(maxWidth: .infinity, maxHeight: geometry.size.height/7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0)).cornerRadius(10).padding([.horizontal, .bottom])
                                NavigationLink(destination: CenterRegister(), isActive: $isShowingCenter) { EmptyView() }
                                Button(action: {
                                    self.isShowingCenter.toggle()
                                }) {
                                    Text("Bowling Center").foregroundColor(.white).bold()
                                }.frame(maxWidth: .infinity, maxHeight: geometry.size.height/7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background((Color(red: 131/255, green: 202/255, blue: 238/255, opacity: 1.0))).cornerRadius(10).padding([.horizontal, .bottom])
                            }.padding()
                            Spacer()
                            Text("Swipe down to close")
                            VStack {
                                LinearGradient(gradient: Gradient(colors: [.white, (Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))]), startPoint: .top, endPoint: .bottom)
                                        .mask(Image(systemName: "arrow.down")
                                            .resizable()
                                            .frame(width: 50, height: 50, alignment: .center)
                                            .padding())
                            }.frame(width: 50, height: 50).padding(.bottom)
                        }.navigationBarTitle("",displayMode: .inline).navigationBarHidden(true)
                    }.background(Image("retro_background").resizable()
                                    .aspectRatio(geometry.size, contentMode: .fill)
                                    .edgesIgnoringSafeArea(.all).opacity(0.1))
                    
                }
            }
        }
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
