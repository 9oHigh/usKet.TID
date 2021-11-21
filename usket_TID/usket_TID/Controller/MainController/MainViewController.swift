//
//  ViewController.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/19.
//

import UIKit
import SideMenu

class MainViewController: UIViewController {
    
    //First Login 구현을 위해 UserDefaults
    let userDefaults = UserDefaults.standard
    //Appdelegate로 할 수 있는 걸로 알고 있다. 찾아보자.
    static let originalFont : String = "Cafe24Oneprettynight"
    @IBOutlet weak var plusButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Left Button = 메뉴
        let config = UIImage.SymbolConfiguration(pointSize:35, weight: .thin, scale: .default)
        let images = UIImage(systemName: "line.3.horizontal", withConfiguration: config)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: images, style: .plain, target: self, action: #selector(openSideMenu))
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        //right Button = 당일에 해당하는 단어 설정
        //Normal + disabled 모두 설정해야한다. 클릭이벤트가 없으므로
        let btnTitle = UIBarButtonItem(title: "오늘의 단어", style: .plain, target: nil, action:nil)
        btnTitle.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: MainViewController.originalFont, size: 20.0)!,NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        btnTitle.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: MainViewController.originalFont, size: 20.0)!,NSAttributedString.Key.foregroundColor: UIColor.black], for: .disabled)
        btnTitle.isEnabled = false
        self.navigationItem.rightBarButtonItem = btnTitle
        
        //first LogIn
        firstLogInCheck()
    }
    //처음인지 아닌지 확인
    func firstLogInCheck(){
        //두번이상 실행
        if userDefaults.bool(forKey: "FirstLogIn") { return }
        //처음 실행
        userDefaults.set(true,forKey: "FirstLogIn")
        
        //처음이므로 튜토리얼 안내
        let storyboard = UIStoryboard(name: "Walkthrough", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FirstLoginViewController") as! FirstLoginViewController
        //overFullScreen이여야 라이프사이클 안겹친다.
        vc.modalPresentationStyle = .overFullScreen
        
        self.present(vc, animated: true, completion: nil)
    }
   //SideMenu OpenSource
    @objc func openSideMenu(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let sideMenuViewController : SideMenuNavigationViewController = storyboard.instantiateViewController(withIdentifier: "SideMenuNavigationViewController") as! SideMenuNavigationViewController

        let menu = CustomSideMenuNavigation(rootViewController: sideMenuViewController)

        present(menu,animated: true,completion: nil)
    }
    //Word Editor
    @IBAction func addButtonClicked(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "WordScreen", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "PageViewController") as! PageViewController
        
        vc.modalPresentationStyle = .overFullScreen
        
        self.present(vc, animated: true, completion: nil)
    }
}
