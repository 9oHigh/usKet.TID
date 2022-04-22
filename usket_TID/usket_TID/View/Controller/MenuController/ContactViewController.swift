//
//  ContactViewController.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/21.
//

import UIKit

final class ContactViewController: UIViewController {
    
    @IBOutlet weak var githubButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var reviewButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        githubButton.borderConfig()
        emailButton.borderConfig()
        reviewButton.borderConfig()
    }
    //클로즈
    @IBAction func closeButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func reviewButtonClicked(_ sender: UIButton) {
        guard let url = URL(string : "itms-apps://itunes.apple.com/app/1597847159?mt=8&action=write-review") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func emailButtonClicked(_ sender: UIButton) {
        let email = "usket@icloud.com"
        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func githubButtonClicked(_ sender: UIButton) {
        if let url = URL(string: "https://github.com/9oHigh") {
            UIApplication.shared.open(url, options: [:])
        }
    }
}
