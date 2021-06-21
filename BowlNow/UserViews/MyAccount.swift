//
//  MyAccount.swift
//  BowlNow
//
//  Created by Kyle Cermak on 2/10/21.
//

import SwiftUI

struct MyAccount: View {
    @State var Fname: String = UserDefaults.standard.string(forKey: "Fname") ?? ""
    @State var Lname: String = UserDefaults.standard.string(forKey: "Lname") ?? ""
    @State var Points: String = UserDefaults.standard.string(forKey: "Points") ?? ""
    @State var CenterName: String = UserDefaults.standard.string(forKey: "CenterName") ?? ""
    @State var CenterUserID: String = UserDefaults.standard.string(forKey: "CenterUserMoid") ?? ""
    @State var Email: String = UserDefaults.standard.string(forKey: "storeEmail") ?? ""
    @State var BirthDate: String = UserDefaults.standard.string(forKey: "Birthday") ?? ""
    @State var FirstInitial: String = ""
    @Binding var rootIsActive: Bool
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                VStack {
                    VStack {
                        Spacer()
                        Circle()
                            .frame(width: 100, height: 100, alignment: .center)
                            .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                            .overlay(Text("\(FirstInitial)")
                                        .foregroundColor(.white)
                                        .font(.largeTitle)
                                        .bold())
                        Text("\(Fname) \(Lname)")
                            .font(.title)
                        Spacer()
                        HStack {
                            HStack {
                                Spacer()
                                Image("Bowl_now_pin").resizable().scaledToFit().frame(width: geometry.size.width/15, height: geometry.size.height/30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                Text("\(CenterName)")
                                    .font(.subheadline)
                                Spacer()
                            }
                                Divider()
                                    .frame(maxWidth:2, maxHeight:30)
                                    .background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                            HStack {
                                Spacer()
                                Image("Bowl_now_pin").resizable().scaledToFit().frame(width: geometry.size.width/15, height: geometry.size.height/30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                Text("\(Points)")
                                    .font(.subheadline)
                                Spacer()
                            }
                        }.frame(width:geometry.size.width)
                    }.frame(width: geometry.size.width, height:geometry.size.height/2)
                    ScrollView {
                        VStack(alignment: .leading, spacing: 15) {
                            HStack {
                                Text(" User ID: ")
                                    .font(.subheadline)
                                    .bold()
                                + Text("\(CenterUserID)")
                                    .font(.subheadline)
                            }.padding([.leading, .top])
                            Divider()
                            HStack {
                                Text(" First Name: ")
                                    .font(.subheadline)
                                    .bold()
                                + Text("\(Fname)")
                                    .font(.subheadline)
                            }.padding([.horizontal])
                            HStack {
                                Text(" Last Name: ")
                                    .font(.subheadline)
                                    .bold()
                                + Text("\(Lname)")
                                    .font(.subheadline)
                            }.padding([.top, .horizontal])
                            HStack {
                                Text(" Email: ")
                                    .font(.subheadline)
                                    .bold()
                                + Text("\(Email)")
                                    .font(.subheadline)
                            }.padding([.top, .horizontal])
                            HStack {
                                Text(" Birthdate: ")
                                    .font(.subheadline)
                                    .bold()
                                + Text("\(BirthDate)")
                                    .font(.subheadline)
                            }.padding()
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                            }){
                                Text("Change My Center")
                                    .foregroundColor(.white)
                                    .bold()
                            }.frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50).background(Color(red: 131/255, green: 202/255, blue: 238/255, opacity: 1.0))
                            .cornerRadius(10)
                            .padding([.horizontal])
                            .padding(.bottom, 5)
                            Button(action: {
                                rootIsActive.toggle()
                            }){
                                Text("Log Out")
                                    .foregroundColor(.white)
                                    .bold()
                            }.frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50).background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                            .cornerRadius(10)
                            .padding(.horizontal)
                        }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color(.white))
                    }
                }
            }.edgesIgnoringSafeArea(.all)
        }.onAppear(perform: {
            self.FirstInitial = String(Fname.prefix(1))
        })
    }
}

