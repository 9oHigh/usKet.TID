//
//  ContentViewController.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/21.
//

import UIKit
//정의와 의미
class ContentViewController: UIViewController {

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var storeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelButton.toCustomButton()
        storeButton.toCustomButton()
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
