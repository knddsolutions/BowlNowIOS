//
//  PatchCenter.swift
//  BowlNow
//
//  Created by Kyle Cermak on 4/23/21.
//

import SwiftUI

struct PatchCenter: View {
    @State private var URL: String = "https://kd-openbowl-service.s3-us-west-2.amazonaws.com/centers/banners"
    @State private var BannerURL: String = ""
    @State private var Path: String = ""
    @State private var title: String = ""
    @State private var message: String = ""
    @State private var showingAlert: Bool = false
    @Binding var centerMoid: String
    var globalAdminRequests = GlobalRequests()
    var body: some View {
        GeometryReader { geometry in
            VStack {
                UrlField(Path: $Path)
                Button(action: {
                    BannerURL = URL + Path
                    let AuthToken: String = UserDefaults.standard.string(forKey: "AuthToken") ?? ""
                    globalAdminRequests.CenterPatch(BannerURL: BannerURL, Moid: centerMoid, AuthToken: AuthToken) {(success, message, emptyData) in
                        if success == true {
                            self.message = "Center data has been patched"
                            self.title = "Success!"
                        }
                        else {
                            self.message = message
                            self.title = "Failed!"
                        }
                        showingAlert.toggle()
                    }
                }) {
                    Text("Patch")
                        .foregroundColor(.white)
                }.frame(width: geometry.size.width/2, height: 40)
                .background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                .cornerRadius(10)
                .padding()
            }
        }.alert(isPresented: $showingAlert) {
            Alert(title: Text((title)), message: Text((message)), dismissButton: .default(Text("OK")))
        }
    }
}

struct UrlField: View {
    @Binding var Path: String
    var body: some View {
        VStack {
            HStack {
                Image("Bowl_now_pin").resizable().scaledToFit().frame(maxWidth: 10, maxHeight: 30, alignment: .center)
                    .padding(.leading)
                TextField("Enter url Ex. (test.png)", text: $Path)
                    .foregroundColor(.black)
                    .padding()
            }
        }.background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding([.horizontal,.top])
    }
}

