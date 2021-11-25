//
//  ContentViewController.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/21.
//

import UIKit
//정의와 의미
class ContentViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var storeButton: UIButton!
    @IBOutlet weak var defineTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelButton.toCustomButton()
        storeButton.toCustomButton()
        backgroundView.toShadowView()
        
        defineTextView.delegate = self
        defineTextView.layer.borderWidth = 1
        defineTextView.layer.borderColor = UIColor.lightGray.cgColor
        defineTextView.backgroundColor = .white
        defineTextView.layer.cornerRadius = 10
        self.placeholderSetting()
        
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
