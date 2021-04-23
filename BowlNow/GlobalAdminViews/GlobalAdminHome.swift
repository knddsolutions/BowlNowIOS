//
//  AdminHome.swift
//  BowlNow
//
//  Created by Kyle Cermak on 2/28/21.
//

import SwiftUI

struct GlobalAdminHome: View {
    @State private var showingPendingCenters: Bool = false
    @State private var showingPatchCenter: Bool = false
    @Binding var ActiveCenters: [CenterObject]
    var body: some View {
        GeometryReader { geometry in
            VStack {
                NavigationLink(destination: PendingPatchCenter(ActiveCenters: $ActiveCenters), isActive: $showingPatchCenter) { EmptyView() }
                NavigationLink(destination: PendingCenters(), isActive: $showingPendingCenters) { EmptyView() }
                Text("Hello Global Admin,")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth:.infinity, alignment: .leading)
                    .padding()
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                Text("What would you like to do today?")
                    .bold()
                    .padding(.horizontal)
                    .frame(maxWidth:.infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                Spacer()
                Button(action: {
                    showingPendingCenters.toggle()
                }) {
                    Text("Get Pending Centers")
                        .foregroundColor(.white)
                        .bold()
                }.frame(maxWidth: .infinity, maxHeight: geometry.size.height/12)
                .background(Color(red: 131/255, green: 202/255, blue: 238/255, opacity: 1.0))
                .cornerRadius(10)
                .padding(.horizontal)
                Button(action: {
                    showingPatchCenter.toggle()
                }) {
                    Text("Patch Image Url")
                        .foregroundColor(.white)
                        .bold()
                }.frame(maxWidth: .infinity, maxHeight: geometry.size.height/12)
                .background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                .cornerRadius(10)
                .padding()
                Spacer()
            }.onAppear(perform: {
                print(ActiveCenters)
            })
        }
    }
}

