//
//  ForgotPassword.swift
//  BowlNow
//
//  Created by Kyle Cermak on 2/4/21.
//

import SwiftUI

struct ForgotPassword: View {
    var requests = UserRequests()
    @State private var Email: String = ""
    @State private var message: String = ""
    @State private var title: String = ""
    @State private var showingAlert = false
    @State private var isLoading: Bool = false
    @Binding var showingForgotPassword: Bool
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                VStack {
                    Image("BowlNow_Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 150)
                        .padding(.top)
                    ResetInfo()
                    VStack {
                        ResetPasswordField(Email: $Email)
                        Button(action: {
                            self.isLoading.toggle()
                            requests.PasswordReset(email: self.Email) {(success, message) in
                                if success == true {
                                    self.title = "Success!"
                                    self.message = message
                                }
                                else {
                                    self.title = "Reset Failed"
                                    self.message = message
                                }
                                self.isLoading.toggle()
                                self.showingAlert.toggle()
                            }
                        }){
                            Text("Recover Account")
                                .foregroundColor(.white)
                                .bold()
                                .frame(minWidth: 100, maxWidth: .infinity, minHeight: 40, maxHeight: .infinity, alignment: .center)
                        }.frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                        .background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                        .cornerRadius(10)
                        .padding([.horizontal,.bottom])
                    }.background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding()
                    Spacer()
                    SwipeDown()
                }.background(Image("retro_background")
                                .resizable()
                                .frame(width: geometry.size.width)
                                .edgesIgnoringSafeArea(.all)
                                .opacity(0.1))
                if isLoading {
                    LoadingView()
                }
            }.alert(isPresented: $showingAlert) {
                Alert(title: Text((title)), message: Text((message)), dismissButton: .default(Text("OK")) {
                    showingForgotPassword.toggle()
                })
            }
            .onTapGesture {
                self.endTextEditing()
            }
        }
    }
}

struct ResetInfo: View {
    var body: some View {
        Text("Oops!")
            .font(.largeTitle)
            .bold()
            .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
        Text("Did you forget your password?")
            .bold()
            .padding(.bottom)
        Text("Please enter your email address below to recieve an account recovery email.")
            .bold()
            .padding(.horizontal)
            .multilineTextAlignment(.center)
    }
}

struct ResetPasswordField: View {
    @Binding var Email: String
    var body: some View {
        VStack {
            HStack {
                Image("Bowl_now_pin").resizable()
                    .scaledToFit()
                    .frame(maxWidth: 10, maxHeight: 30, alignment: .center)
                    .padding(.leading)
                TextField("Enter your email", text: $Email)
                    .foregroundColor(.black)
                    .padding()
                    .keyboardType(.emailAddress)
            }
        }.background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()
    }
}

