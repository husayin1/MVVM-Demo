//
//  AppCommon.swift
//  EVA
//
//  Created by husayn on 21/07/2024.
//

import SwiftUI


class AppCommon{
    
    static func getFontColor()->Color{
        
        let fontColor = (isMorning() ? Color.black : Color.white)
        
        return fontColor
    }
    
    static func getDayByDate(dateString: String?) -> String {
        
        guard let dateString = dateString else { return "Day" }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        guard let yourDate = dateFormatter.date(from: dateString) else {
            print("Invalid date string")
            return ""
        }
        
        let calendar = Calendar.current
        let dayOfWeek = calendar.component(.weekday, from: yourDate)
        let weekdays = calendar.shortWeekdaySymbols
        var dayOfWeekString = weekdays[dayOfWeek - 1]
        
        if calendar.isDateInToday(yourDate) {
            dayOfWeekString = "Today"
        }
        
        return dayOfWeekString+"  "
    }
    
    static func getIconName(urlString: String?) -> String{
        
        guard let urlString = urlString else { return "AppIcon" }
        
        let components = urlString.split(separator: "/")
        let nameComponents = components.last?.split(separator: ".") ?? []
        let name = nameComponents.first ?? "AppIcon"
        let day = components[components.count - 2]
        
        return (day == "day" ? "day_" : "" ) + String(name)
    }
    
    static func formateHour(hourString: String?) -> String{
        guard let hourString = hourString else { return "12 AM" }
        
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            guard let date = dateFormatter.date(from: hourString) else {
                return "Invalid Date"
            }
            
            let calendar = Calendar.current
            let currentDate = Date()
            
            if calendar.isDateInToday(date), calendar.component(.hour, from: date) == calendar.component(.hour, from: currentDate) {
                return "Now   "
            } else {
                dateFormatter.dateFormat = "hh a"
                return dateFormatter.string(from: date)
            }
    }
    
    static func isMorning()->Bool{
        let currentTime = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: currentTime)
        let backgroundImage: Image
        return hour >= 5 && hour < 18
    }
    
    
}
