//
//  ViewRouter.swift
//  BowlNow
//
//  Created by Kyle Cermak on 2/11/21.
//

import Foundation
import SwiftUI

class ViewRouter: ObservableObject {
    
    @Published var currentPage: Page = .home
    
}

enum Page {
     case home
     case loyalty
     case coupons
     case account
 }
