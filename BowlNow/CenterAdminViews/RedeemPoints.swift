//
//  RedeemPoints.swift
//  BowlNow
//
//  Created by Kyle Cermak on 6/1/21.
//

import SwiftUI

struct RedeemPoints: View {
    @State private var number = 0
    @State var isShowingReview: Bool = false
    @State private var accountPoints: String = ""
    @Binding var user: Array<String>
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack {
                    Text("Available Points: ")
                    LinearGradient(gradient: Gradient(colors: [(Color(red: 131/255, green: 202/255, blue: 238/255, opacity: 1.0)), (Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))]),
                                   startPoint: .leading,
                                   endPoint: .trailing)
                        .mask(Text("\(accountPoints)")
                                .font(.system(size: 60))
                                .bold())
                        .frame(maxHeight: geometry.size.height/10)
                    Text("Redeem Points: \(number)")
                    Picker("", selection: $number) {
                        ForEach([-100, -200, -300, -400, -500, -600, -700, -800, -900, -1000], id: \.self) {
                            Text("\($0)")
                        }
                    }
                    NavigationLink(destination: Review(user: $user, number: $number), isActive: $isShowingReview) {EmptyView()}
                    Button(action: {
                        self.isShowingReview.toggle()
                    }) {
                        HStack {
                            Text("Review")
                                .foregroundColor(.white)
                                .bold()
                            Image(systemName: "arrow.right")
                                .foregroundColor(.white)
                        }
                    }.frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                    .background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                    .cornerRadius(10)
                    .padding()
                }.frame(width: geometry.size.width, height: geometry.size.height/1.15, alignment: .center)
                .background(Color.white)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .cornerRadius(30)
                Spacer()
            }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            .background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
            .edgesIgnoringSafeArea(.all)
        }.edgesIgnoringSafeArea(.all)
        .onAppear(perform: {
            PullUserData()
        })
    }
    
    func PullUserData() {
        accountPoints = user[4]
    }
}


