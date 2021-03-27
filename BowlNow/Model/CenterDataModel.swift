//
//  CenterDataModel.swift
//  BowlNow
//
//  Created by Kyle Cermak on 2/19/21.
//

import Foundation
import SwiftUI

struct ApiResponse: Decodable {
    let Results: String
}

struct CentersList: Decodable{
    var Results: [CenterObject]
}

struct CenterObject: Decodable, Hashable{
    let Platform: String
    let Email: String
    let MemberID: String
    let Center: String
    let Status: String
    let Path: String?
    let Timestamp: String
    let Moid: String
    let BannerURL: String?
}
