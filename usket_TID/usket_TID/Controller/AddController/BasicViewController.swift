//
//  BasicViewController.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/21.
//

import UIKit
//단어 + 연관 단어 + 감정
class BasicViewController: UIViewController {

    @IBOutlet weak var wordChoceView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var wordTextField: UITextField!
    @IBOutlet weak var choseWordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //쉐도우 뷰
        topView.toShadowView()
        bottomView.toShadowView()
        wordChoceView.toShadowView()
        
        choseWordTextField.textAlignment = .center
        choseWordTextField.layer.borderColor = UIColor.lightGray.cgColor
        choseWordTextField.layer.borderWidth = 1
        choseWordTextField.layer.cornerRadius = 5
        choseWordTextField.borderStyle = .roundedRect
        choseWordTextField.attributedPlaceholder = NSAttributedString(string: "이 곳에 적어볼까요!", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        
        wordTextField.textAlignment = .center
        wordTextField.layer.borderColor = UIColor.lightGray.cgColor
        wordTextField.layer.borderWidth = 1
        wordTextField.layer.cornerRadius = 5
        wordTextField.borderStyle = .roundedRect
        wordTextField.attributedPlaceholder = NSAttributedString(string: "이 곳에 적어볼까요!", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
    }
}
