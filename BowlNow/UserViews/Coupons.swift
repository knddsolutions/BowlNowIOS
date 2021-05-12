//
//  Coupons.swift
//  BowlNow
//
//  Created by Kyle Cermak on 2/9/21.
//

import SwiftUI

struct Coupons: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                VStack {
                   Text("Coupons go here!")
                }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                .background(Image("retro_background")
                                .resizable()
                                .aspectRatio(geometry.size, contentMode: .fill)
                                .edgesIgnoringSafeArea(.all).opacity(0.1))
                
            }
        }
    }
}

struct Coupons_Previews: PreviewProvider {
    static var previews: some View {
        Coupons()
    }
}
