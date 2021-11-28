//
//  TextField + Extension.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/28.
//

import Foundation
import UIKit

extension UITextField {
    func toCustomTF(){
        self.textAlignment = .center
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.borderStyle = .roundedRect
        self.attributedPlaceholder = NSAttributedString(string: "이 곳에 적어볼까요!", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
    }
}
