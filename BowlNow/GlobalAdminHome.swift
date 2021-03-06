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
    @State private var pendingCenters = []
    var requests = GlobalRequests()
    @State var authToken: String = UserDefaults.standard.string(forKey: "AuthToken") ?? ""
    var body: some View {
        VStack {
            Text("Hi")
        }.onAppear(perform: {
            requests.GetPendingCenters(AuthToken: authToken) {(success, message, pendingData) in
                if success == true {
                    self.pendingCenters = pendingData
                    print(pendingCenters)
                }
                else {
                    self.message = message
                    self.showingAlert.toggle()
                }
            }
        }).alert(isPresented: $showingAlert) {
            Alert(title: Text((title)), message: Text((message)), dismissButton: .default(Text("OK")))
            
        }
    }
}

struct AdminHome_Previews: PreviewProvider {
    static var previews: some View {
        GlobalAdminHome()
    }
}
