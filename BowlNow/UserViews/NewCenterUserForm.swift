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
                    Text("New User Info Required").font(.title).bold().foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                    Text("Please enter your information below to signup as a loyalty member and get exclusive bowling rewards!").padding().multilineTextAlignment(.center)
                    VStack {
                        VStack {
                            TextField("First name", text: $firstName).foregroundColor(.black).padding([.top,.horizontal])
                            Divider().padding(.horizontal)
                            TextField("Last name", text: $lastName).foregroundColor(.black).padding([.top,.horizontal])
                            Divider().padding(.horizontal)
                            TextField("Date of birth", text: $birthDate).foregroundColor(.black).padding([.top,.horizontal])
                            Divider().padding([.bottom,.horizontal])
                        }.background(Color.white).cornerRadius(10).shadow(radius: 5).padding()
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

