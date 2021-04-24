//
//  PendingCenters.swift
//  BowlNow
//
//  Created by Kyle Cermak on 4/23/21.
//

import SwiftUI

struct PendingCenters: View {
    @State private var pendingCenters: [CenterObject] = []
    @State var isShowingApproval: Bool = false
    @State private var message: String = ""
    @State private var title: String = ""
    @State private var showingAlert = false
    var globalAdminRequests = GlobalRequests()
    var body: some View {
        VStack {
            PendingCentersListView(pendingCenters: $pendingCenters)
            RefreshButton(pendingCenters: $pendingCenters)
        }
    }
}

struct PendingCentersListView: View {
    @Binding var pendingCenters: [CenterObject]
    var globalAdminRequests = GlobalRequests()
    @State var CenterMoid: String = ""
    @State private var message: String = ""
    @State private var title: String = ""
    @State private var showingAlert = false
    var body: some View {
        List {
            ForEach(pendingCenters, id: \.self) { center in
                HStack {
                    Text("Center Name:").font(.headline)
                    Spacer()
                    Text("\(center.Center)").font(.headline)
                }
                HStack {
                    Text("Bpaa #:").font(.headline)
                    Spacer()
                    Text("\(center.MemberID)").font(.headline)
                }
                HStack {
                    Text("Moid:").font(.headline)
                    Spacer()
                    Text("\(center.Moid)").font(.headline)
                }
                HStack {
                    Button(action: {
                        self.CenterMoid = center.Moid
                        let AuthToken: String = UserDefaults.standard.string(forKey: "AuthToken") ?? ""
                        globalAdminRequests.ApproveCenter(AuthToken: AuthToken, Moid: CenterMoid) {(success, message, emptyData) in
                            if success == true {
                                self.title = "Success!"
                                self.message = "Center has been approved"
                            }
                            else {
                                self.title = "Approval has failed!"
                                self.message = message
                            }
                            self.showingAlert.toggle()
                        }
                    }) {
                        Text("Approve").foregroundColor(.black)
                    }.frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                    .buttonStyle(BorderlessButtonStyle())
                    .background(Color(.green))
                    .cornerRadius(10)
                    .padding()
                    Button(action: {
                        let AuthToken: String = UserDefaults.standard.string(forKey: "AuthToken") ?? ""
                        self.CenterMoid = center.Moid
                        globalAdminRequests.DeclineCenter(AuthToken: AuthToken, Moid: CenterMoid) {(success, message, emptyData) in
                            if success == true {
                                self.title = "Success!"
                                self.message = "Center has been declined"
                            }
                            else {
                                self.title = "Failed!"
                                self.message = message
                            }
                            self.showingAlert.toggle()
                        }
                    }) {
                        Text("Decline").foregroundColor(.black)
                    }.buttonStyle(BorderlessButtonStyle()).frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                    .background(Color(.red))
                    .cornerRadius(10)
                    .padding()
                }
            }.alert(isPresented: $showingAlert) {
                Alert(title: Text((title)), message: Text((message)), dismissButton: .default(Text("OK")))
                
            }
        }
    }
}

struct RefreshButton: View {
    var globalAdminRequests = GlobalRequests()
    @Binding var pendingCenters: [CenterObject]
    @State private var message: String = ""
    @State private var title: String = ""
    @State private var showingAlert = false
    var body: some View {
        Button(action: {
            let AuthToken: String = UserDefaults.standard.string(forKey: "AuthToken") ?? ""
            globalAdminRequests.GetPendingCenters(AuthToken: AuthToken) {(success, message, pendingData) in
                if success == true {
                    pendingCenters = pendingData
                    self.message = "Centers have been refreshed"
                    self.title = "Success!"
                    self.showingAlert.toggle()
                }
                else {
                    self.message = message
                    self.showingAlert.toggle()
                }
            }
        }){
            Text("Refresh Centers").foregroundColor(.white).bold()
        }.frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
        .background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
        .cornerRadius(10)
        .padding([.horizontal,.bottom])
        .alert(isPresented: $showingAlert) {
            Alert(title: Text((title)), message: Text((message)), dismissButton: .default(Text("OK")))
            
        }.onAppear(perform: {
            CheckToken()
        })
    }
    func CheckToken() {
        if UserDefaults.standard.string(forKey: "AuthToken") != nil {
            let AuthToken: String = UserDefaults.standard.string(forKey: "AuthToken") ?? ""
            globalAdminRequests.GetPendingCenters(AuthToken: AuthToken) {(success, message, pendingData) in
                if success == true {
                    pendingCenters = pendingData
                }
                else {
                    self.message = message
                    self.showingAlert.toggle()
                }
            }
        }
    }
}
