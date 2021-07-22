//
//  EditableCenters.swift
//  BowlNow
//
//  Created by Kyle Cermak on 6/27/21.
//

import SwiftUI
import Kingfisher

struct EditableCenters: View {
    @Binding var ActiveCenters: [CenterObject]
    var globalAdminRequests = GlobalRequests()
    @State private var authToken: String = UserDefaults.standard.string(forKey: "AuthToken") ?? ""
    @State private var message: String = ""
    @State private var title: String = ""
    @State private var showingAlert: Bool = false
    @State private var selectedCenter: Center?
    var body: some View {
        ScrollView {
            ForEach(ActiveCenters, id: \.Moid) { center in
                let url = URL(string: center.BannerURL!)
                Button(action: {
                    self.title = "Are you sure you want to do this?"
                    self.message = "Delete \(center.Center)"
                    selectedCenter = Center(Moid: center.Moid)
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
                }
            }
        }.alert(item: $selectedCenter) {center in
            Alert(
                title: Text(title),
                message: Text(message),
                primaryButton: .destructive(Text("Delete")) {
                    globalAdminRequests.CenterDelete(Moid: center.Moid, AuthToken: authToken) {(success, message, emptyData) in
                        if success == true {
                            print("success")
                        } else {
                            print("Failed")
                        }
                    }
                },
                secondaryButton: .cancel()
            )
        }
    }
}

struct Center: Identifiable {
    var id: String { Moid }
    let Moid: String
}
