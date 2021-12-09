//
//  Date + Extension.swift
//  usket_TID
//
//  Created by 이경후 on 2021/12/10.
//

import Foundation
import UIKit

extension Date {
    func dateToValue() -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyy년 MM월 dd일"
        let value = format.string(from: Date())
        return value
    }
}
