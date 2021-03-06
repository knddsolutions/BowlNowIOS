//
//  UserRegister.swift
//  ThePerfectGame
//
//  Created by Kyle Cermak on 1/28/21.
//

import SwiftUI

struct UserRegister: View {
    var requests = UserRequests()
    @State private var Email: String = ""
    @State private var Password: String = ""
    @State private var confirmPassword: String = ""
    @State private var message: String = ""
    @State var title: String = ""
    @State private var showingAlert = false
    
    var body: some View {
        GeometryReader { geometry in
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                VStack {
                    VStack {
                        HStack {
                            Text("User Accounts").font(.largeTitle).bold().frame(maxWidth:.infinity, alignment: .leading).padding().fixedSize(horizontal: false, vertical: true).foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                        }
                        Text("A user account is intended for all levels of bowlers who desire to visit and join loyalty programs at a nearby bowling center.").frame(maxWidth:.infinity, alignment: .leading).font(.subheadline).padding(.horizontal).fixedSize(horizontal: false, vertical: true).foregroundColor(.black)
                        Text("Please fill out our form below:").frame(maxWidth:.infinity, alignment: .leading).font(.subheadline).padding().foregroundColor(.black)
                    }
                    VStack {
                        HStack {
                            Image(systemName: "person")
                            .padding().foregroundColor(.black)
                            VStack{
                            TextField("Enter your email", text: $Email).foregroundColor(.black)
                                Divider()
                            }
                        }.background(Color(.white)).cornerRadius(10).opacity(0.9).padding(.horizontal)
                        HStack {
                            Image(systemName: "lock")
                                .foregroundColor(.black)
                                .padding()
                            VStack{
                            TextField("Enter your password", text: $Password).foregroundColor(.black)
                                Divider()
                            }
                        }.background(Color(.white)).cornerRadius(10).opacity(0.9).padding(.horizontal)
                        HStack {
                            Image(systemName: "lock")
                                .foregroundColor(.black)
                                .padding()
                            VStack {
                            TextField("Re-enter your password", text: $confirmPassword).foregroundColor(.black)
                                Divider()
                            }
                        }.background(Color(.white)).cornerRadius(10).opacity(0.9).padding(.horizontal)
                        Button(action: {
                            if (self.Email.count == 0) {
                                self.message = "Email cannot be empty"
                                self.showingAlert.toggle()
                            }
                            else if (self.Password.count == 0 || self.confirmPassword.count == 0) {
                                self.message = "Password cannot be empty"
                                self.showingAlert.toggle()
                            }
                            else {
                                requests.UserRegistration(email: self.Email, password: self.confirmPassword) {(success, message) in
                                    if success == true {
                                        self.title = "Success!"
                                        self.message = message
                                    }
                                    else {
                                        self.title = "Sign Up Failed"
                                        self.message = message
                                    }
                                    self.showingAlert.toggle()
                                }
                            }
                        }){
                            Text("Create Account").foregroundColor(.white).bold()
                        }.frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                        .background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0)).cornerRadius(10).padding()
                    }
                }.background(Color(.white)).cornerRadius(10).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/).padding().navigationBarTitle("User Registration",displayMode: .inline).navigationBarItems(trailing: Image("BowlNow_Logo").resizable().scaledToFit().frame(maxWidth: 50).padding(.top))
                Spacer()
                Text("Swipe down to close")
                VStack {
                    LinearGradient(gradient: Gradient(colors: [.white, (Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))]), startPoint: .top, endPoint: .bottom)
                            .mask(Image(systemName: "arrow.down")
                                .resizable()
                                .frame(width: 50, height: 50, alignment: .center)
                                .padding())
                }.frame(width: 50, height: 50).padding(.bottom)
            }.background(Image("retro_background").resizable()
                            .aspectRatio(geometry.size, contentMode: .fill)
                            .edgesIgnoringSafeArea(.all).opacity(0.1))
            }.alert(isPresented: $showingAlert) {
                Alert(title: Text((title)), message: Text((message)), dismissButton: .default(Text("OK")))
        }
    }
}
}

struct signupResponse: Decodable {
    let Results: String
}

struct UserRegister_Previews: PreviewProvider {
    static var previews: some View {
        UserRegister()
    }
}
