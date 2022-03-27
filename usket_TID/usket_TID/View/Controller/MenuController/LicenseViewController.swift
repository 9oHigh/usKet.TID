//
//  LicenseViewController.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/30.
//

import UIKit

final class LicenseViewController: UIViewController {

    @IBOutlet weak var contentTextView: UITextView!
    var content : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let overview = content {
            contentTextView.text = overview
        } else {
         showAlert(title: "라이선스 안내", message: "현재 해당 라이선스의 내용을 가지고 올 수 없어요.")
        }
    }
}
