//
//  BasicViewController.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/21.
//

import UIKit
//단어 + 연관 단어 + 감정
class BasicViewController: UIViewController {
    
    //줄 놈이 선언되어 있어야지
    var delegate : passData?
    var selectedButton : String = ""
    
    @IBOutlet weak var wordChoceView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var wordTextField: UITextField!
    @IBOutlet weak var choseWordTextField: UITextField!
    
    //buttons..
    @IBOutlet weak var happyButton: UIButton!
    @IBOutlet weak var sadButton: UIButton!
    @IBOutlet weak var angryButton: UIButton!
    @IBOutlet weak var sosoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //쉐도우 뷰
        topView.toShadowView()
        bottomView.toShadowView()
        wordChoceView.toShadowView()
        
        choseWordTextField.toCustomTF()
        wordTextField.toCustomTF()
        
        happyButton.setImage(UIImage(named: "happyFace.png"), for: .normal)
        sadButton.setImage(UIImage(named: "sadFace.png"), for: .normal)
        angryButton.setImage(UIImage(named: "angryFace.png"), for: .normal)
        sosoButton.setImage(UIImage(named: "normalFace.png"), for: .normal)
    }
    
    //버튼 이벤트
    @IBAction func happyButtonClicked(_ sender: UIButton) {
        
        happyButton.bounceAnimation()
        
        happyButton.getOpacity(alpha: 1)
        sadButton.getOpacity(alpha: 0.3)
        angryButton.getOpacity(alpha: 0.3)
        sosoButton.getOpacity(alpha: 0.3)
        selectedButton = "happyFace.png"
        sendData()
    }
    @IBAction func sadButtonClicked(_ sender: Any) {
        
        sadButton.bounceAnimation()
        
        sadButton.getOpacity(alpha: 1)
        happyButton.getOpacity(alpha: 0.3)
        angryButton.getOpacity(alpha: 0.3)
        sosoButton.getOpacity(alpha: 0.3)
        selectedButton = "sadFace.png"
        sendData()
    }
    @IBAction func angryButtonClicked(_ sender: Any) {
        
        angryButton.bounceAnimation()
        
        angryButton.getOpacity(alpha: 1)
        happyButton.getOpacity(alpha: 0.3)
        sadButton.getOpacity(alpha: 0.3)
        sosoButton.getOpacity(alpha: 0.3)
        selectedButton = "angryFace.png"
        sendData()
    }
    @IBAction func sosoButtonClicked(_ sender: Any) {
        
        sosoButton.bounceAnimation()
        
        sosoButton.getOpacity(alpha: 1)
        angryButton.getOpacity(alpha: 0.3)
        happyButton.getOpacity(alpha: 0.3)
        sadButton.getOpacity(alpha: 0.3)
        selectedButton = "normalFace.png"
        sendData()
    }
    func sendData(){
        delegate?.getDatas(word: choseWordTextField.text!, firstComes: wordTextField.text!, emotion: selectedButton)
    }
}


