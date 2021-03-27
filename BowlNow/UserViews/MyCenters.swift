//
//  MyCenters.swift
//  ThePerfectGame
//
//  Created by Kyle Cermak on 1/24/21.
//

import SwiftUI
import UIKit
import Kingfisher

struct MyCenters: View {
    var myCenters: [String] = UserDefaults.standard.stringArray(forKey: "MyCenters") ?? []
    var centerUserRequests = CenterUserRequests()
    @Binding var ActiveCenters: [CenterObject]
    @State var isHome: Bool = false
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                VStack{
                    ScrollView {
                        NavigationLink(destination: Home(), isActive: $isHome) { EmptyView() }
                        ForEach(ActiveCenters, id: \.Moid) { center in
                            if myCenters.contains(center.Moid) {
                                let url = URL(string: center.BannerURL!)
                                Button(action: {
                                    self.isHome.toggle()
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
                        }
                        NavigationLink(
                            destination: CenterList(ActiveCenters: $ActiveCenters),
                            label: {
                                Text("+ ADD CENTER")
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight:75, maxHeight: 75)
                                    .font(.system(size: 18))
                                    .padding()
                                    .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0), style: StrokeStyle(lineWidth: 4.0, lineCap: .round, dash: [20, 10])))
                            }).padding()
                        Spacer()
                    }
                }.background(Image("retro_background").resizable()
                                .aspectRatio(geometry.size, contentMode: .fill)
                                .edgesIgnoringSafeArea(.all).opacity(0.1)).navigationBarTitle("My Centers", displayMode: .inline)
            }
        }
    }
}

//TODO REQUEST FOR CURRENT CENTER MEMBERSHIPS

