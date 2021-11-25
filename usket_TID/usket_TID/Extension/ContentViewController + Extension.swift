//
//  ContentViewController + Extension.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/26.
//

import Foundation
import UIKit

extension ContentViewController : UITextViewDelegate {
    
    func placeholderSetting() {
        defineTextView.delegate = self
        defineTextView.text = "이곳에 적어볼까요!"
        defineTextView.textColor = UIColor.lightGray
        
    }
    // TextView Place Holder
    func textViewDidBeginEditing(_ textView: UITextView) {
        defineTextView.layer.borderColor = UIColor.lightGray.cgColor
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        
    }
    // TextView Place Holder
    func textViewDidEndEditing(_ textView: UITextView) {
        defineTextView.layer.borderColor = UIColor.lightGray.cgColor
        if textView.text.isEmpty {
            textView.text = "이곳에 적어볼까요!"
            textView.textColor = UIColor.lightGray
        }
    }
}
