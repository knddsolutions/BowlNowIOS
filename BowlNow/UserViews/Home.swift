//
//  Home.swift
//  BowlNow
//
//  Created by Kyle Cermak on 2/6/21.
//

import SwiftUI

struct Home: View {
    @State private var showingAccount: Bool = false
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top){
                Image("retro_background")
                    .resizable()
                    .aspectRatio(geometry.size, contentMode: .fill)
                    .opacity(0.2)
                    .edgesIgnoringSafeArea(.all)
                Circle().frame(width: geometry.size.width, height: geometry.size.width).offset(y: -300).foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0)).edgesIgnoringSafeArea(.all)
                Rectangle().frame(width: geometry.size.width, height: geometry.size.height/2, alignment: .top) .offset(y: geometry.size.height/2).foregroundColor(.white)
                VStack{
                    VStack {
                        Button(action: {
                            self.showingAccount.toggle()
                        }) {
                            VStack {
                                Spacer()
                                Image(systemName: "person.crop.circle.fill").resizable().scaledToFit().foregroundColor(Color(.white)).frame(width: geometry.size.width/5, height: geometry.size.height/20, alignment: .center).padding()
                                Spacer()
                            }
                        }
                    }.frame(width: geometry.size.width, height: geometry.size.height/6, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    VStack {
                        Image("logoheader").resizable().scaledToFit().padding()
                    }.frame(width: geometry.size.width, height: geometry.size.height/4, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    VStack {
                        HStack {
                            Image(systemName: "star").resizable().scaledToFit().frame(width: geometry.size.width/5, height: geometry.size.height/20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(.yellow)
                            Spacer()
                            Text("10,600 pts").font(.title).frame(maxHeight: 70)
                            Spacer()
                            Image(systemName: "star").resizable().scaledToFit().frame(width: geometry.size.width/5, height: geometry.size.height/20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(.yellow)
                        }.background(LinearGradient(gradient: Gradient(colors: [(Color(red: 131/255, green: 202/255, blue: 238/255, opacity: 1.0)), (Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))]), startPoint: .leading, endPoint: .trailing)).cornerRadius(20).padding(.horizontal)
                    }.frame(width: geometry.size.width, height: geometry.size.height/5)
                }
            }.frame(width:geometry.size.width, height:geometry.size.height).edgesIgnoringSafeArea(.all)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
