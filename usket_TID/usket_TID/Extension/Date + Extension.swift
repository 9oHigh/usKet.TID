//
//  Date + Extension.swift
//  usket_TID
//
//  Created by 이경후 on 2021/12/10.
//

import Foundation
import UIKit

extension Date {
    
    //statisticsViewController
    var day : Int {
        let calendar = Calendar.current
        return calendar.component(.day,from: self)
    }
    
    func getStart(of component: Calendar.Component, calendar: Calendar = Calendar.current) -> Date? {
        return calendar.dateInterval(of: component, for: self)?.start
    }
    
    func getEnd(of component: Calendar.Component, calendar: Calendar = Calendar.current) -> Date? {
        return calendar.dateInterval(of: component, for: self)?.end
    }
    
    //CalendarViewController
    func dateToValue() -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyy년 MM월 dd일"
        let value = format.string(from: Date())
        return value
    }
}
