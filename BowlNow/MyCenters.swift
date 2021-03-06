//
//  MyCenters.swift
//  ThePerfectGame
//
//  Created by Kyle Cermak on 1/24/21.
//

import SwiftUI
import UIKit

struct MyCenters: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                VStack{
                    NavigationLink(
                        destination: CenterList(),
                        label: {
                            Text("+ ADD CENTER")
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight:0, maxHeight: 75)
                               .font(.system(size: 18))
                               .padding()
                               .foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                               .overlay(
                                   RoundedRectangle(cornerRadius: 10)
                                       .stroke(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0), style: StrokeStyle(lineWidth: 4.0, lineCap: .round, dash: [20, 10])))
                        }).padding()
                    Spacer()
                }.background(Image("retro_background").resizable()
                .aspectRatio(geometry.size, contentMode: .fill)
                .edgesIgnoringSafeArea(.all).opacity(0.1)).navigationBarTitle("My Centers", displayMode: .inline)
            }
        }
    }
    /*func GetUserData(AuthToken: String) {
    
    guard let url = URL(string: "") else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(AuthToken, forHTTPHeaderField: "X-Auth-Token")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse{
                if httpResponse.statusCode == 200{
                    
                    guard let data = data else {return}
                    guard let finalData = try? JSONDecoder().decode(DataMessage.self, from: data) else {
                        self.message = "Data is corrupt...Please try again!"
                        self.showingAlert = true
                        return
                    }
                    UserDefaults.standard.set(finalData.Points, forKey: "SavePoints")
                    UserDefaults.standard.set(finalData.Username, forKey: "SaveUsername")
                    UserDefaults.standard.set(finalData.Birthdate, forKey: "SaveBirthdate")
                    UserDefaults.standard.set(finalData.Email, forKey: "SaveEmail")
                    UserDefaults.standard.set(finalData.Phone, forKey: "SavePhone")
                    UserDefaults.standard.set(finalData.Type, forKey: "SaveType")
                    UserDefaults.standard.set(finalData.League, forKey: "SaveLeague")
                    DispatchQueue.main.async {
                        //Do something
                    }
                    return
                }
                if httpResponse.statusCode == 401{
                    DispatchQueue.main.async {
                        self.message = "Session has expired... please login again"
                        self.showingAlert = true
                        }
                    return
                }
                if httpResponse.statusCode == 404{
                    DispatchQueue.main.async {
                        self.message = "User data was not found...please try again"
                        self.showingAlert = true
                        }
                    return
                }
                if httpResponse.statusCode == 500{
                    DispatchQueue.main.async {
                        self.message = "Oops something went wrong... please try again later"
                        self.showingAlert = true
                        }
                    return
                }
            }
        }.resume()
    }*/
}

//TODO REQUEST FOR CURRENT CENTER MEMBERSHIPS

struct MyCenters_Previews: PreviewProvider {
    static var previews: some View {
        MyCenters()
    }
}
