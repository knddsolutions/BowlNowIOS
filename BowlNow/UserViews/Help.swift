//
//  Help.swift
//  BowlNow
//
//  Created by Kyle Cermak on 4/24/21.
//

import SwiftUI

struct Help: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                QuestionView1()
                QuestionView2()
            }.padding()
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
                    .font(.subheadline)
                    .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
            }.fixedSize(horizontal: false, vertical: true)
            Divider()
                .padding([.top, .bottom])
            DisclosureGroup("How do I use my QR code?", isExpanded: $showAnswer2) {
                Text("On the home page, tap the center button in the tab bar and it will display your QR code. Show this to the centers staff after bowling to add or redeem points.")
                    .font(.subheadline)
                    .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
            }.fixedSize(horizontal: false, vertical: true)
            Divider()
                .padding([.top, .bottom])
            DisclosureGroup("How many centers can I join?", isExpanded: $showAnswer3) {
                Text("You may be a user of any and all available centers, but you may only create one user account per center.")
                    .font(.subheadline)
                    .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
            }.fixedSize(horizontal: false, vertical: true)
            Divider()
                .padding([.top, .bottom])
            DisclosureGroup("How do I register as a bowling center?", isExpanded: $showAnswer4) {
                Text("To register as a bowling center you must return to the login screen and tap signup. On the sign-up view, tap the button labeled center. Fill out the short form and press register.")
                    .font(.subheadline)
                    .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
            }.fixedSize(horizontal: false, vertical: true)
            Divider()
                .padding([.top, .bottom])
            DisclosureGroup("How do I become a center admin?", isExpanded: $showAnswer5) {
                Text("The email address used to register a center must also be used to create a user account. This user account will then have access to that specific centers administrative privalages.")
                    .font(.subheadline)
                    .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
            }.fixedSize(horizontal: false, vertical: true)
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
                    .font(.subheadline)
                    .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
            }.fixedSize(horizontal: false, vertical: true)
            Divider()
                .padding([.top, .bottom])
            DisclosureGroup("Can I recieve more coupons?", isExpanded: $showAnswer7) {
                Text("The email address used to register a center must also be used to create a user account. This user account will then have access to that specific centers administrative privalages.")
                    .font(.subheadline)
                    .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
            }.fixedSize(horizontal: false, vertical: true)
        }
    }
}

struct Help_Previews: PreviewProvider {
    static var previews: some View {
        Help()
    }
}
