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
    var emotion : String?
    
    @IBOutlet weak var wordChoceView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var wordTextField: UITextField!
    @IBOutlet weak var choseWordTextField: UITextField!
    @IBOutlet weak var editLabel: UILabel!
    
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
        
        happyButton.setImage(UIImage(named: "happyFace.png"), for: .normal)
        sadButton.setImage(UIImage(named: "sadFace.png"), for: .normal)
        angryButton.setImage(UIImage(named: "angryFace.png"), for: .normal)
        sosoButton.setImage(UIImage(named: "normalFace.png"), for: .normal)
        
        //cell의 id값이 들어왔다면 수정
        if cellId != nil{
            choseWordTextField.text = wordText!
            wordTextField.text = firstText!
            if let emotion = emotion {
                switch emotion {
                case "happyFace.png":
                    happyButton.getOpacity(alpha: 1)
                    sadButton.getOpacity(alpha: 0.3)
                    angryButton.getOpacity(alpha: 0.3)
                    sosoButton.getOpacity(alpha: 0.3)
                    selectedButton = "happyFace.png"
                case "sadFace.png":
                    happyButton.getOpacity(alpha: 0.3)
                    sadButton.getOpacity(alpha: 1)
                    angryButton.getOpacity(alpha: 0.3)
                    sosoButton.getOpacity(alpha: 0.3)
                    selectedButton = "sadFace.png"
                case "angryFace.png":
                    happyButton.getOpacity(alpha: 0.3)
                    sadButton.getOpacity(alpha: 0.3)
                    angryButton.getOpacity(alpha: 1)
                    sosoButton.getOpacity(alpha: 0.3)
                    selectedButton = "angryFace.png"
                case "normalFace.png":
                    happyButton.getOpacity(alpha: 0.3)
                    sadButton.getOpacity(alpha: 0.3)
                    angryButton.getOpacity(alpha: 0.3)
                    sosoButton.getOpacity(alpha: 1)
                    selectedButton = "happyFace.png"
                default:
                    break
                }
                self.sendData()
            }
        } else {
            editLabel.isHidden = true
        }
        
        //워드 텍스트만 들어왔다면 단어추천
        if let wordText = wordText {
            choseWordTextField.text = wordText
        }
        
        //제스처를 이용해 나갈 수 있게 해보자.
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(BasicViewController.respondToSwipeGesture(_:)))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(swipeDown)
        
    }
    // 아래로 내리면 디스미스!
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.down :
                self.dismiss(animated: true, completion: nil)
            default:
                break
            }
        }
    }
    //버튼 이벤트
    @IBAction func happyButtonClicked(_ sender: UIButton) {
        happyButton.bounceAnimation()
        if correctCheck() != true {
            return
        }
        
        happyButton.getOpacity(alpha: 1)
        sadButton.getOpacity(alpha: 0.3)
        angryButton.getOpacity(alpha: 0.3)
        sosoButton.getOpacity(alpha: 0.3)
        selectedButton = "happyFace.png"
        sendData()
    }
    @IBAction func sadButtonClicked(_ sender: UIButton) {
        sadButton.bounceAnimation()
        if correctCheck() != true {
            return
        }
        
        sadButton.getOpacity(alpha: 1)
        happyButton.getOpacity(alpha: 0.3)
        angryButton.getOpacity(alpha: 0.3)
        sosoButton.getOpacity(alpha: 0.3)
        selectedButton = "sadFace.png"
        sendData()
    }
    @IBAction func angryButtonClicked(_ sender: UIButton) {
        angryButton.bounceAnimation()
        if correctCheck() != true {
            return
        }
        
        angryButton.getOpacity(alpha: 1)
        happyButton.getOpacity(alpha: 0.3)
        sadButton.getOpacity(alpha: 0.3)
        sosoButton.getOpacity(alpha: 0.3)
        selectedButton = "angryFace.png"
        sendData()
    }
    @IBAction func sosoButtonClicked(_ sender: UIButton) {
        sosoButton.bounceAnimation()
        if correctCheck() != true {
            return
        }
        
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
        if correctCheck() != true {
            return
        }
        //데이터 패스
        delegate?.getDatas(word: choseWordTextField.text!, firstComes: wordTextField.text!, emotion: selectedButton)
    }
    func correctCheck() -> Bool{
        if choseWordTextField.text == ""{
            showAlert(title: "단어 입력 오류", message: "단어를 입력하지 않았어요. 순서대로 모두 입력하고 다시 눌러주세요!")
            return false
        } else if wordTextField.text == ""{
            showAlert(title: "연관 단어 입력 오류", message: "연관 단어를 입력하지 않았어요. 순서대로 모두 입력하고 다시 눌러주세요!")
            return false
        } else {
            return true
        }
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
