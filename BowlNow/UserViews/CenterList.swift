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
    @State var authToken: String = UserDefaults.standard.string(forKey: "AuthToken") ?? ""
    @Binding var ActiveCenters: [CenterObject]
    var body: some View {
        VStack {
            ScrollView {
                NavigationLink(destination: TabbedView(viewRouter: ViewRouter()), isActive: $showingHome) { EmptyView() }
                ForEach(ActiveCenters, id: \.Moid) { center in
                    let url = URL(string: center.BannerURL!)
                    Button(action: {
                        centerUserRequests.GetCenterUser(AuthToken: authToken, CenterMoid: center.Moid) {(success, message, userData) in
                            if success == true {
                                self.showingHome.toggle()
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
            }.navigationBarTitle("All Centers", displayMode: .inline)
        }.alert(isPresented: $showingAlert) {
            Alert(title: Text((title)), message: Text((message)), dismissButton: .default(Text("OK")))
            
        }
    }
}

