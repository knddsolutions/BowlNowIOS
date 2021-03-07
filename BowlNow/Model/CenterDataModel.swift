//
//  CenterDataModel.swift
//  BowlNow
//
//  Created by Kyle Cermak on 2/19/21.
//

import Foundation
import SwiftUI

struct CenterData: Codable, Identifiable {
    let id: String
    let MemberID: String
    let Email: String
    let Logo: String
}

struct ApiResponse: Decodable {
    let Results: String
}

struct PendingCentersList: Decodable{
    var Results: [PendingCenterObject]
}

struct PendingCenterObject: Decodable{
    let Platform: String
    let Email: String
    let MemberID: String
    let Center: String
    let Status: String
    let Path: String?
    let Timestamp: String
    let Moid: String
    
}
