//
//  Coupons.swift
//  BowlNow
//
//  Created by Kyle Cermak on 2/9/21.
//

import SwiftUI

struct Coupons: View {
    @State var Fname: String = UserDefaults.standard.string(forKey: "Fname") ?? ""
    @State var Lname: String = UserDefaults.standard.string(forKey: "Lname") ?? ""
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0..<4) {_ in
                            Text("Coupons go here!")
                        }.frame(width: geometry.size.width/1.20, height: geometry.size.height/1.50, alignment: .center)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding()
                    }
                }.padding().background(Image("retro_background")
                                .resizable()
                                .aspectRatio(geometry.size, contentMode: .fill)
                                .opacity(0.1))
            }.navigationBarTitle("",displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                        .frame(width: geometry.size.width/2, height:30)
                        .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                        .overlay(Text("\(Fname) \(Lname)")
                                    .bold()
                                    .foregroundColor(.white), alignment: .center)
                }
            }
        }
    }
}

struct Coupons_Previews: PreviewProvider {
    static var previews: some View {
        Coupons()
    }
}
