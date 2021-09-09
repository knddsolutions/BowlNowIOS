//
//  AboutCenterAccount.swift
//  BowlNow
//
//  Created by Kyle Cermak on 8/18/21.
//

import SwiftUI

struct AboutCenterAccount: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading) {
                    Spacer()
                    Text("Center Accounts")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                        .padding(.horizontal)
                    Text("These accounts are for bowling center proprietors only who wish to join our program. Signing up for this type of account indicates an interest from a particular center to have themselves listed in our active centers section. Essentially a bowling center proprietor will need this account in order for his or her customers to use their loyalty programs.")
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

struct AboutCenterAccount_Previews: PreviewProvider {
    static var previews: some View {
        AboutCenterAccount()
    }
}
