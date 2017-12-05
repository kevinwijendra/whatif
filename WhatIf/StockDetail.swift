//
//  StockDetail.swift
//  WhatIf
//
//  Created by Kevin Wijendra on 12/5/17.
//  Copyright © 2017 Kevin Wijendra. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class StockDetail {
    
    var stockSymbol = ""
    var initialPrice = 0.0
    var currentPrice = 0.0
    
    func getStockData(completed: @escaping () -> ()) {
        var date = Date()
        var calander = Calendar.current
        var day = calander.component(.day, from: date)
        var month = calander.component(.month, from: date)
        var year = calander.component(.year, from: date)
        var weekday = calander.component(.weekday, from: date)
        let time = calander.component(.hour, from: date)
        var newday = ""
        var newmonth = ""
        var newyear = ""
        
        func monthCatagory(month: Int) -> Int {
            if month == 3 {
                return 1
            } else if (month == 1 || month == 5 || month == 7 || month == 9 || month == 11) {
                return 2
            } else {
                return 3
            }
        }
        
        let monthType = monthCatagory(month: month)
        
        switch time {
        case 0...10:
            if day == 1 {
                if weekday == 1 {
                    weekday = 7
                } else {
                    weekday = weekday - 1
                }
                if monthType == 1 {
                    day = 27
                } else if monthType == 2 {
                    day = 29
                } else {
                    day = 30
                }
                if month == 1 {
                    month = 12
                    year = year - 1
                } else {
                    month = month - 1
                }
            } else {
                day = day - 1
            }
            
        default:
            print("After market opens.")
        }
        
        if weekday == 1 {
            if day == 1 {
                if monthType == 1 {
                    day = 27
                } else if monthType == 2 {
                    day = 29
                } else {
                    day = 30
                }
                if month == 1 {
                    month = 12
                    year = year - 1
                } else {
                    month = month - 1
                }
            } else if day == 2 {
                if monthType == 1 {
                    day = 26
                } else if monthType == 2 {
                    day = 28
                } else {
                    day = 29
                }
                if month == 1 {
                    month = 12
                    year = year - 1
                } else {
                    month = month - 1
                }
            } else {
                day = day - 2
            }
        } else if weekday == 7 {
            if day == 1 {
                if monthType == 1 {
                    day = 28
                } else if monthType == 2 {
                    day = 30
                } else {
                    day = 31
                }
            } else {
                day = day - 1
            }
        }
        
        newday = "\(day)"
        newmonth = "\(month)"
        newyear = "\(year)"
        for index in 1...9 {
            if day == index {
                newday = "0\(day)"
            }
            if month == index {
                newmonth = "0\(month)"
            }
        }
        
        
        let today = "\(newyear)-\(newmonth)-\(newday)"
        
        switch day {
        case 1...7 :
            if month == 1 {
                newmonth = "12"
                newyear = "\(year - 1)"
            } else {
                newmonth = "\(month - 1)"
            }
            if monthType == 1 {
                newday = "\(28-(8-day))"
            } else if monthType == 2 {
                newday = "\(30-(8-day))"
            } else {
                newday = "\(31-(8-day))"
            }
        default:
            newday = "\(day-7)"
        }
        
        let lastweek = "\(newyear)-\(newmonth)-\(newday)"
        
        let searchURL = urlBase + stockSymbol + apiKey
        Alamofire.request(searchURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let currentPrice = json["Time Series (Daily)"][today]["4. close"].string {
                    self.currentPrice = Double(currentPrice)!
                } else {
                    print("Current Price could not be recovered")
                }
                if let intialPrice = json["Time Series (Daily)"][lastweek]["4. close"].string {
                    self.initialPrice = Double(intialPrice)!
                } else {
                    print("Initial Price could not be recoverd.")
                }
            case .failure(let error):
                print(error)
            }
            completed()
        }
    }
}
