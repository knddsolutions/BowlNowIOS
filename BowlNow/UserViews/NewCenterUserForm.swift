//
//  NewCenterUserForm.swift
//  BowlNow
//
//  Created by Kyle Cermak on 3/16/21.
//

import SwiftUI
import Kingfisher

struct NewCenterUserForm: View {
    var centerUserRequests = CenterUserRequests()
    @Binding var imageLogo: URL?
    @Binding var centerMoid: String
    @State private var message: String = ""
    @State private var title: String = ""
    @State private var showingAlert = false
    @State var authToken: String = UserDefaults.standard.string(forKey: "AuthToken") ?? ""
    @State var firstName: String = UserDefaults.standard.string(forKey: "FirstName") ?? ""
    @State var lastName: String = UserDefaults.standard.string(forKey: "LastName") ?? ""
    @State var birthDate: String = UserDefaults.standard.string(forKey: "BirthDate") ?? ""
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                VStack {
                    KFImage(imageLogo)
                        .placeholder {
                        // Placeholder while downloading.
                        Image(systemName: "arrow.2.circlepath.circle")
                            .font(.largeTitle)
                            .opacity(0.3)
                    }
                    .retry(maxCount: 3, interval: .seconds(5))
                    .onSuccess { r in
                        // r: RetrieveImageResult
                        print("success: \(r)")
                    }
                    .onFailure { e in
                        // e: KingfisherError
                        print("failure: \(e)")
                    }
                    .cancelOnDisappear(true)
                        .resizable()
                        .scaledToFit()
                        .padding(.top)
                    VStack {
                        Text("New User Info Required")
                            .font(.title2)
                            .bold()
                            .frame(maxWidth:.infinity, alignment: .leading)
                            .padding().fixedSize(horizontal: false, vertical: true)
                            .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                        Text("Uh oh...you are not a current user for this center. Please enter your information below to signup as a loyalty member and get exclusive bowling rewards!")
                            .frame(maxWidth:.infinity, alignment: .leading)
                            .font(.subheadline)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.horizontal)
                        VStack {
                            FirstNameField(firstName: $firstName)
                            LastNameField(lastName: $lastName)
                            BirthDateField(birthDate: $birthDate)
                        }.background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding()
                        Button(action: {
                            centerUserRequests.CreateCenterUser(fname: self.firstName, lname: self.lastName, dob: birthDate, centerMoid: centerMoid, AuthToken: authToken) {(success, message, userData) in
                                if success == true {
                                    self.title = message
                                    self.message = "Center user was created!"
                                    UserDefaults.standard.set(firstName, forKey: "FirstName")
                                    UserDefaults.standard.set(lastName, forKey: "LastName")
                                    UserDefaults.standard.set(birthDate, forKey: "BirthDate")
                                }
                                else {
                                    self.title = "Center User Failed"
                                    self.message = message
                                }
                                self.showingAlert.toggle()
                            }
                        }){
                            Text("Create User").foregroundColor(.white).bold()
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
                }.background(Image("retro_background").resizable()
                                .aspectRatio(geometry.size, contentMode: .fill)
                                .edgesIgnoringSafeArea(.all).opacity(0.1))
            }.alert(isPresented: $showingAlert) {
                Alert(title: Text((title)), message: Text((message)), dismissButton: .default(Text("OK")))
                
            }
        }
    }
}

struct FirstNameField: View {
    @Binding var firstName: String
    var body: some View {
        HStack {
            Image(systemName: "person")
                .padding()
                .foregroundColor(.black)
            VStack{
                TextField("First name", text: $firstName)
                    .foregroundColor(.black)
                    .padding(.top)
                    .padding(.trailing)
                Divider()
                    .padding(.trailing)
            }
        }.background(Color(.white))
        .cornerRadius(10)
        .opacity(0.9)
        .padding([.horizontal,.top])
    }
}

struct LastNameField: View {
    @Binding var lastName: String
    var body: some View {
        HStack {
            Image(systemName: "person")
                .padding()
                .foregroundColor(.black)
            VStack{
                TextField("Last name", text: $lastName)
                    .foregroundColor(.black)
                    .padding(.top)
                    .padding(.trailing)
                Divider()
                    .padding(.trailing)
            }
        }.background(Color(.white))
        .cornerRadius(10)
        .opacity(0.9)
        .padding(.horizontal)
    }
}

struct BirthDateField: View {
    @Binding var birthDate: String
    var body: some View {
        HStack {
            Image(systemName: "person")
                .padding()
                .foregroundColor(.black)
            VStack{
                TextField("Date of birth", text: $birthDate)
                    .foregroundColor(.black)
                    .padding(.top)
                    .padding(.trailing)
                Divider()
                    .padding(.bottom)
                    .padding(.trailing)
            }
        }.background(Color(.white))
        .cornerRadius(10)
        .opacity(0.9)
        .padding([.horizontal,.bottom])
    }
}

