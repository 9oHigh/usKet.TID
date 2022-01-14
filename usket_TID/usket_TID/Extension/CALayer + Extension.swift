//
//  CALayer + Extension.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/26.
//

import Foundation
import UIKit

extension CALayer {
    //Layer에 선넣어주기
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            
            let border = CALayer()
            
            switch edge {
                
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height - 20)
                break
            default:
                break
            }
            
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}

