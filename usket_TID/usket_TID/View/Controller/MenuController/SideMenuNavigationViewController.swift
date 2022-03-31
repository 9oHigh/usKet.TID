//
//  SideMenuNavigationViewController.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/20.
//

import UIKit

final class SideMenuNavigationViewController: UIViewController {
    
    //Buttons...
    @IBOutlet weak var statisticsButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var openSourceButton: UIButton!
    @IBOutlet weak var contactButton: UIButton!
    @IBOutlet weak var supportLabel: UILabel!
    //관상용 인스타그램 마크
    @IBOutlet var instagramImageView: UIImageView!
    
    private lazy var imageGesture = UITapGestureRecognizer(target: self, action: #selector(toInstagram(_:)))
    
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
        //Gesture
        instagramImageView.addGestureRecognizer(imageGesture)
        instagramImageView.isUserInteractionEnabled = true
    }
    
    // 통계
    @IBAction func statisticsButtonClicked(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "StatisticsViewController") as! StatisticsViewController
        
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true, completion: nil)
    }
    // 설정
    @IBAction func settingButtonClicked(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
        
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc,animated: true,completion: nil)
    }
    // 오픈소스 라이선스
    @IBAction func openSourceButtonClicked(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "OpenSourceViewController") as! OpenSourceViewController
        
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc,animated: true,completion: nil)
    }
    // 문의하기
    @IBAction func contactButtonClicked(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "ContactViewController") as! ContactViewController
        
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc,animated: true,completion: nil)
    }
    
    // 인스타그램
    @objc
    private func toInstagram(_ sender: UITapGestureRecognizer){
        
        guard let instaUrl = URL(string:"https://www.instagram.com/bo110_1/?utm_medium=copy_link") else {
            return
        }
        UIApplication.shared.open(instaUrl, options: [:], completionHandler: nil)
    }
}


