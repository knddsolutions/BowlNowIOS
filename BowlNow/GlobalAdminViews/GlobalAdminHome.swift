//
//  AdminHome.swift
//  BowlNow
//
//  Created by Kyle Cermak on 2/28/21.
//

import SwiftUI

struct GlobalAdminHome: View {
    @State private var message: String = ""
    @State private var title: String = ""
    @State private var showingAlert = false
    @State private var pendingCenters: [CenterObject] = []
    var requests = GlobalRequests()
    var body: some View {
        VStack {
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
                            print("Approved \(center.Moid)")
                        }) {
                            Text("Approve").foregroundColor(.black)
                        }.frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50).buttonStyle(BorderlessButtonStyle()).background(Color(.green)).cornerRadius(10).padding()
                        Button(action: {
                            print("Declined")
                        }) {
                            Text("Decline").foregroundColor(.black)
                        }.buttonStyle(BorderlessButtonStyle()).frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50).background(Color(.red)).cornerRadius(10).padding()
                    }
                }
            }
        }.onAppear(perform: {
            CheckToken()
        }).alert(isPresented: $showingAlert) {
            Alert(title: Text((title)), message: Text((message)), dismissButton: .default(Text("OK")))
            
        }
    }
    func CheckToken() {
        if UserDefaults.standard.string(forKey: "AuthToken") != nil {
            let AuthToken: String = UserDefaults.standard.string(forKey: "AuthToken") ?? ""
            requests.GetPendingCenters(AuthToken: AuthToken) {(success, message, pendingData) in
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

struct AdminHome_Previews: PreviewProvider {
    static var previews: some View {
        GlobalAdminHome()
    }
}
