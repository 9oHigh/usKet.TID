//
//  SideMenuNavigationViewController.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/20.
//

import UIKit
//RootViewController
class SideMenuNavigationViewController: UIViewController {

    //Buttons...
    @IBOutlet weak var statisticsButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var openSourceButton: UIButton!
    @IBOutlet weak var contactButton: UIButton!
    @IBOutlet weak var supportLabel: UILabel!
    //관상용 인스타그램 마크
    @IBOutlet var instagramImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Button + Extension
        statisticsButton.toCustomButton()
        settingButton.toCustomButton()
        openSourceButton.toCustomButton()
        contactButton.toCustomButton()
        
        supportLabel.text = "Logo,\nEmotion\nBy   bo110_1"
        supportLabel.font = UIFont(name: MainViewController.originalFont, size: 18)
        
        let image = UIImage(named: "instaLogo.png")
        instagramImageView.image = image
        instagramImageView.contentMode = .scaleAspectFill
    }
    //통계
    @IBAction func statisticsButtonClicked(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "StatisticsViewController") as! StatisticsViewController
        
        vc.modalPresentationStyle = .fullScreen

        self.present(vc, animated: true, completion: nil)
    }
    //설정
    @IBAction func settingButtonClicked(_ sender: UIButton) {
        showAlert(title: "업데이트 예정 안내😊", message: "다크모드 / 폰트를 준비중입니다!")
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//        let vc = storyboard.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
//
//        vc.modalPresentationStyle = .fullScreen
//
//        self.present(vc,animated: true,completion: nil)
    }
    //오픈소스 라이선스
    @IBAction func openSourceButtonClicked(_ sender: UIButton) {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "OpenSourceViewController") as! OpenSourceViewController
        
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc,animated: true,completion: nil)
    }
    //문의하기
    @IBAction func contactButtonClicked(_ sender: UIButton) {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "ContactViewController") as! ContactViewController
        
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc,animated: true,completion: nil)
    }
    
    
}


