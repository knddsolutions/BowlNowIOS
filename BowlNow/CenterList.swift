//
//  CenterList.swift
//  BowlNow!
//
//  Created by Kyle Cermak on 1/26/21.
//

import SwiftUI
import UIKit
import Kingfisher
import Foundation


struct CenterList: View {
    @State var viewRouter = ViewRouter()
    @State var showingHome:Bool = false
    let centerData: [CenterData] = Bundle.main.decode("centers.json")
    var body: some View {
        VStack {
            ScrollView {
                NavigationLink(destination: TabbedView(viewRouter: ViewRouter()), isActive: $showingHome) { EmptyView() }
                ForEach(centerData, id: \.id) { center in
                    let url = URL(string: center.Logo)
                    Button(action: {
                        self.showingHome.toggle()
                    }) {
                        KFImage(url)
                            .placeholder {
                            // Placeholder while downloading.
                            Image(systemName: "arrow.2.circlepath.circle")
                                .font(.largeTitle)
                                .opacity(0.3)
                        }
                        .retry(maxCount: 3, interval: .seconds(5))
                        .onSuccess { r in
                            // r: RetrieveImageResult
                            print("success: \(r)")
                        }
                        .onFailure { e in
                            // e: KingfisherError
                            print("failure: \(e)")
                        }
                        .cancelOnDisappear(true)
                            .resizable()
                            .scaledToFit()
                    }
                    Divider()
                }
            }.navigationBarTitle("Centers", displayMode: .inline)
        }
    }
}

//TODO REQUEST FOR ALL ACTIVE AND REGISTERED CENTERS
//PULL URL'S AND STORE IN ARRAY


struct CenterList_Previews: PreviewProvider {
    static var previews: some View {
        CenterList()
    }
}
