//
//  ViewController.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/19.
//

import UIKit
import SideMenu
import Realm

class MainViewController: UIViewController {
    
    //First Login 구현을 위해 UserDefaults
    let userDefaults = UserDefaults.standard
    //Appdelegate로 할 수 있는 걸로 알고 있다. 찾아보자.
    static let originalFont : String = "Cafe24Oneprettynight"
    
    //barbuttonItem에서 Storyboard에서 확인 - 중요..
    //코드로 barbuttonitem의 버튼에 접근 불가능
    @IBOutlet weak var rightBarButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Left Button = 메뉴
        let config = UIImage.SymbolConfiguration(pointSize:38, weight: .thin, scale: .default)
        let images = UIImage(systemName: "line.3.horizontal", withConfiguration: config)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: images, style: .plain, target: self, action: #selector(openSideMenu))
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        //right Button
        rightBarButton.toCustomButton()
        rightBarButton.titleLabel?.text = "오늘의 단어"
        
        //delegate + dataSource
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        //first LogIn
        firstLogInCheck()
        
        //스크롤시 상단으로 사라지기
        navigationController?.hidesBarsOnSwipe = true

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
    
    @IBAction func todayWordGenerate(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "WordScreen", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "WordViewController") as! WordViewController
        
        vc.modalPresentationStyle = .overFullScreen
        
        self.present(vc, animated: true, completion: nil)
    }
    
}
