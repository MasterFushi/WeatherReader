//
//  DataReader.swift
//  WeatherReader
//
//  Created by Nevin Gregory on 5/25/20.
//  Copyright © 2020 Nevin Gregory. All rights reserved.
//

import SwiftUI

extension Double
{
    func truncate(places : Int)-> Double
    {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}

class DataReader : ObservableObject {
    
    
    struct Weather: Codable, Hashable {
        var time: Int
        var summary: String
        var icon: String
        var temp: Int
        var date: Date
        var dateString: String
    }

    static var wArray = [Weather]()
    
    let dateFormatter = DateFormatter()
    
    
    init(){
        dateFormatter.dateFormat = "MM/dd/yy\nhh:mma"
        if let url = URL(string: "https://api.darksky.net/forecast/d3fba72e83fc64768952cbf06ee6e5d1/38.978291,-76.495682?exclude=currently,minutely,daily,alerts,flags") {
            URLSession.shared.dataTask(with: url) {data, response, error in
                if let data = data {
                    do{
                         let jsonResponse = try JSONSerialization.jsonObject(with:
                                                data, options: [])
                        
                        guard let newValue = jsonResponse as? [String: Any] else {
                            print("invalid format")
                            return
                        }
                        //print(newValue)
                        guard let wData = newValue["hourly"] as? [String: Any] else {
                            print("oops")
                            return
                        }
                        //print(wData)
                        guard let hData = wData["data"] as? NSArray else {
                            print("oops again")
                            return
                        }
                        
                        for i in 0..<hData.count {
                            let dData = hData[i] as! NSDictionary
                            
                            var w: Weather = Weather(time: 0, summary: "N/A", icon: "N/A", temp: 0, date: Date(timeIntervalSinceNow: 0), dateString: "N/A")
                            
                            w.time = dData.value(forKey: "time") as! Int
                            w.summary = dData.value(forKey: "summary") as! String
                            w.icon = dData.value(forKey: "icon") as! String
                            w.temp = Int(dData.value(forKey: "temperature") as! Double)
                            w.date = Date(timeIntervalSince1970: Double(w.time))
                            w.dateString = self.dateFormatter.string(from: w.date)
                            
                            DataReader.wArray.append(w)
                        }
                      } catch let parsingError {
                         print("Error", parsingError)
                    }
            }
        }.resume()
    }
}
}


