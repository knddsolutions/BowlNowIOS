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
    @State private var counter: Int = 0
    @State var authToken: String = UserDefaults.standard.string(forKey: "AuthToken") ?? ""
    @State var firstName: String = UserDefaults.standard.string(forKey: "FirstName") ?? ""
    @State var lastName: String = UserDefaults.standard.string(forKey: "LastName") ?? ""
    @State var birthDate: String = UserDefaults.standard.string(forKey: "BirthDate") ?? ""
    @State var MyCenterData: [UserObject] = []
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
                    Spacer()
                    Text("New User Required")
                        .font(.title)
                        .bold()
                        .frame(maxWidth:.infinity, alignment: .center)
                        .padding(.horizontal)
                        .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                    /*Text("Uh oh...you are not a current user for this center. Please enter your information below to signup as a loyalty member and get exclusive bowling rewards!")
                        .bold()
                        .font(.subheadline)
                        .frame(maxWidth:.infinity, alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal)*/
                    VStack(spacing: 10){
                        FirstNameField(firstName: $firstName)
                        LastNameField(lastName: $lastName)
                        BirthDateField(birthDate: $birthDate)
                        Button(action: {
                            centerUserRequests.CreateCenterUser(fname: self.firstName, lname: self.lastName, dob: birthDate, centerMoid: centerMoid, AuthToken: authToken) {(success, message, userData) in
                                if success == true {
                                    self.title = message
                                    self.message = "Center user was created!"
                                    UserDefaults.standard.set(firstName, forKey: "FirstName")
                                    UserDefaults.standard.set(lastName, forKey: "LastName")
                                    UserDefaults.standard.set(birthDate, forKey: "BirthDate")
                                    GetNewCenterUser()
                                }
                                else {
                                    self.title = "New Center User Failed"
                                    self.message = message
                                }
                                self.showingAlert.toggle()
                            }
                        }){
                            Text("Create User")
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
                    .padding(.horizontal)
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
    
    func GetNewCenterUser() {
        centerUserRequests.GetCenterUser(AuthToken: authToken, CenterMoid: "") {(success, message, userData) in
            if success == true {
                    for var user in userData {
                        centerUserRequests.GetLoyaltyPoints(AuthToken: authToken, CenterMoid: user.CenterMoid) {(success, message, userPoints) in
                            if success == true {
                                for data in userPoints {
                                    user.Points = data.Points
                                    let newUserObject = user
                                    MyCenterData.append(newUserObject)
                                    do {
                                        // Create JSON Encoder
                                        let encoder = JSONEncoder()

                                        // Encode Note
                                        let data = try encoder.encode(MyCenterData)

                                        // Write/Set Data
                                        UserDefaults.standard.set(data, forKey: "MyCenters")

                                    } catch {
                                        print("Unable to Encode Array of Notes (\(error))")
                                    }
                                    counter+=1
                                    if counter == userData.count {
                                        counter = 0
                                    }
                                }
                            }
                            else {
                                self.title = "Failed To Load New User"
                                self.message = message
                                self.showingAlert.toggle()
                            }
                        }
                    }
                }
            else {
                self.title = "Failed To Load New User"
                self.message = message
                self.showingAlert.toggle()
            }
        }
    }
}

struct FirstNameField: View {
    @Binding var firstName: String
    var body: some View {
        VStack {
            HStack {
                Image("Bowl_now_pin")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 10, maxHeight: 30, alignment: .center)
                    .padding(.leading)
                TextField("First name", text: $firstName)
                    .foregroundColor(.black)
                    .padding()
            }
        }.background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding([.top,.horizontal])
    }
}

struct LastNameField: View {
    @Binding var lastName: String
    var body: some View {
        VStack {
            HStack {
                Image("Bowl_now_pin")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 10, maxHeight: 30, alignment: .center)
                    .padding(.leading)
                TextField("Last name", text: $lastName)
                    .foregroundColor(.black)
                    .padding()
            }
        }.background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}

struct BirthDateField: View {
    @Binding var birthDate: String
    var body: some View {
        VStack {
            HStack {
                Image("Bowl_now_pin")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 10, maxHeight: 30, alignment: .center)
                    .padding(.leading)
                TextField("Date of birth", text: $birthDate)
                    .foregroundColor(.black)
                    .padding()
            }
        }.background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding([.bottom,.horizontal])
    }
}

