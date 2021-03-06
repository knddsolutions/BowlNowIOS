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
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                VStack {
                    Image("BowlNow_Logo").resizable().scaledToFit().frame(maxWidth: 150).padding(.top)
                    Text("Oops!").font(.largeTitle).bold().foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                    Text("Did you forget your password?").font(.headline).padding(.bottom)
                    Text("Please enter your email address below to recieve an account recovery email.").font(.headline).padding(.horizontal).multilineTextAlignment(.center)
                    VStack {
                        VStack {
                            TextField("Enter your email", text: $Email).foregroundColor(.black).padding()
                        }.background(Color.white).cornerRadius(10).shadow(radius: 5).padding()
                        Button(action: {
                            requests.PasswordReset(email: self.Email) {(success, message) in
                                if success == true {
                                    self.title = "Success!"
                                    self.message = message
                                }
                                else {
                                    self.title = "Reset Failed"
                                    self.message = message
                                }
                                self.showingAlert.toggle()
                            }
                        }){
                            Text("Recover Account").foregroundColor(.white).bold()
                        }.frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                        .background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                        .cornerRadius(10)
                        .padding([.horizontal,.bottom])
                    }.background(Color.white).cornerRadius(10).shadow(radius: 5).padding()
                    Spacer()
                }.background(Image("retro_background").resizable()
                                .aspectRatio(geometry.size, contentMode: .fill)
                                .edgesIgnoringSafeArea(.all).opacity(0.1))
            }.alert(isPresented: $showingAlert) {
                Alert(title: Text((title)), message: Text((message)), dismissButton: .default(Text("OK")))
                
            }
        }
    }
}

struct resetResponse: Decodable {
    let Results: String
}

struct ForgotPassword_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPassword()
    }
}
