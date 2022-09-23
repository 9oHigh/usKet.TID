//
//  ContentViewController.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/21.
//

import UIKit
import RealmSwift
import Firebase

final class ContentViewController: UIViewController,shareToContent{
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var storeButton: UIButton!
    @IBOutlet weak var defineTextView: UITextView!
    
    //메인뷰컨트롤러로 데이터 패스하기 위한 delegate
    var delegate : shareToMain?
    
    //넘어온 값들을 받는 저장 프로퍼티
    var word : String = ""
    var firstComes : String = ""
    var emotion : String = ""
    var defineText : String = ""
    
    //넘어온 값중에 cell id 값이 있다면 수정으로 분류
    var idOfCell : ObjectId?
    
    //중복검사시 필요
    let localRealm  = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cancelButton.toCustomButton()
        storeButton.toCustomButton()
        backgroundView.toShadowView()
        defineTextView.textContainerInset = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
        defineTextView.delegate = self
        defineTextView.layer.borderWidth = 1
        defineTextView.layer.borderColor = UIColor.lightGray.cgColor
        defineTextView.backgroundColor = .white
        defineTextView.layer.cornerRadius = 10
        
        if idOfCell != nil {
            defineTextView.text = defineText
        } else {
            self.placeholderSetting()
        }
        
    }
    @IBAction func cancelButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //저장버튼 클릭시 유효성 검사 + 메인에서 reloadData
    @IBAction func storeButtonClicked(_ sender: UIButton) {
        
        let event = "StoreButtonClicked"
        Analytics.setUserID("\(UserDefaults.standard.value(forKey: "MY_UUID") as? String ?? "Error_UUID")")
        Analytics.logEvent(event, parameters: nil)
        
        //유효성 검사시에 Nope이아닌 ADD/Modify가 넘어왔다면 실행
        if dataCorrectCheck() != "Nope" {
            let method : String = dataCorrectCheck()
            //추가해주는 delegate
            if method == "ADD"{
                delegate?.getDatas(word: word, firstComes: firstComes, emotion: emotion, definition: defineTextView.text)
                MainViewController.toastMessage = I18N.saved
                //수정해주는 delegate by ID
            } else {
                delegate?.getDatas(word: word, firstComes: firstComes, emotion: emotion, definition: defineTextView.text, id: idOfCell!)
                MainViewController.toastMessage = I18N.modified
            }
            //추천단어로 들어왔을 수도 있으니 루트뷰로 보내주기
            self.view.window?.rootViewController?.dismiss(animated: true)
        } else {
            return
        }
    }
    //감정 클릭시 받는 값들
    func getDatas(word: String, firstComes: String, emotion: String) {
        self.word = word
        self.firstComes = firstComes
        self.emotion = emotion
    }
    //메인으로 보낼 값들
    func getDatas(word: String, firstComes: String, emotion: String, definition: String) {
        self.word = word
        self.firstComes = firstComes
        self.emotion = emotion
        self.defineTextView.text = definition
    }
    //유효성 검사
    func dataCorrectCheck() -> String{
        //유효성 검사, 오류
        if word == "" || word == I18N.writeHere {
            self.showAlert(title: I18N.errorInputInform, message: I18N.errorNotInput)
            return "Nope"
        } else if firstComes == "" || firstComes == I18N.writeHere {
            self.showAlert(title: I18N.errorInputInform, message: I18N.errorEmotionInputAgain)
            return "Nope"
        } else if emotion == "" {
            self.showAlert(title: I18N.errorInputInform, message: I18N.errorEmotionInput)
            return "Nope"
        } else if defineTextView.text == "" || defineTextView.text == I18N.writeHere {
            self.showAlert(title: I18N.errorInputInform, message: I18N.errorNotInputDefinition)
            return "Nope"
        } else {
            let tasks = localRealm.objects(DefineWordModel.self)
            //수정여부 확인
            if idOfCell != nil {
                //중복검사 필요없음
                return "Modify"
            }else {
                //중복 수정.. contain은 포함관계라서 음절이 들어가도 중복이되어버렸음..
                let contain = tasks.filter("word == %@",word)
                
                if contain.isEmpty {
                    return "ADD"
                } else {
                    showAlert(title: I18N.errorDuplicatedInform, message: I18N.errorDuplicated)
                    return "Nope"
                }
            }
        }
    }
    
}
