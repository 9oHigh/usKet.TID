//
//  Label + Extension.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/21.
//

import Foundation
import UIKit

extension UIButton {
    func toCustomButton(){
        self.titleLabel?.tintColor = .black
        self.titleLabel?.font = UIFont(name: MainViewController.originalFont, size: 22)
    }
}

