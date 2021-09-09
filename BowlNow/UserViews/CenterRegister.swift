//
//  CenterRegister.swift
//  ThePerfectGame
//
//  Created by Kyle Cermak on 1/24/21.
//

import SwiftUI

struct CenterRegister: View {
    @Environment(\.colorScheme) var colorScheme
    var requests = GlobalRequests()
    private let platform: String =  "BowlingCenter"
    @State private var Center: String = ""
    @State private var Email: String = ""
    @State private var MemberID: String = ""
    @State private var showingAlert = false
    @State private var showingAboutCenterAccount: Bool = false
    @State var message: String = ""
    @State var title: String = ""
    @State private var isLoading: Bool = false
    @Binding var isShowingCenter: Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom){
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
                    Text("Center Registration")
                        .font(.title)
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                    Spacer()
                    VStack(spacing: 10) {
                        CenterNameField(Center: $Center)
                        CenterEmailField(Email: $Email)
                        CenterBpaaField(MemberID: $MemberID)
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
                    .shadow(radius: 10.0)
                    .padding(.horizontal)
                    Spacer()
                    Button(action: {
                        self.showingAboutCenterAccount.toggle()
                    }){
                        HStack{
                            Text("What is a center account?")
                                .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                            Image(systemName: "arrow.right")
                                .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                        }
                    }
                    Spacer()
                }.sheet(isPresented: $showingAboutCenterAccount, content: {
                    AboutCenterAccount()
                })
                if isLoading {
                    LoadingView()
                }
            }.navigationBarTitle("",displayMode: .inline)
            .navigationBarHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Center Accounts")
                        .bold()
                        .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text((title)), message: Text((message)), dismissButton: .default(Text("OK")){
                    isShowingCenter.toggle()
                })
            }
            .onTapGesture {
                self.endTextEditing()
            }
        }
    }
    
    func CheckFields() {
        if (self.Email.count == 0) {
            self.message = "Please enter an email address"
            self.showingAlert = true
        }
        else if (self.Center.count == 0) {
            self.message = "Please enter a center name"
        }
        else {
            self.isLoading.toggle()
            requests.CenterRegistration(center: self.Center, email: self.Email, memberID: self.MemberID, platform: self.platform) {(success, message, pendingData) in
                if success == true {
                    self.title = "Success!"
                    self.message = message
                    self.isLoading.toggle()
                    self.showingAlert.toggle()
                }
                else {
                    self.title = "Center Registration Failed!"
                    self.message = message
                    self.isLoading.toggle()
                    self.showingAlert.toggle()
                }
            }
        }
    }
}

struct CenterNameField: View {
    @Binding var Center: String
    var body: some View {
        VStack {
            HStack {
                Image("Bowl_now_pin")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 10, maxHeight: 30, alignment: .center)
                    .padding(.leading)
                TextField("Enter your centers name", text: $Center)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .padding()
            }
        }.background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding([.top,.horizontal])
    }
}

struct CenterEmailField: View {
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
        .padding(.horizontal)
    }
}

struct CenterBpaaField: View {
    @Binding var MemberID: String
    var body: some View {
        VStack {
            HStack {
                Image("Bowl_now_pin")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 10, maxHeight: 30, alignment: .center)
                    .padding(.leading)
                TextField("BPAA number (if applicable)", text: $MemberID)
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

