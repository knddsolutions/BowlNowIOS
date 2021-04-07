//
//  UserDataModel.swift
//  BowlNow
//
//  Created by Kyle Cermak on 3/18/21.
//

import Foundation
import SwiftUI

struct AuthSuccess: Decodable {
    let `Type`: String
}

struct LoginSuccess: Decodable {
    let AuthToken, AccessLevel: String
}

struct UserResults: Decodable {
    var Results: [UserObject]
}

struct UserObject: Decodable, Hashable{
    let FirstName: String
    let LastName: String
    let CenterMoid: String
    let BirthDate: String
    let `Type`: String
    let IamUserMoid: String
    let Moid: String
}

struct resetResponse: Decodable {
    let Results: String
}
