//
//  AboutUserAccount.swift
//  BowlNow
//
//  Created by Kyle Cermak on 8/18/21.
//

import SwiftUI

struct AboutUserAccount: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading) {
                    Spacer()
                    Text("User Accounts")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                        .padding(.horizontal)
                    Text("These accounts are the foundation of our platform and the vast majority of all accounts that are created with BowlNow. These types of accounts can be used by anyone wishing to become part of a loyalty and coupon program with their local center or centers. Each user may only have one user account, but can be a member of multiple different bowling centers.")
                        .bold()
                        .padding()
                    Spacer()
                    SwipeDown()
                        .frame(maxWidth: .infinity, alignment: .center)
                }.background(Image("retro_background")
                                .resizable()
                                .frame(width: geometry.size.width)
                                .edgesIgnoringSafeArea(.all)
                                .opacity(0.1))
            }
        }
    }
}

struct AboutUserAccount_Previews: PreviewProvider {
    static var previews: some View {
        AboutUserAccount()
    }
}
