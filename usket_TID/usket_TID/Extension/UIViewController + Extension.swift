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
    func showAlertCancel(title : String, message: String,handler: @escaping (UIAlertAction) -> Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default,handler: handler)
        let cancel = UIAlertAction(title: "취소", style: .default)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    func showAlertWithCancel(title : String, message: String,okHandler: @escaping (UIAlertAction) -> Void,noHandler:@escaping (UIAlertAction) -> Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default,handler: okHandler)
        let cancel = UIAlertAction(title: "취소", style: .default,handler: noHandler)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    //저장시 + 수정시 사용할 토스트 메세지
    func showToast(message : String) {
        
        //위치와 사이즈 설정
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height - self.view.frame.size.height/2 , width: 160, height: 50))
        toastLabel.font = UIFont(name: MainViewController.originalFont, size: 18)
        toastLabel.backgroundColor = UIColor.lightGray
        toastLabel.textColor = UIColor.white
        toastLabel.text = message
        toastLabel.textAlignment = .center
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.layer.borderColor = UIColor.white.cgColor
        toastLabel.layer.borderWidth = 0.5
        toastLabel.clipsToBounds = true
        toastLabel.layer.zPosition = 100
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {
            completed in
            toastLabel.removeFromSuperview()
        })
    }
}

