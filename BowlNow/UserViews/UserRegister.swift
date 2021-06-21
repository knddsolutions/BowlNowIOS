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
                        UserAccountInfo()
                        VStack {
                            UserEmailField(Email: $Email)
                            UserPasswordField(Password: $Password)
                            UserConfirmPasswordField(confirmPassword: $confirmPassword)
                        }
                        Button(action: {
                           CheckFields()
                        }){
                            Text("Create Account").foregroundColor(.white).bold()
                        }.frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                        .background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                        .cornerRadius(10)
                        .padding([.horizontal,.bottom])
                    }.background(Color(.white))
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding()
                    .navigationBarTitle("User Registration",displayMode: .inline)
                    .navigationBarItems(trailing: Image("BowlNow_Logo")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: 50)
                                            .padding(.top))
                    Spacer()
                    SwipeDown()
                }.background(Image("retro_background")
                                .resizable()
                                .aspectRatio(geometry.size, contentMode: .fill)
                                .edgesIgnoringSafeArea(.all).opacity(0.1))
            }.navigationBarTitle("",displayMode: .inline)
            .navigationBarHidden(true)
            .alert(isPresented: $showingAlert) {
                    Alert(title: Text((title)), message: Text((message)), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func CheckFields() {
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
    }
}

struct UserAccountInfo: View {
    var body: some View {
        VStack {
            HStack {
                Text("User Accounts")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth:.infinity, alignment: .leading)
                    .padding().fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
            }
            Text("A user account is intended for all levels of bowlers who desire to visit and join loyalty programs at a nearby BowlNow registered bowling center!")
                .font(.subheadline)
                .frame(maxWidth:.infinity, alignment: .leading)
                .padding(.horizontal)
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(.black)
            Text("Please fill out our form below:")
                .font(.subheadline)
                .frame(maxWidth:.infinity, alignment: .leading)
                .padding([.horizontal,.top])
                .foregroundColor(.black)
        }
    }
}

struct UserEmailField: View {
    @Binding var Email: String
    var body: some View {
        HStack {
            Image(systemName: "person")
                .padding()
                .foregroundColor(.black)
            VStack{
                TextField("Enter your email", text: $Email).foregroundColor(.black)
                Divider()
            }
        }.background(Color(.white))
        .cornerRadius(10)
        .opacity(0.9)
        .padding([.horizontal,.top])
    }
}

struct UserPasswordField: View {
    @Binding var Password: String
    var body: some View {
        HStack {
            Image(systemName: "lock")
                .foregroundColor(.black)
                .padding()
            VStack{
                TextField("Enter your password", text: $Password).foregroundColor(.black)
                Divider()
            }
        }.background(Color(.white))
        .cornerRadius(10)
        .opacity(0.9)
        .padding(.horizontal)
    }
}

struct UserConfirmPasswordField: View {
    @Binding var confirmPassword: String
    var body: some View {
        HStack {
            Image(systemName: "lock")
                .foregroundColor(.black)
                .padding()
            VStack {
            TextField("Re-enter your password", text: $confirmPassword).foregroundColor(.black)
                Divider()
            }
        }.background(Color(.white))
        .cornerRadius(10)
        .opacity(0.9)
        .padding([.horizontal,.bottom])
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
