//
//  AboutUs.swift
//  BowlNow
//
//  Created by Kyle Cermak on 2/9/21.
//

import SwiftUI

struct AboutUs: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                VStack{
                    ScrollView {
                        LogoView()
                        AboutView()
                        VStack(alignment: .leading, spacing: 10) {
                            QuestionView1()
                            QuestionView2()
                        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .padding()
                        .edgesIgnoringSafeArea(.all)
                        .background(Color.white)
                    }
                }.background(Image("retro_background").resizable()
                                .aspectRatio(geometry.size, contentMode: .fill)
                                .edgesIgnoringSafeArea(.all).opacity(0.1))
            }
        }
    }
}

struct AboutUs_Previews: PreviewProvider {
    static var previews: some View {
        AboutUs()
    }
}

struct AboutView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("About The App")
                .font(.title)
                .bold()
                .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
            Divider()
            HStack {
                Text(" Developer: ")
                    .font(.subheadline)
                    .bold()
                    + Text("K&D Design and Development")
                    .font(.subheadline)
            }
            HStack {
                Text(" Website: ")
                    .font(.subheadline)
                    .bold()
                    + Text("www.knddsolutions.com")
                    .font(.subheadline)
            }
            HStack {
                Text(" Email: ")
                    .font(.subheadline)
                    .bold()
                    + Text("k.development@knddsolutions.com")
                    .font(.subheadline)
            }
            HStack {
                Text(" Version: ")
                    .font(.subheadline)
                    .bold()
                    + Text("1.1.1")
                    .font(.subheadline)
            }
            Divider()
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding()
    }
}

struct LogoView: View {
    var body: some View {
        Image("BowlNow_Logo")
            .resizable()
            .scaledToFit()
            .frame(maxWidth: 150)
    }
}
