//
//  HomeTwo.swift
//  BowlNow
//
//  Created by Kyle Cermak on 2/10/21.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct TabbedView: View {
    @ObservedObject var viewRouter: ViewRouter
    @Binding var rootIsActive:Bool
    @State var showQR = false
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Spacer()
                VStack {
                    switch viewRouter.currentPage {
                     case .home:
                        Home(rootIsActive: self.$rootIsActive)
                     case .loyalty:
                        Loyalty()
                     case .coupons:
                        Coupons()
                     case .account:
                        MyAccount(rootIsActive: $rootIsActive)
                    }
                    Spacer()
                    ZStack {
                        HStack {
                            TabBarIcon(viewRouter: viewRouter, assignedPage: .home,width: geometry.size.width/5, height: geometry.size.height/20, systemIconName: "house.fill", tabName: "Home")
                            TabBarIcon(viewRouter: viewRouter, assignedPage: .loyalty,width: geometry.size.width/5, height: geometry.size.height/20, systemIconName: "crown.fill", tabName: "Loyalty")
                            ZStack {
                                 Circle()
                                     .foregroundColor((Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0)))
                                     .frame(width: geometry.size.width/5, height: geometry.size.width/5)
                                Image(systemName: "qrcode")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(Color(.white))
                                    .frame(width: geometry.size.width/8 , height: geometry.size.width/8)
                             }.offset(y: -geometry.size.height/6/3)
                            .onTapGesture {
                                showQR.toggle()
                            }
                            TabBarIcon(viewRouter: viewRouter, assignedPage: .coupons,width: geometry.size.width/5, height: geometry.size.height/20, systemIconName: "bookmark.circle.fill", tabName: "Coupons")
                            TabBarIcon(viewRouter: viewRouter, assignedPage: .account,width: geometry.size.width/5, height: geometry.size.height/20, systemIconName: "person.circle.fill", tabName: "Account")
                        }
                    }.frame(height: geometry.size.height/8)
                    .background(Color(.white)
                                    .shadow(radius: 2))
                }.frame(width: geometry.size.width)
                .edgesIgnoringSafeArea(.bottom)
                .sheet(isPresented: self.$showQR) {
                    PlusMenu()
                }
            }
        }
    }
}


struct PlusMenu: View {
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    @State var Fname: String = UserDefaults.standard.string(forKey: "Fname") ?? ""
    @State var Points: String = UserDefaults.standard.string(forKey: "Points") ?? ""
    @State var Email: String = UserDefaults.standard.string(forKey: "storeEmail") ?? ""
    @State var CenterUserID: String = UserDefaults.standard.string(forKey: "CenterUserMoid") ?? ""
    @State var PointsMoid: String = UserDefaults.standard.string(forKey: "PointsMoid") ?? ""
    @State var CenterMoid: String  = UserDefaults.standard.string(forKey: "CenterMoid") ?? ""
    var body: some View {
        VStack {
            Spacer()
            Text("Scan this QR code")
                .font(.headline)
                .bold()
                .foregroundColor(.white)
            Image(uiImage: generateQRCode(from: "\(self.CenterUserID)\n\(self.Fname)\n\(self.Email)\n\(self.CenterMoid)\n\(self.Points)\n\(self.PointsMoid)"))
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .foregroundColor(.white)
            Spacer()
            VStack {
                Text("Swipe down to close")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
                Image(systemName: "arrow.down")
                    .frame(width: 35, height: 35, alignment: .center)
                    .foregroundColor(.white)
            }.padding(.bottom)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
        .edgesIgnoringSafeArea(.bottom)
    }
    func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct TabBarIcon: View {
    @ObservedObject var viewRouter: ViewRouter
    let assignedPage: Page
    let width, height: CGFloat
    let systemIconName, tabName: String
    var body: some View {
        VStack {
            Image(systemName: systemIconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
            Text(tabName)
                .font(.footnote)
        }.padding(.horizontal, -4).onTapGesture {
            viewRouter.currentPage = assignedPage
        } .foregroundColor(viewRouter.currentPage == assignedPage ? (Color(red: 131/255, green: 202/255, blue: 238/255, opacity: 1.0)) : (Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0)))
    }
}

