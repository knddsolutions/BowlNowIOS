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
    @State var message: String = ""
    @State var title: String = ""
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
                    Text("Center Account")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                    Text("Note: This will be verified by BowlNow!")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                    Spacer()
                    Text("Please fill out our form below:")
                        .padding([.horizontal,.top])
                        .frame(maxWidth:.infinity, alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true)
                    VStack {
                        VStack {
                            CenterNameField(Center: $Center)
                            CenterEmailField(Email: $Email)
                            CenterBpaaField(MemberID: $MemberID)
                        }
                        Button(action: {
                            CheckFields()
                        }){
                            Text("Create Account").foregroundColor(.white).bold()
                        }.frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                        .background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                        .cornerRadius(10)
                        .padding([.horizontal, .bottom])
                    }.background(Color(.white))
                    .cornerRadius(10)
                    .shadow(radius: 10.0)
                    .padding(.horizontal)
                    Spacer()
                    SwipeDown()
                }.background(Image("retro_background")
                                .resizable()
                                .aspectRatio(geometry.size, contentMode: .fill)
                                .edgesIgnoringSafeArea(.all).opacity(0.1))
                .navigationBarTitle("", displayMode: .inline)
            }
            .navigationBarTitle("",displayMode: .inline)
            .navigationBarHidden(true)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text((title)), message: Text((message)), dismissButton: .default(Text("OK")))
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
            requests.CenterRegistration(center: self.Center, email: self.Email, memberID: self.MemberID, platform: self.platform) {(success, message, pendingData) in
                if success == true {
                    self.title = "Success!"
                    self.message = message
                    self.showingAlert.toggle()
                }
                else {
                    self.title = "Center Registration Failed!"
                    self.message = message
                    self.showingAlert.toggle()
                }
            }
        }
    }
}

struct CenterNameField: View {
    @Binding var Center: String
    var body: some View {
        HStack {
            Image(systemName: "person")
                .padding()
                .foregroundColor(.black)
            VStack{
                TextField("Enter your centers name", text: $Center).foregroundColor(.black)
                Divider()
            }
        }.background(Color(.white))
        .cornerRadius(10)
        .opacity(0.9)
        .padding([.horizontal, .top])
    }
}

struct CenterEmailField: View {
    @Binding var Email: String
    var body: some View {
        HStack {
            Image(systemName: "lock")
                .foregroundColor(.black)
                .padding()
            VStack{
                TextField("Enter your email", text: $Email).foregroundColor(.black)
                Divider()
            }
        }.background(Color(.white))
        .cornerRadius(10)
        .opacity(0.9)
        .padding(.horizontal)
    }
}

struct CenterBpaaField: View {
    @Binding var MemberID: String
    var body: some View {
        HStack {
            Image(systemName: "lock")
                .foregroundColor(.black)
                .padding()
            VStack {
                TextField("BPAA number (if applicable)", text: $MemberID).foregroundColor(.black)
                Divider()
            }
        }.background(Color(.white))
        .cornerRadius(10)
        .opacity(0.9)
        .padding([.horizontal,.bottom])
    }
}

struct CenterRegister_Previews: PreviewProvider {
    static var previews: some View {
        CenterRegister()
    }
}
