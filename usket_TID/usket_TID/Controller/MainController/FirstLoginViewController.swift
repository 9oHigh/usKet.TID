//
//  FirstLoginViewController.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/21.
//

import UIKit

class FirstLoginViewController: UIViewController {

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var letterView: UIView!
    @IBOutlet weak var sendLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        letterView.layer.borderWidth = 0.3
        letterView.layer.borderColor = UIColor.black.cgColor
        letterView.layer.cornerRadius = 20
        //Background Alpha 조정
        mainView.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        
        introLabel.font = UIFont(name: MainViewController.originalFont, size: 18.0)
        introLabel.text = "안녕하세요.\nToday I Define을 만든 개발자입니다.\n애플리케이션을 다운받아주셔서 정말 감사합니다."
        
        contentLabel.font = UIFont(name: MainViewController.originalFont, size: 18.0)
        contentLabel.text = "세상을 바라보는 정의와 의미는 모두가 다를 것이라고 생각합니다. 여러분들의 세상은 어떤지 오늘부터 하나씩 기록하시면서 자신을 돌아보는 시간을 갖길 바랍니다😄"
        
        sendLabel.font = UIFont(name: MainViewController.originalFont, size: 18.0)
        sendLabel.text = "개발자 드림"
    }
    //Start
    @IBAction func startButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
