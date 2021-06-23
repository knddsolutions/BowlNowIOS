//
//  CenterUserRequests.swift
//  BowlNow
//
//  Created by Kyle Cermak on 3/18/21.
//

import Foundation
import SwiftUI

class CenterUserRequests {
    typealias completion = ((_ success: Bool, _ message: String, _ userData: [UserObject]) -> Void)
    typealias completionPoints = ((_ success: Bool, _ message: String, _ userData: [UserPointsObject]) -> Void)
    
    func GetCenterUser(AuthToken: String, CenterMoid: String, completion: @escaping completion)  {
    
        guard let url = URL(string: "https://openbowlservice.com/api/v1/center/users") else {
            completion(false, "Bad Url", [])
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if !CenterMoid.isEmpty {
            request.setValue(CenterMoid, forHTTPHeaderField: "Center-Moid")
        }
        request.setValue(AuthToken, forHTTPHeaderField: "X-Auth-Token")
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse{
                if httpResponse.statusCode == 200{
                    guard let data = data else {
                        completion(false, "Bad JSON...Please try again!", [])
                        return
                    }
                    guard let finalData = try? JSONDecoder().decode(UserResults.self, from: data) else {
                        completion(false, "Could not decode JSON...Please try again!", [])
                        return
                    }
                    DispatchQueue.main.async {
                        completion(true, "", finalData.Results)
                        return
                    }
                }
                else if httpResponse.statusCode == 400{
                    guard let data = data else {
                        completion(false, "Bad JSON...Please try again!", [])
                        return
                    }
                    guard let finalData = try? JSONDecoder().decode(ApiResponse.self, from: data) else {
                        completion(false, "Could not decode JSON...Please try again!", [])
                        return
                    }
                    DispatchQueue.main.async {
                        completion(false, finalData.Results, [])
                        }
                    return
                }
                else if httpResponse.statusCode == 403{
                    DispatchQueue.main.async {
                        completion(false, "No User Found", [])
                        }
                    return
                }
                else{
                    DispatchQueue.main.async {
                        completion(false, "Oh no! Something went wrong on our end... Please try again.", [])
                        }
                    return
                }
            }
        }.resume()
    }
    
    func CreateCenterUser(fname: String, lname: String, dob: String, centerMoid: String, AuthToken: String, completion: @escaping completion) {
        guard let url =  URL(string: "https://openbowlservice.com/api/v1/center/users") else {
            completion(false, "Bad Url", [])
            return
        }
        
        let body: [String: String] = ["FirstName": fname, "LastName": lname, "BirthDate": dob, "CenterMoid": centerMoid]
        
        guard let finalbody = try? JSONSerialization.data(withJSONObject: body) else {
            completion(false, "Could not create JSON body...Please try again!", [])
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalbody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(AuthToken, forHTTPHeaderField: "X-Auth-Token")
              
        URLSession.shared.dataTask(with: request) { (data, response, error) in
                  
            if let httpResponse = response as? HTTPURLResponse{
                if httpResponse.statusCode == 200{
                    guard let data = data else {
                        completion(false, "Bad JSON...Please try again!", [])
                        return
                    }
                    guard let finalData = try? JSONDecoder().decode(ApiResponse.self, from: data) else {
                        DispatchQueue.main.async {
                            completion(false, "Could not decode JSON...Please try again!", [])
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        completion(true, finalData.Results, [])
                    }
                    return
                }
                else if httpResponse.statusCode == 400{
                    guard let data = data else {
                        completion(false, "Bad JSON...Please try again!", [])
                        return
                    }
                    guard let finalData = try? JSONDecoder().decode(ApiResponse.self, from: data) else {
                        DispatchQueue.main.async {
                            completion(false, "Could not decode JSON...Please try again!", [])
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        completion(false, finalData.Results, [])
                    }
                    return
                }
                else {
                    DispatchQueue.main.async {
                        completion(false, "Oh no! Something went wrong on our end... please try again later", [])
                    }
                }
            }
        }.resume()
    }
    
    func GetLoyaltyPoints(AuthToken: String, CenterMoid: String, completion: @escaping completionPoints)  {
    
        guard let url = URL(string: "https://openbowlservice.com/api/v1/center/loyaltyPoints") else {
            completion(false, "Bad Url", [])
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(CenterMoid, forHTTPHeaderField: "Center-Moid")
        request.setValue(AuthToken, forHTTPHeaderField: "X-Auth-Token")
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            if let httpResponse = response as? HTTPURLResponse{
                if httpResponse.statusCode == 200 {
                    guard let data = data else {
                        completion(false, "Bad JSON...Please try again!", [])
                        return
                    }
                    guard let finalData = try? JSONDecoder().decode(UserPoints.self, from: data) else {
                        completion(false, "Could not decode JSON...Please try again!", [])
                        return
                    }
                    DispatchQueue.main.async {
                        completion(true, "", finalData.Results)
                        return
                    }
                }
                else if httpResponse.statusCode == 400 {
                    guard let data = data else {
                        completion(false, "Bad JSON...Please try again!", [])
                        return
                    }
                    guard let finalData = try? JSONDecoder().decode(ApiResponse.self, from: data) else {
                        completion(false, "Could not decode JSON...Please try again!", [])
                        return
                    }
                    DispatchQueue.main.async {
                        completion(false, finalData.Results, [])
                        }
                    return
                }
                else{
                    DispatchQueue.main.async {
                        completion(false, "Oh no! Something went wrong on our end... Please try again.", [])
                        }
                    return
                }
            }
        }.resume()
    }
}
