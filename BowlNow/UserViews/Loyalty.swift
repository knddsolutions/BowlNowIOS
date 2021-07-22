//
//  Loyalty.swift
//  BowlNow
//
//  Created by Kyle Cermak on 2/9/21.
//

import SwiftUI

struct Loyalty: View {
    let centerUserRequests = CenterUserRequests()
    @State private var authToken: String = UserDefaults.standard.string(forKey: "AuthToken") ?? ""
    @State private var Points: Int = UserDefaults.standard.integer(forKey: "Points")
    @State private var CenterMoid: String = UserDefaults.standard.string(forKey: "CenterMoid") ?? ""
    @State var Fname: String = UserDefaults.standard.string(forKey: "Fname") ?? ""
    @State var Lname: String = UserDefaults.standard.string(forKey: "Lname") ?? ""
    @State private var showingAlert: Bool = false
    @State private var message: String = ""
    @State private var title: String = ""
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    VStack {
                        Text("Current Points")
                            .font(.subheadline)
                            .foregroundColor(Color(red: 131/255, green: 202/255, blue: 238/255, opacity: 1.0))
                            .bold()
                            .padding()
                        Spacer()
                        LinearGradient(gradient: Gradient(colors: [(Color(red: 131/255, green: 202/255, blue: 238/255, opacity: 1.0)), (Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))]),
                                       startPoint: .leading,
                                       endPoint: .trailing)
                            .mask(Text("\(Points)")
                                    .font(.system(size: 70))
                                    .bold())
                            .frame(maxHeight: geometry.size.height/10)
                        Spacer()
                        Button(action: {
                            centerUserRequests.GetLoyaltyPoints(AuthToken: authToken, CenterMoid: CenterMoid) {(success, message, userPoints) in
                                if success == true {
                                    for user in userPoints {
                                        UserDefaults.standard.set(user.Points, forKey: "Points")
                                        self.Points = user.Points
                                    }
                                }
                                else {
                                    self.title = "Failed To Load Data"
                                    self.message = message
                                }
                            }
                        }) {
                            Text("Refresh Points")
                                .foregroundColor(.white)
                                .bold()
                        }.frame(width: geometry.size.width/2, height: geometry.size.height/15)
                        .background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                        .cornerRadius(10)
                        Spacer()
                    }.frame(width: geometry.size.width, height: geometry.size.height/2)
                    VStack {
                        Text("Description")
                    }.frame(width: geometry.size.width, height: geometry.size.height/2)
                    .background(Color(.white))
                }
            }.background(Image("retro_background")
                            .resizable()
                            .aspectRatio(geometry.size, contentMode: .fill)
                            .opacity(0.1))
            .alert(isPresented: $showingAlert) {
                Alert(title: Text((title)), message: Text((message)), dismissButton: .default(Text("OK")))
            }.navigationBarTitle("",displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                        .frame(width: geometry.size.width/2, height:30)
                        .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                        .overlay(Text("\(Fname) \(Lname)")
                                    .bold()
                                    .foregroundColor(.white), alignment: .center)
                }
            }
        }
    }
}

struct Loyalty_Previews: PreviewProvider {
    static var previews: some View {
        Loyalty()
    }
}
