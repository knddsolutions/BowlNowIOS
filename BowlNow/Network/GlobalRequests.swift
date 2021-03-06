//
//  GlobalRequests.swift
//  BowlNow
//
//  Created by Kyle Cermak on 3/3/21.
//

import Foundation
import SwiftUI

class GlobalRequests {
    typealias completion = ((_ success: Bool, _ message: String, _ pendingCenters: [CenterObject]) -> Void)
    
    func GetPendingCenters(AuthToken: String, completion: @escaping completion)  {
    
        guard let url = URL(string: "https://openbowlservice.com/api/v1/center/pending") else {
            completion(false, "Bad Url", [])
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(AuthToken, forHTTPHeaderField: "X-Auth-Token")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse{
                if httpResponse.statusCode == 200{
                    guard let data = data else {
                        completion(false, "Bad JSON...Please try again!", [])
                        return
                    }
                    guard let finalData = try? JSONDecoder().decode(CentersList.self, from: data) else {
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
                else{
                    DispatchQueue.main.async {
                        completion(false, "Oh no! Something went wrong on our end... Please try again.", [])
                        }
                    return
                }
            }
        }.resume()
    }
    
    func ActiveCentersList(completion: @escaping completion)  {
    
        guard let url = URL(string: "https://openbowlservice.com/api/v1/center/registration") else {
            completion(false, "Bad Url", [])
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse{
                if httpResponse.statusCode == 200{
                    guard let data = data else {
                        completion(false, "Bad JSON...Please try again!", [])
                        return
                    }
                    guard let finalData = try? JSONDecoder().decode(CentersList.self, from: data) else {
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
                else{
                    DispatchQueue.main.async {
                        completion(false, "Oh no! Something went wrong on our end... Please try again.", [])
                        }
                    return
                }
            }
        }.resume()
    }
    
    func CenterRegistration(center: String, email: String,  memberID: String, platform: String, completion: @escaping completion) {
        guard let url =  URL(string: "https://openbowlservice.com/api/v1/center/registration") else {
            completion(false, "Bad Url", [])
            return
        }
        
        let body: [String: String] = ["Center": center, "Email": email, "MemberID": memberID, "Platform": platform]
        
        guard let finalbody = try? JSONSerialization.data(withJSONObject: body) else {
            completion(false, "Could not create JSON body...Please try again!", [])
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalbody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
              
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
                        completion(false, "Oh no! Something went wrong on our end... Please try again.", [])
                    }
                }
            }
        }.resume()
    }
    
    func CenterPatch(BannerURL: String, Moid: String, AuthToken: String, completion: @escaping completion) {
        guard let url =  URL(string: "https://openbowlservice.com/api/v1/center/registration/\(Moid)") else {
            completion(false, "Bad Url", [])
            return
        }
        
        let body: [String: String] = ["BannerURL": BannerURL]
        
        guard let finalbody = try? JSONSerialization.data(withJSONObject: body) else {
            completion(false, "Could not create JSON body...Please try again!", [])
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
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
                    guard let finalData = try? JSONDecoder().decode(CenterObject.self, from: data) else {
                        DispatchQueue.main.async {
                            completion(false, "Could not decode JSON...Please try again!", [])
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        completion(true, finalData.BannerURL ?? "", [])
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
                        completion(false, "Oh no! Something went wrong on our end... Please try again.", [])
                    }
                }
            }
        }.resume()
    }
    
    func CenterDelete(Moid: String, AuthToken: String, completion: @escaping completion) {
        guard let url =  URL(string: "https://openbowlservice.com/api/v1/center/registration/\(Moid)") else {
            completion(false, "Bad Url", [])
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
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
                        completion(false, "Oh no! Something went wrong on our end... Please try again.", [])
                    }
                }
            }
        }.resume()
    }
    
    func ApproveCenter(AuthToken: String, Moid: String, completion: @escaping completion) {
        guard let url =  URL(string: "https://openbowlservice.com/api/v1/center/pending/\(Moid)") else {
            completion(false, "Bad Url", [])
            return
        }
        
        let body: [String: String] = [:]
        
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
                        completion(false, "Oh no! Something went wrong on our end... Please try again.", [])
                    }
                }
            }
        }.resume()
    }
    
    func DeclineCenter(AuthToken: String, Moid: String, completion: @escaping completion) {
        guard let url =  URL(string: "https://openbowlservice.com/api/v1/center/pending/\(Moid)") else {
            completion(false, "Bad Url", [])
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
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
                        completion(false, "Oh no! Something went wrong on our end... Please try again.", [])
                    }
                }
            }
        }.resume()
    }
}
