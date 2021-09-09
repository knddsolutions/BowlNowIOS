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
    @State private var showingAboutUserAccount: Bool = false
    @State private var isLoading: Bool = false
    @Binding var isShowingUser: Bool
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0)
                    .edgesIgnoringSafeArea(.all)
                RoundedRectangle(cornerRadius: 10)
                    .edgesIgnoringSafeArea(.all)
                    .foregroundColor(.white)
                    .frame(width: geometry.size.width, height: geometry.size.height/3, alignment: .bottom)
                VStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left.2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)
                    }
                    Spacer()
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .padding()
                VStack {
                    Image("BowlNow_Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 150)
                        .padding(.top)
                    Spacer()
                    Text("User Registration")
                        .font(.title)
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                    Spacer()
                    VStack(spacing: 10) {
                        UserEmailField(Email: $Email)
                        UserPasswordField(Password: $Password)
                        UserConfirmPasswordField(confirmPassword: $confirmPassword)
                        Button(action: {
                            CheckFields()
                        }){
                            Text("Create Account")
                                .foregroundColor(.white)
                                .bold()
                                .frame(minWidth: 100, maxWidth: .infinity, minHeight: 40, maxHeight: .infinity, alignment: .center)
                        }.frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                        .background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                        .cornerRadius(10)
                        .padding([.horizontal,.bottom])
                    }.background(Color(.white))
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding(.horizontal)
                    Spacer()
                    Button(action: {
                        self.showingAboutUserAccount.toggle()
                    }){
                        HStack {
                            Text("What is a user account?")
                                .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                            Image(systemName: "arrow.right")
                                .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                        }
                    }
                    Spacer()
                }.sheet(isPresented: $showingAboutUserAccount){
                    AboutUserAccount()
                }
                if isLoading {
                    LoadingView()
                }
            }.navigationBarTitle("",displayMode: .inline)
            .navigationBarHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("User Accounts")
                        .bold()
                        .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                }
            }
            .alert(isPresented: $showingAlert, content: {
                Alert(title: Text((title)), message: Text((message)), dismissButton: .default(Text("OK")) {
                    isShowingUser.toggle()
                })
            })
            .onTapGesture {
                self.endTextEditing()
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
            self.isLoading.toggle()
            requests.UserRegistration(email: self.Email, password: self.confirmPassword) {(success, message) in
                if success == true {
                    self.title = "Success!"
                    self.message = message
                }
                else {
                    self.title = "Sign Up Failed"
                    self.message = message
                }
                self.isLoading.toggle()
                self.showingAlert.toggle()
            }
        }
    }
}

struct UserEmailField: View {
    @Binding var Email: String
    var body: some View {
        VStack {
            HStack {
                Image("Bowl_now_pin")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 10, maxHeight: 30, alignment: .center)
                    .padding(.leading)
                TextField("Enter your email", text: $Email)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .padding()
                    .keyboardType(.emailAddress)
            }
        }.background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding([.top,.horizontal])
    }
}

struct UserPasswordField: View {
    @Binding var Password: String
    var body: some View {
        VStack {
            HStack {
                Image("Bowl_now_pin")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 10, maxHeight: 30, alignment: .center)
                    .padding(.leading)
                SecureField("Enter your password", text: $Password)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .padding()
            }
        }.background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}

struct UserConfirmPasswordField: View {
    @Binding var confirmPassword: String
    var body: some View {
        VStack {
            HStack {
                Image("Bowl_now_pin")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 10, maxHeight: 30, alignment: .center)
                    .padding(.leading)
                SecureField("Re-enter your password", text: $confirmPassword)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .padding()
            }
        }.background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}

struct signupResponse: Decodable {
    let Results: String
}

