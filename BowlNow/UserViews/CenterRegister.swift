//
//  CenterRegister.swift
//  ThePerfectGame
//
//  Created by Kyle Cermak on 1/24/21.
//

import SwiftUI

struct CenterRegister: View {
    @Environment(\.colorScheme) var colorScheme
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
                Spacer()
                VStack {
                    VStack {
                        HStack {
                            Text("Center Accounts").font(.largeTitle).bold().frame(maxWidth:.infinity, alignment: .leading).padding().fixedSize(horizontal: false, vertical: true).foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                        }
                        Text("A user account is intended for all levels of bowlers who desire to visit and join loyalty programs at a nearby bowling center.").frame(maxWidth:.infinity, alignment: .leading).font(.subheadline).padding(.horizontal).fixedSize(horizontal: false, vertical: true).foregroundColor(.black)
                        Text("Please fill out our form below:").frame(maxWidth:.infinity, alignment: .leading).font(.subheadline).padding().foregroundColor(.black)
                    }
                    VStack {
                        HStack {
                            Image(systemName: "person")
                            .padding().foregroundColor(.black)
                            VStack{
                            TextField("Enter your centers name", text: $Center).foregroundColor(.black)
                                Divider()
                            }
                        }.background(Color(.white)).cornerRadius(10).opacity(0.9).padding(.horizontal)
                        HStack {
                            Image(systemName: "lock")
                                .foregroundColor(.black)
                                .padding()
                            VStack{
                            TextField("Enter your email", text: $Email).foregroundColor(.black)
                                Divider()
                            }
                        }.background(Color(.white)).cornerRadius(10).opacity(0.9).padding(.horizontal)
                        HStack {
                            Image(systemName: "lock")
                                .foregroundColor(.black)
                                .padding()
                            VStack {
                            TextField("BPAA number (if applicable)", text: $MemberID).foregroundColor(.black)
                                Divider()
                            }
                        }.background(Color(.white)).cornerRadius(10).opacity(0.9).padding(.horizontal)
                        Button(action: {
                            if (self.Email.count == 0) {
                                self.message = "Please enter an email address"
                                self.showingAlert = true
                            }
                            else if (self.Center.count == 0) {
                                self.message = "Please enter a center name"
                            }
                            else {
                                self.CenterRegistration(center: self.Center, email: self.Email, memberID: self.MemberID, platform: self.platform)
                            }
                        }){
                            Text("Create Account").foregroundColor(.white).bold()
                        }.frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                        .background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0)).cornerRadius(10).padding()
                    }
                }.background(Color(.white)).cornerRadius(10).shadow(radius: 10.0).padding().navigationBarTitle("Center Registration", displayMode: .inline).navigationBarItems(trailing: Image("BowlNow_Logo").resizable().scaledToFit().frame(maxWidth: 50).padding(.top))
                Spacer()
                Text("Swipe down to close")
                VStack {
                    LinearGradient(gradient: Gradient(colors: [.white, (Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))]), startPoint: .top, endPoint: .bottom)
                            .mask(Image(systemName: "arrow.down")
                                .resizable()
                                .frame(width: 50, height: 50, alignment: .center)
                                .padding())
                }.frame(width: 50, height: 50).padding(.bottom)
            }.background(Image("retro_background").resizable()
            .aspectRatio(geometry.size, contentMode: .fill)
            .edgesIgnoringSafeArea(.all).opacity(0.1))
        }.alert(isPresented: $showingAlert) {
            Alert(title: Text((title)), message: Text((message)), dismissButton: .default(Text("OK")))
        }
    }
}
    func CenterRegistration(center: String, email: String,  memberID: String, platform: String) {
        guard let url =  URL(string: "https://openbowlservice.com/api/v1/center/registration") else {return}
        
        let body: [String: String] = ["Center": center, "Email": email, "MemberID": memberID, "Platform": platform]
        
        guard let finalbody = try? JSONSerialization.data(withJSONObject: body) else {
            self.message = "Data is corrupt...Please try again!"
            self.showingAlert = true
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalbody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
              
        URLSession.shared.dataTask(with: request) { (data, response, error) in
                  
            if let httpResponse = response as? HTTPURLResponse{
                if httpResponse.statusCode == 200{
                    guard let data = data else {return}
                    guard let finalData = try? JSONDecoder().decode(registrationResponse.self, from: data) else {
                        DispatchQueue.main.async {
                            self.message = "Data is corrupt...Please try again"
                            self.showingAlert = true
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        self.title = "Success!"
                        self.message = finalData.Results
                        self.showingAlert = true
                    }
                    return
                }
                    else if httpResponse.statusCode == 400{
                        guard let data = data else {return}
                        guard let finalData = try? JSONDecoder().decode(registrationResponse.self, from: data) else {
                            DispatchQueue.main.async {
                                self.message = "Data is corrupt...Please try again"
                                self.showingAlert = true
                            }
                            return
                        }
                        DispatchQueue.main.async {
                            self.title = "Registration Failed"
                            self.message = finalData.Results
                            self.showingAlert = true
                        }
                        return
                    }
                    else {
                        DispatchQueue.main.async {
                            print((httpResponse.statusCode))
                            self.title = "Registration Failed"
                            self.message = "Oops! Something went wrong on our end... Please try again later."
                            self.showingAlert = true
                        }
                    }
            }
        }.resume()
    }
}

struct registrationResponse: Decodable {
    let Results: String
}

struct CenterRegister_Previews: PreviewProvider {
    static var previews: some View {
        CenterRegister()
    }
}
