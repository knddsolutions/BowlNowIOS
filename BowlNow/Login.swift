//
//  ContentView.swift
//  BowlNow!
//
//  Created by Kyle Cermak on 1/24/21.
//

import SwiftUI
import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import AuthenticationServices

enum ModalView {
    case forgotPassword
    case signUp
}

struct Login: View {
    @Environment(\.colorScheme) var colorScheme
    let request = UserRequests()
    @State var authToken: String = UserDefaults.standard.string(forKey: "AuthToken") ?? ""
    @State var email: String = UserDefaults.standard.string(forKey: "storeEmail") ?? ""
    @State var password: String = UserDefaults.standard.string(forKey: "storePassword")
        ?? ""
    @State private var showingSignUp = false
    @State private var showingForgotPassword = false
    @State private var remember: Bool = true
    @State private var showingAlert = false
    @State private var showModal = false
    @State private var isUserLogged: Bool = false
    @State private var isAdminLogged: Bool = false
    @State var modalView: ModalView?
    @State var message: String = ""
    @State var title: String = ""
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .bottom) {
                    Image("Ball_Return")
                        .resizable()
                        .aspectRatio(geometry.size, contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                    RoundedRectangle(cornerRadius: 10).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).foregroundColor(.white).frame(width: geometry.size.width, height: geometry.size.height/3, alignment: .bottom)
                        VStack {
                            Image("BowlNow_Logo").resizable().scaledToFit().frame(maxWidth: 250)
                            Spacer()
                        VStack {
                            VStack {
                                HStack {
                                    Image(systemName: "person")
                                        .foregroundColor(.gray)
                                        .padding()
                                    TextField("Enter your email", text: $email).foregroundColor(.black)
                                }
                            }.background(colorScheme == .dark ? Color.black : Color.white).cornerRadius(10).shadow(radius: 5).padding([.horizontal, .top])
                            VStack {
                                HStack {
                                    Image(systemName: "lock")
                                        .foregroundColor(.gray)
                                        .padding()
                                    TextField("Enter your password", text: $password).foregroundColor(.black)
                                }
                            }.background(colorScheme == .dark ? Color.black : Color.white).cornerRadius(10).shadow(radius: 5).padding(.horizontal)
                            HStack {
                                Toggle(isOn: $remember) {
                                    Text("Remember Me").foregroundColor(.gray)
                                }.toggleStyle(CheckboxToggleStyle()).padding([.leading,.bottom])
                                Spacer()
                                NavigationLink(destination: GlobalAdminHome(), isActive: $isAdminLogged) { EmptyView() }
                                NavigationLink(destination: MyCenters(), isActive: $isUserLogged) { EmptyView() }
                                Button(action: {
                                    if (self.email.count == 0) {
                                        self.message = "Email cannot be empty"
                                        self.showingAlert = true
                                    }
                                    else if (self.password.count == 0) {
                                        self.message = "Password cannot be empty"
                                        self.showingAlert = true
                                    }
                                    else {
                                        request.LoginRequest(email: self.email, password: self.password) {(success, message) in
                                            if success == true && message == "User" {
                                                self.isUserLogged.toggle()
                                            }
                                            else if success == true && message == "Admin" {
                                                self.isAdminLogged.toggle()
                                            }
                                            else {
                                                self.title = "Login Failed!"
                                                self.message = message
                                                self.showingAlert.toggle()
                                            }
                                        }
                                    }
                                    if self.remember {
                                        SaveData(email: self.email, password: self.password)
                                        }
                                }){
                                    Text("Sign In").foregroundColor(.white).bold()
                                }.frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                                .background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                                .cornerRadius(10)
                                .padding([.horizontal,.bottom])
                            }.padding(.top)
                        }.background(Color(.white))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .shadow(radius: 3)
                        .navigationBarTitle("Login")
                        .navigationBarHidden(true)
                        VStack {
                            FacebookButton().frame(width: .infinity, height: 40).cornerRadius(10).padding([.horizontal,.top])
                            if #available(iOS 14.0, *) {
                                VStack {
                                    SignInWithAppleButton(.signIn,              //1
                                         onRequest: { (request) in             //2
                                           //Set up request
                                         },
                                         onCompletion: { (result) in           //3
                                           switch result {
                                           case .success(let authorization):
                                               //Handle autorization
                                               break
                                           case .failure(let error):
                                               //Handle error
                                               break
                                           }
                                         })
                               }.signInWithAppleButtonStyle(.black).frame(width: .infinity, height: 40).cornerRadius(10).padding([.horizontal])            //4
                            } else {
                                // Fallback on earlier versions
                            }
                        }
                        Spacer()
                        HStack {
                            Button(action: {
                                self.showingSignUp = true
                            }){
                                Text("Sign Up").foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                            }.sheet(isPresented: self.$showingSignUp) {
                                SignUp()
                            }
                            Spacer()
                            Divider()
                                .frame(maxWidth:2,maxHeight:30)
                                .background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                            Spacer()
                            Button(action: {
                                self.showingForgotPassword = true
                            }){
                                Text("Forgot Password?").foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                            }.sheet(isPresented: self.$showingForgotPassword) {
                                ForgotPassword()
                            }
                            Spacer()
                            Divider()
                                .frame(maxWidth:2,maxHeight:30)
                                .background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                            Spacer()
                            Button(action: {
                                let formattedString = "https://chicagolandbowlingservice.com/privacy-policy"
                                let url = URL(string: formattedString)!
                                UIApplication.shared.open(url)
                            }){
                                Text("Privacy").foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                            }
                        }.padding([.horizontal,.bottom])
                    }
                }
            }.alert(isPresented: $showingAlert) {
                Alert(title: Text((title)), message: Text((message)), dismissButton: .default(Text("OK")))
                
            }
        }
    }
}


//TODO CHECK IF FACEBOOK USER IS ALREADY LOGGED IN
struct LoginFailed: Decodable {
    let Results : String
}
struct LoginSuccess: Decodable {
    let AuthToken, AccessLevel: String
}
func SaveData(email: String, password: String) {
    UserDefaults.standard.set(email, forKey: "storeEmail")
    UserDefaults.standard.set(password, forKey: "storePassword")
}

struct FacebookButton: UIViewRepresentable {
    
    func makeUIView(context:Context) -> FBLoginButton{
        let button = FBLoginButton()
        return button
    }
    
    func updateUIView(_ uiVIew: FBLoginButton, context: UIViewRepresentableContext<FacebookButton>) {
        
    }
}
struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            configuration.label
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 22, height: 22)
                .foregroundColor(.gray)
                .onTapGesture { configuration.isOn.toggle() }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}

