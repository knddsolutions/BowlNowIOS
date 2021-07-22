//
//  MyCenters.swift
//  ThePerfectGame
//
//  Created by Kyle Cermak on 1/24/21.
//

import SwiftUI
import UIKit
import Kingfisher
import Foundation


struct MyCenters: View {
    @State var isHome: Bool = false
    @State private var showingCenterAdminHome: Bool = false
    @State private var showingAllCenters: Bool = false
    @Binding var ActiveCenters: [CenterObject]
    @Binding var rootIsActive: Bool
    @State var MyCenterData: [UserObject] = []
    var body: some View {
        GeometryReader { geometry in
            VStack{
                NavigationLink(destination: TabbedView(viewRouter: ViewRouter(), rootIsActive: $rootIsActive), isActive: $isHome) { EmptyView() }
                NavigationLink(destination: CenterAdminHome(), isActive: $showingCenterAdminHome) { EmptyView() }
                NavigationLink(destination: CenterList(rootIsActive: $rootIsActive, ActiveCenters: $ActiveCenters), isActive: $showingAllCenters) { EmptyView() }
                ScrollView {
                    ForEach(ActiveCenters, id: \.Moid) { center in
                        if let index =  MyCenterData.firstIndex(where: {$0.CenterMoid == center.Moid}) {
                            let BannerString = center.BannerURL
                            self.MakeButton(BannerString: BannerString ?? "", index: index, BowlingCenter: center)
                        }
                    }
                    NavigationLink(
                        destination: CenterList(rootIsActive: $rootIsActive, ActiveCenters: $ActiveCenters),
                        label: {
                            Text("+ ADD CENTER")
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight:50, maxHeight: 50)
                                .font(.system(size: 18))
                                .padding()
                                .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0), style: StrokeStyle(lineWidth: 4.0, lineCap: .round, dash: [20, 10])))
                        }).padding()
                }.background(Image("retro_background")
                                .resizable()
                                .scaledToFill()
                                .opacity(0.1))
                .edgesIgnoringSafeArea(.bottom)
            }.navigationBarTitle("", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("My Centers")
                        .bold()
                        .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.showingAllCenters.toggle()
                    }) {
                        Text("+ ADD")
                            .bold()
                            .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                    }
                }
            }
            .onAppear(perform: {
                if let data = UserDefaults.standard.data(forKey: "MyCenters") {
                    do {
                        // Create JSON Decoder
                        let decoder = JSONDecoder()

                        // Decode Note
                        self.MyCenterData = try decoder.decode([UserObject].self, from: data)
                        print("Centers decoded")
                        

                    } catch {
                        print("Unable to Decode Notes (\(error))")
                    }
                } else {
                    print("No data found in cache")
                }
            })
        }
    }
    
    func MakeButton(BannerString: String, index: Int, BowlingCenter: CenterObject) -> some View {
        let BannerURL = URL(string: BannerString)!
        return VStack {
            Button(action: {
                UserDefaults.standard.set(MyCenterData[index].FirstName, forKey: "Fname")
                UserDefaults.standard.set(MyCenterData[index].LastName, forKey: "Lname")
                UserDefaults.standard.set(MyCenterData[index].BirthDate, forKey: "Birthday")
                UserDefaults.standard.set(MyCenterData[index].Points, forKey: "Points")
                UserDefaults.standard.set(MyCenterData[index].Moid, forKey: "CenterUserMoid")
                UserDefaults.standard.set(MyCenterData[index].PointsMoid, forKey: "PointsMoid")
                UserDefaults.standard.set(BowlingCenter.BannerURL, forKey: "BannerURL")
                UserDefaults.standard.set(BowlingCenter.Center, forKey: "CenterName")
                UserDefaults.standard.set(BowlingCenter.Moid, forKey: "CenterMoid")
                //TODO SAVE Points DATA
                if MyCenterData[index].Type == "Admin" {
                    self.showingCenterAdminHome.toggle()
                } else {
                    self.isHome.toggle()
                }
            }) {
                KFImage(BannerURL)
                    .placeholder {
                    // Placeholder while downloading.
                    Image(systemName: "arrow.2.circlepath.circle")
                        .font(.largeTitle)
                        .opacity(0.3)
                    }
                    .resizable()
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
            Divider()
        }
    }
}


