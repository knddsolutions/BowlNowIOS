//
//  UserDataModel.swift
//  BowlNow
//
//  Created by Kyle Cermak on 3/18/21.
//

import Foundation
import SwiftUI

//Decode user type
struct AuthSuccess: Decodable {
    let `Type`: String
}

//Decode returned authtoken and accesslevel
struct LoginSuccess: Decodable {
    let AuthToken, AccessLevel: String
}

//Decode array of users
struct UserResults: Decodable {
    var Results: [UserObject]
}

//Decode each user object in array
struct UserObject: Decodable, Hashable, Encodable{
    let FirstName: String
    let LastName: String
    let CenterMoid: String
    let BirthDate: String
    let `Type`: String
    let IamUserMoid: String
    let Moid: String
    var Points: Int?
    var PointsMoid: String?
}

//Decode array of user points
struct UserPoints: Decodable {
    var Results: [UserPointsObject]
}

//Decode each user points object in array
struct UserPointsObject: Decodable, Hashable {
    let Points: Int
    let CenterUserMoid: String
    let CenterMoid: String
    let Moid: String
}
