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
    @State var showQR = false
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Spacer()
                VStack {
                    switch viewRouter.currentPage {
                     case .home:
                        Home()
                     case .loyalty:
                         Loyalty()
                     case .coupons:
                         Coupons()
                     case .account:
                         MyAccount()
                    }
                    Spacer()
                    ZStack {
                        HStack {
                            TabBarIcon(viewRouter: viewRouter, assignedPage: .home,width: geometry.size.width/5, height: geometry.size.height/20, systemIconName: "homekit", tabName: "Home")
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
                                    .rotationEffect(Angle(degrees: showQR ? 90 : 0))
                             }.offset(y: -geometry.size.height/6/3)
                            .onTapGesture {
                                showQR.toggle()
                            }
                            TabBarIcon(viewRouter: viewRouter, assignedPage: .coupons,width: geometry.size.width/5, height: geometry.size.height/20, systemIconName: "bookmark.circle.fill", tabName: "Coupons")
                            TabBarIcon(viewRouter: viewRouter, assignedPage: .account,width: geometry.size.width/5, height: geometry.size.height/20, systemIconName: "info.circle", tabName: "About")
                        }.background(Color(.white).shadow(radius: 5))
                    }
                }.navigationBarTitle("", displayMode: .inline).navigationBarItems(trailing: Image("BowlNow_Logo").resizable().scaledToFit().frame(maxWidth: 50)).frame(width: geometry.size.width).edgesIgnoringSafeArea(.all).sheet(isPresented: self.$showQR) {
                    PlusMenu()
            }
            }
        }
    }
}

struct HomeTwo_Previews: PreviewProvider {
    static var previews: some View {
        TabbedView(viewRouter: ViewRouter())
    }
}

struct PlusMenu: View {
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    var body: some View {
        VStack {
            Spacer()
            Text("Scan this QR code")
            Image(uiImage: generateQRCode(from: "This is an example"))
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            Spacer()
            Text("Swipe down to close")
            VStack {
                LinearGradient(gradient: Gradient(colors: [.white, (Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))]), startPoint: .top, endPoint: .bottom)
                        .mask(Image(systemName: "arrow.down")
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                            .padding())
            }.frame(width: 50, height: 50).padding(.bottom)
        }
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
        } .foregroundColor(viewRouter.currentPage == assignedPage ? Color(.black) : (Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0)))
    }
}

