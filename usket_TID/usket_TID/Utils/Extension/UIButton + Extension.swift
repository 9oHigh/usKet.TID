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
        self.titleLabel?.font = UIFont(name: Helper.shared.originalFont, size: 22)
    }
    
    func getOpacity(alpha : CGFloat){
        self.alpha = alpha
    }
    
    //팅기는 효과를 줄수 있음
    //무슨 코드인지는 이해가 안된당..
    func bounceAnimation(){
        // 목적지 비율
        self.transform = CGAffineTransform(scaleX: 0.70, y: 0.70)
        // 해당 이미지뷰에 애니메이션
        UIImageView.animate(withDuration: 1.25,
                            delay: 0,
                            usingSpringWithDamping: 0.2,
                            initialSpringVelocity: 2.0,
                            options: .allowUserInteraction,
                            animations: { [weak self] in
            self?.transform = .identity
        },
        completion: nil)
    }
    
    func borderConfig(){
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 15
    }
}
