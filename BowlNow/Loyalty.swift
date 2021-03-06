//
//  Loyalty.swift
//  BowlNow
//
//  Created by Kyle Cermak on 2/9/21.
//

import SwiftUI

struct Loyalty: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("Home_Background")
                    .resizable()
                    .aspectRatio(geometry.size, contentMode: .fill)
                    .opacity(0.9)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Hello, World!")
                }
            }
        }
    }
}

struct Loyalty_Previews: PreviewProvider {
    static var previews: some View {
        Loyalty()
    }
}
