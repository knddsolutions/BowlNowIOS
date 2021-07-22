//
//  CenterList.swift
//  BowlNow!
//
//  Created by Kyle Cermak on 1/26/21.
//

import SwiftUI
import UIKit
import Kingfisher
import Foundation


struct CenterList: View {
    @State var viewRouter = ViewRouter()
    var globalRequests = GlobalRequests()
    var centerUserRequests = CenterUserRequests()
    @State var showingHome:Bool = false
    @State private var title: String = ""
    @State private var message: String = ""
    @State private var imageLogo: URL?
    @State private var centerMoid: String = ""
    @State private var showingAlert: Bool = false
    @State private var showingUserForm: Bool = false
    @State private var showingCenterAdmin: Bool = false
    @State var authToken: String = UserDefaults.standard.string(forKey: "AuthToken") ?? ""
    @Binding var rootIsActive: Bool
    @Binding var ActiveCenters: [CenterObject]
    var body: some View {
        VStack {
            ScrollView {
                NavigationLink(destination: TabbedView(viewRouter: ViewRouter(), rootIsActive: $rootIsActive), isActive: $showingHome) { EmptyView() }
                NavigationLink(destination: CenterAdminHome(), isActive: $showingCenterAdmin) { EmptyView() }
                ForEach(ActiveCenters, id: \.Moid) { center in
                    let url = URL(string: center.BannerURL!)
                    Button(action: {
                        centerUserRequests.GetCenterUser(AuthToken: authToken, CenterMoid: center.Moid) {(success, message, userData) in
                            if success == true {
                                for user in userData {
                                    UserDefaults.standard.set(user.FirstName, forKey: "Fname")
                                    UserDefaults.standard.set(user.LastName, forKey: "Lname")
                                    UserDefaults.standard.set(user.BirthDate, forKey: "Birthday")
                                    UserDefaults.standard.set(center.BannerURL, forKey: "BannerURL")
                                    UserDefaults.standard.set(center.Center, forKey: "CenterName")
                                }
                                centerUserRequests.GetLoyaltyPoints(AuthToken: authToken, CenterMoid: center.Moid) {(success, message, userPoints) in
                                    if success == true {
                                        for user in userPoints {
                                            UserDefaults.standard.set(user.Points, forKey: "Points")
                                            UserDefaults.standard.set(user.CenterUserMoid, forKey: "CenterUserMoid")
                                            UserDefaults.standard.set(user.CenterMoid, forKey: "CenterMoid")
                                            UserDefaults.standard.set(user.Moid, forKey: "PointsMoid")
                                            self.showingHome.toggle()
                                        }
                                    }
                                    
                                    else {
                                        self.title = "Failed To Load User Points"
                                        self.message = message
                                        self.showingAlert.toggle()
                                    }
                                    
                                }
                            }
                            else if message == "No User Found" {
                                self.imageLogo = url!
                                self.centerMoid = center.Moid
                                self.showingUserForm.toggle()
                            }
                            else {
                                self.message = message
                                self.showingAlert.toggle()
                            }
                        }
                    }) {
                        KFImage(url)
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
                    }.sheet(isPresented: self.$showingUserForm) {
                        NewCenterUserForm(imageLogo: $imageLogo, centerMoid: $centerMoid)
                    }
                    Divider()
                }
            }.navigationBarTitle("", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("All Active Centers")
                        .bold()
                        .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                }
            }
        }.alert(isPresented: $showingAlert) {
            Alert(title: Text((title)), message: Text((message)), dismissButton: .default(Text("OK")))
            
        }
    }
}


