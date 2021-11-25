//
//  BasicViewController.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/21.
//

import UIKit
//단어 + 연관 단어 + 감정
class BasicViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var wordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topView.toShadowView()
        bottomView.toShadowView()
        wordTextField.textAlignment = .center
        wordTextField.placeholder = "여기에 적어볼까요!"
        wordTextField.layer.borderColor = UIColor.lightGray.cgColor
        wordTextField.layer.borderWidth = 1
        wordTextField.layer.cornerRadius = 5
        wordTextField.borderStyle = .roundedRect
    }
}
