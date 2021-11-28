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
    func getOpacity(alpha : CGFloat){
        self.alpha = alpha
    }
    //팅기는 효과를 줄수 있음
    //무슨 코드인지는 이해가 안된당..
    
    func bounceAnimation(){
        // 변화정도 같은건가
        self.transform = CGAffineTransform(scaleX: 0.50, y: 0.50)
        // 해당 이미지뷰에 애니메이션
        UIImageView.animate(withDuration: 2.0,
                            delay: 0,
                            usingSpringWithDamping: 0.2,
                            initialSpringVelocity: 3.0,
                            options: .allowUserInteraction,
                            animations: { [weak self] in
            self?.transform = .identity
        },
                            completion: nil)
    }
}
