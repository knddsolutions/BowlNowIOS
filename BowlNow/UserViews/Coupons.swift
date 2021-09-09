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
    @State private var isShowingHelp: Bool = false
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                Image("retro_background")
                                .resizable()
                                .scaledToFill()
                                .opacity(0.1)
                NavigationLink(destination: Help(), isActive: $isShowingHelp) { EmptyView() }
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0..<4) {_ in
                            Text("Coupons go here!")
                        }.frame(width: geometry.size.width/1.20, height: geometry.size.height/1.50, alignment: .center)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding()
                    }.padding()
                }
            }.navigationBarTitle("",displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("BowlNow_Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 40)
                        .padding()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.isShowingHelp.toggle()
                    }) {
                        Text("Support")
                            .font(.headline)
                            .bold()
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }){
                        Text("My Centers")
                            .bold()
                            .font(.headline)
                    }
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
