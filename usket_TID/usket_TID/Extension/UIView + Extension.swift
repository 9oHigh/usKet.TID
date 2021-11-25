//
//  UIView + Extension.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/25.
//

import Foundation
import UIKit

extension UIView {
    func toShadowView(){
        self.layer.cornerRadius = 10
        self.layer.shadowOpacity = 0.25
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = 3
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.masksToBounds = false
    }
}
