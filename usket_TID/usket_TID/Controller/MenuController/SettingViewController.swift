//
//  SettingViewController.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/21.
//

import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    //캔슬
    @IBAction func closeButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
