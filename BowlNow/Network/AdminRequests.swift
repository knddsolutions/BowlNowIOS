//
//  AdminRequests.swift
//  BowlNow
//
//  Created by Kyle Cermak on 3/3/21.
//

import Foundation
import SwiftUI

class AdminRequests {
    typealias completion = ((_ success: Bool, _ message: String) -> Void)
    
    func PatchPoints(AuthToken: String, CenterMoid: String, points: Int, Moid: String, completion: @escaping completion) {
        
        guard let url = URL(string: "https://openbowlservice.com/api/v1/center/loyaltyPoints/\(Moid)") else {
            completion(false, "Bad Url")
            return
        }
        
        let body: [String: Int] = ["Points": points]
        
        guard let finalbody = try? JSONSerialization.data(withJSONObject: body) else {
            completion(false, "Could not create JSON body...Please try again!")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.httpBody = finalbody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(CenterMoid, forHTTPHeaderField: "Center-Moid")
        request.setValue(AuthToken, forHTTPHeaderField: "X-Auth-Token")
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse{
                if httpResponse.statusCode == 200{
                    guard let data = data else {
                        completion(false, "Bad JSON...Please try again!")
                        return
                    }
                    guard let finalData = try? JSONDecoder().decode(ApiResponse.self, from: data) else {
                        completion(false, "Could not decode JSON...Please try again!")
                        return
                    }
                    DispatchQueue.main.async {
                        completion(true, finalData.Results)
                        return
                    }
                }
                else if httpResponse.statusCode == 400{
                    guard let data = data else {
                        completion(false, "Bad JSON...Please try again!")
                        return
                    }
                    guard let finalData = try? JSONDecoder().decode(ApiResponse.self, from: data) else {
                        completion(false, "Could not decode JSON...Please try again!")
                        return
                    }
                    DispatchQueue.main.async {
                        print(httpResponse.statusCode)
                        completion(false, finalData.Results)
                        }
                    return
                }
                else{
                    DispatchQueue.main.async {
                        print(httpResponse.statusCode)
                        completion(false, "Oh no! Something went wrong on our end... Please try again.")
                        }
                    return
                }
            }
        }.resume()
    }
}
