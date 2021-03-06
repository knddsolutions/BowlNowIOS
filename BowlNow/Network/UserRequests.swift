//
//  UserRequests.swift
//  BowlNow
//
//  Created by Kyle Cermak on 3/2/21.
//

import Foundation
import UIKit
import SwiftUI
import Combine

class UserRequests {
    typealias completion = ((_ success: Bool, _ message: String) -> Void)
    
    func LoginRequest(email: String, password: String, completion: @escaping completion) {
        
        guard let url = URL(string: "https://openbowlservice.com/api/v1/iam/Login") else {
            completion(false, "Bad Url")
            return
        }
              
        let body: [String: String] = ["Email": email, "Password": password]
              
        guard let finalbody = try? JSONSerialization.data(withJSONObject: body) else {
            completion(false, "Json body is corrupt...Please try again!")
            return
        }
              
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalbody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
              
        URLSession.shared.dataTask(with: request) { (data, response, error) in
                  
            if let httpResponse = response as? HTTPURLResponse{
                if httpResponse.statusCode == 200{
                    guard let data = data else {return}
                    guard let finalData = try? JSONDecoder().decode(LoginSuccess.self, from: data) else {
                        completion(false, "Json response is corrupt...Please try again!")
                        return
                        }
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(finalData.AccessLevel, forKey: "AccessLevel")
                        UserDefaults.standard.set(finalData.AuthToken, forKey: "AuthToken")
                        let permissions = finalData.AccessLevel
                        completion(true, permissions)
                    }
                    return
                }
                    else if httpResponse.statusCode == 400{
                        guard let data = data else {return}
                        guard let finalData = try? JSONDecoder().decode(LoginFailed.self, from: data) else {
                            DispatchQueue.main.async {
                                completion(false, "Json response is corrupt...Please try again!")
                            }
                            return
                        }
                        DispatchQueue.main.async {
                            completion(false, finalData.Results)
                        }
                        return
                    }
                    else {
                        DispatchQueue.main.async {
                            completion(false, "Oh no! Something went wrong on our end... please try again later")
                        }
                    }
                }
            }.resume()
        }
    
    func UserRegistration(email: String, password: String, completion: @escaping completion) {
        guard let url =  URL(string: "https://openbowlservice.com/api/v1/iam/Register") else {
            completion(false, "Bad Url")
            return
        }
        
        let body: [String: String] = ["Email": email, "Password": password]
        
        guard let finalbody = try? JSONSerialization.data(withJSONObject: body) else {
            completion(false, "Json body is corrupt...Please try again!")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalbody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
              
        URLSession.shared.dataTask(with: request) { (data, response, error) in
                  
            if let httpResponse = response as? HTTPURLResponse{
                if httpResponse.statusCode == 200{
                    guard let data = data else {return}
                    guard let finalData = try? JSONDecoder().decode(signupResponse.self, from: data) else {
                        DispatchQueue.main.async {
                            completion(false, "Json response is corrupt...Please try again!")
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        completion(true, finalData.Results)
                    }
                    return
                }
                else if httpResponse.statusCode == 400{
                    guard let data = data else {return}
                    guard let finalData = try? JSONDecoder().decode(signupResponse.self, from: data) else {
                        DispatchQueue.main.async {
                            completion(false, "Bad Url")
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        completion(false, finalData.Results)
                    }
                    return
                }
                else {
                    DispatchQueue.main.async {
                        completion(false, "Oh no! Something went wrong on our end... please try again later")
                    }
                }
            }
        }.resume()
    }
    
    func PasswordReset(email: String, completion: @escaping completion) {
        guard let url =  URL(string: "https://openbowlservice.com/api/v1/iam/ForgotPassword") else {
            completion(false, "Bad Url")
            return 
        }
        
        let body: [String: String] = ["Email": email]
        
        guard let finalbody = try? JSONSerialization.data(withJSONObject: body) else {
            completion(false, "Json body is corrupt...Please try again!")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalbody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
              
        URLSession.shared.dataTask(with: request) { (data, response, error) in
                  
            if let httpResponse = response as? HTTPURLResponse{
                if httpResponse.statusCode == 200{
                    guard let data = data else {return}
                    guard let finalData = try? JSONDecoder().decode(resetResponse.self, from: data) else {
                        DispatchQueue.main.async {
                            completion(false, "Json response is corrupt... Please try again!")
                        }
                        return
                    }
                    DispatchQueue.main.async  {
                        completion(true, finalData.Results)
                    }
                    return
                }
                else if httpResponse.statusCode == 400{
                    guard let data = data else {return}
                    guard let finalData = try? JSONDecoder().decode(resetResponse.self, from: data) else {
                        DispatchQueue.main.async {
                            completion(false, "Json response is corrupt... Please try again!")
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        completion(false, finalData.Results)
                    }
                    return
                }
                else {
                    DispatchQueue.main.async {
                        completion(false, "Oh no! Something happened on our end... Please try again later.")
                    }
                }
            }
        }.resume()
    }
}
