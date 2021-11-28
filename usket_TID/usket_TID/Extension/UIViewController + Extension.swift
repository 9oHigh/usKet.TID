//
//  UIViewController + Extension.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/27.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title : String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "화인", style: .default,handler: nil)
        
        alert.addAction(ok)
        present(alert, animated: true,completion: nil)
    }
}
