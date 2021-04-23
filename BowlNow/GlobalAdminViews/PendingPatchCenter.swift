//
//  CenterApproval.swift
//  BowlNow
//
//  Created by Kyle Cermak on 4/16/21.
//

import SwiftUI

struct PendingPatchCenter: View {
    @State private var BannerURL: String = ""
    @State private var fullPath: String = ""
    @State private var centerMoid: String = ""
    @State private var showingPatch: Bool = false
    @Binding var ActiveCenters: [CenterObject]
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ScrollView {
                    ForEach(ActiveCenters, id: \.Moid) { center in
                        if center.BannerURL == "" {
                            VStack {
                                HStack {
                                    Text("Center Name: ")
                                        .foregroundColor(.black)
                                        .bold()
                                    Spacer()
                                    Text("\(center.Center)")
                                        .foregroundColor(.black)
                                }.padding(.top)
                                HStack {
                                    Text("Moid: ")
                                        .foregroundColor(.black)
                                        .bold()
                                    Spacer()
                                    Text("\(center.Moid)")
                                        .foregroundColor(.black)
                                }.padding()
                                Button(action: {
                                    centerMoid = center.Moid
                                    showingPatch.toggle()
                                }){
                                    Text("Patch")
                                        .foregroundColor(.white)
                                }.frame(width: geometry.size.width/2, height: geometry.size.height/15)
                                .background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                                .cornerRadius(10)
                                Divider()
                            }
                        }
                    }
                }
            }.sheet(isPresented: $showingPatch) {
                PatchCenter(centerMoid: $centerMoid)
            }
        }
    }
}

