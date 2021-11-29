//
//  BasicViewController.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/21.
//

import UIKit
import RealmSwift

//단어 + 연관 단어 + 감정
class BasicViewController: UIViewController {
    
    //줄 놈이 선언되어 있어야지
    var delegate : shareToContent?
    //감정 기록시 앞의 연관단어를 입력하지 않았다면 Alert하기위해 감시자 프로퍼티로 설정
    var selectedButton : String = ""{
        didSet{
            sendData()
        }
    }
    //수정시 필요한 프로퍼티 -> ID로 수정해보자.
    var cellId : ObjectId?
    var wordText : String?
    var firstText : String?
    
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
        
        wordTextField.delegate = self
        choseWordTextField.delegate = self
        
        choseWordTextField.toCustomTF()
        wordTextField.toCustomTF()
        //cell의 id값이 들어왔다면 단어만 셋팅 -> 나머지는 수정..
        if cellId != nil{
            choseWordTextField.text = wordText!
            wordTextField.text = firstText!
        }
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
    @IBAction func sadButtonClicked(_ sender: UIButton) {
        
        sadButton.bounceAnimation()
        
        sadButton.getOpacity(alpha: 1)
        happyButton.getOpacity(alpha: 0.3)
        angryButton.getOpacity(alpha: 0.3)
        sosoButton.getOpacity(alpha: 0.3)
        selectedButton = "sadFace.png"
        sendData()
    }
    @IBAction func angryButtonClicked(_ sender: UIButton) {
        
        angryButton.bounceAnimation()
        
        angryButton.getOpacity(alpha: 1)
        happyButton.getOpacity(alpha: 0.3)
        sadButton.getOpacity(alpha: 0.3)
        sosoButton.getOpacity(alpha: 0.3)
        selectedButton = "angryFace.png"
        sendData()
    }
    @IBAction func sosoButtonClicked(_ sender: UIButton) {
        
        sosoButton.bounceAnimation()
        
        sosoButton.getOpacity(alpha: 1)
        angryButton.getOpacity(alpha: 0.3)
        happyButton.getOpacity(alpha: 0.3)
        sadButton.getOpacity(alpha: 0.3)
        selectedButton = "normalFace.png"
        sendData()
    }
    func sendData(){
        //이미지 클릭시 selectedButton값이 변경이 되므로 해당
        //오류를 Alert로 표시
        if choseWordTextField.text == ""{
            showAlert(title: "단어 입력 오류", message: "단어를 입력하지 않았어요. 순서대로 모두 입력해주세요!")
        } else if wordTextField.text == ""{
            showAlert(title: "연관 단어 입력 오류", message: "연관 단어를 입력하지 않았어요. 순서대로 모두 입력해주세요!")
        }
        //데이터 패스
        delegate?.getDatas(word: choseWordTextField.text!, firstComes: wordTextField.text!, emotion: selectedButton)
    }
}
extension BasicViewController : UITextFieldDelegate{
    //텍스트 5글자로 제한.. 아니면 너무 깨져보인다..
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
     
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
     
        return updatedText.count <= 6
    }
    
}
