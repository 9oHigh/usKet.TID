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
            showAlert(title: I18N.licenseInform, message: I18N.licenseMessage)
        }
    }
}
