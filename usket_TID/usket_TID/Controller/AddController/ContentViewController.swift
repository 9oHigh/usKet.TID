//
//  ContentViewController.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/21.
//

import UIKit

class ContentViewController: UIViewController,passData{
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var storeButton: UIButton!
    @IBOutlet weak var defineTextView: UITextView!
    
    var delegate : passToMainData?
    var word : String = ""
    var firstComes : String = ""
    var emotion : String = ""
    
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
    @IBAction func cancelButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    //여기서 다시 메인으로 넘어가야한다. + reloadData
    @IBAction func storeButtonClicked(_ sender: UIButton) {
        //조건들이 필요..
        if dataCorrectCheck() {
            delegate?.getDatas(word: word, firstComes: firstComes, emotion: emotion, definition: defineTextView.text)
            self.dismiss(animated: true, completion: nil)
        } else {
            return
        }
    }
    
    func getDatas(word: String, firstComes: String, emotion: String) {
        self.word = word
        self.firstComes = firstComes
        self.emotion = emotion
    }
    
    func getDatas(word: String, firstComes: String, emotion: String, definition: String) {
        self.word = word
        self.firstComes = firstComes
        self.emotion = emotion
        self.defineTextView.text = definition
    }
    
    //유효성 검사
    func dataCorrectCheck() -> Bool{
        
        if word == "" {
            self.showAlert(title: "입력 오류 안내", message: "입력하신 내용으로는 저장이 어려워요. 모두 작성해주세요!")
            return false
        } else if firstComes == "" {
            self.showAlert(title: "입력 오류 안내", message: "입력하신 내용으로는 저장이 어려워요. 모두 작성해주세요!")
            return false
        } else if emotion == "" {
            self.showAlert(title: "입력 오류 안내", message: "입력하신 내용으로는 저장이 어려워요. 모두 작성해주세요!")
            return false
        } else if defineTextView.text == ""{
            self.showAlert(title: "입력 오류 안내", message: "정의/의미가 없습니다. 저장할 수 없어요🥲")
            return false
        } else {
            return true
        }
    }
    
}
