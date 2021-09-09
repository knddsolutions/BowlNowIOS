//
//  Help.swift
//  BowlNow
//
//  Created by Kyle Cermak on 4/24/21.
//

import SwiftUI
import UIKit
import MessageUI

struct Help: View {
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    LogoView()
                    AboutView()
                }
                VStack(alignment: .leading) {
                    QuestionView1()
                    QuestionView2()
                }.padding()
                .background(Color.white)
            }.navigationBarTitle("", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("BowlNow Support")
                        .bold()
                        .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                }
            }
        }
    }
}

struct QuestionView1: View {
    @State private var showAnswer1: Bool = false
    @State private var showAnswer2: Bool = false
    @State private var showAnswer3: Bool = false
    @State private var showAnswer4: Bool = false
    @State private var showAnswer5: Bool = false
    var body: some View {
        Group {
            Text("FAQ's")
                .font(.title)
                .bold()
                .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
            DisclosureGroup("Why can't I find a bowling center in the available centers list? ", isExpanded: $showAnswer1) {
                Text("If you cannot find the center you are looking for, the center has not yet registered with our platform. Contact the center for more information on their enrollment.")
                    .frame(maxWidth:.infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                    .padding(.top)
            }.fixedSize(horizontal: false, vertical: true)
            .onTapGesture {
                withAnimation {showAnswer1.toggle() }
                    }
            Divider()
                .padding([.top, .bottom])
            DisclosureGroup("How do I use my QR code?", isExpanded: $showAnswer2) {
                Text("On the home page, tap the center button in the tab bar and it will display your QR code. Show this to the centers staff after bowling to add or redeem points.")
                    .frame(maxWidth:.infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                    .padding(.top)
            }.fixedSize(horizontal: false, vertical: true)
            .onTapGesture {
                withAnimation {showAnswer2.toggle() }
                    }
            Divider()
                .padding([.top, .bottom])
            DisclosureGroup("How many centers can I join?", isExpanded: $showAnswer3) {
                Text("You may be a user of any and all available centers, but you may only create one user account per center.")
                    .frame(maxWidth:.infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                    .padding(.top)
            }.fixedSize(horizontal: false, vertical: true)
            .onTapGesture {
                withAnimation {showAnswer3.toggle() }
                    }
            Divider()
                .padding([.top, .bottom])
            DisclosureGroup("How do I register as a bowling center?", isExpanded: $showAnswer4) {
                Text("To register as a bowling center you must return to the login screen and tap signup. On the sign-up view, tap the button labeled center. Fill out the short form and press register.")
                    .frame(maxWidth:.infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                    .padding(.top)
            }.fixedSize(horizontal: false, vertical: true)
            .onTapGesture {
                withAnimation {showAnswer4.toggle() }
                    }
            Divider()
                .padding([.top, .bottom])
            DisclosureGroup("How do I become a center admin?", isExpanded: $showAnswer5) {
                Text("The email address used to register a center must also be used to create a user account. This user account will then have access to that specific centers administrative privalages.")
                    .frame(maxWidth:.infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                    .padding(.top)
            }.fixedSize(horizontal: false, vertical: true)
            .onTapGesture {
                withAnimation {showAnswer5.toggle() }
                    }
        }
    }
}

struct QuestionView2: View {
    @State private var showAnswer6: Bool = false
    @State private var showAnswer7: Bool = false
    var body: some View {
        Group {
            Divider()
                .padding([.top, .bottom])
            DisclosureGroup("How do I use my coupons?", isExpanded: $showAnswer6) {
                Text("The email address used to register a center must also be used to create a user account. This user account will then have access to that specific centers administrative privalages.")
                    .frame(maxWidth:.infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                    .padding(.top)
            }.fixedSize(horizontal: false, vertical: true)
            .onTapGesture {
                withAnimation {showAnswer6.toggle() }
                    }
            Divider()
                .padding([.top, .bottom])
            DisclosureGroup("Can I recieve more coupons?", isExpanded: $showAnswer7) {
                Text("The email address used to register a center must also be used to create a user account. This user account will then have access to that specific centers administrative privalages.")
                    .frame(maxWidth:.infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                    .padding(.top)
            }.fixedSize(horizontal: false, vertical: true)
            .onTapGesture {
                withAnimation {showAnswer7.toggle() }
                    }
        }
    }
}

struct AboutView: View {
    @State private var showEmail: Bool = false
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("The Developer")
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
                Link("https://www.knddsolutions.com", destination: URL(string: "https://www.knddsolutions.com")!)
                    .font(.subheadline)
                    .foregroundColor(.blue)
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
            Button(action: {
                let mailtoString = "mailto:k.development@knddsolutions.com?subject=Suggestions And Feedback&body=Dear BowlNow,".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

                let mailtoUrl = URL(string: mailtoString!)!
                if UIApplication.shared.canOpenURL(mailtoUrl) {
                        UIApplication.shared.open(mailtoUrl, options: [:])
                }
            }) {
                Text("Contact Us")
                    .foregroundColor(.white)
            }.frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
            .background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
            .cornerRadius(10)
            .padding()
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
            .padding(.top)
    }
}

struct Help_Previews: PreviewProvider {
    static var previews: some View {
        Help()
    }
}
