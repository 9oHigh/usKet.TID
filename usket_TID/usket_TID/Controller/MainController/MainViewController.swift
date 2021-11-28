//
//  ViewController.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/19.
//

import UIKit
import SideMenu
import RealmSwift
import JJFloatingActionButton

class MainViewController: UIViewController {
    //First Login 구현을 위해 UserDefaults
    let userDefaults = UserDefaults.standard
    //Main TableView Contents
    let localRealm = try! Realm()
    var tasks : Results<DefineWordModel>!
    //Appdelegate로 할 수 있는 걸로 알고 있다. 찾아보자.
    static let originalFont : String = "Cafe24Oneprettynight"
    
    //barbuttonItem에서 Storyboard에서 확인 - 중요..
    //코드로 barbuttonitem의 버튼에 접근 불가능
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Left Button - sideMenu
        let config = UIImage.SymbolConfiguration(pointSize:35, weight: .light , scale: .default)
        let indexImage = UIImage(systemName: "line.3.horizontal", withConfiguration: config)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: indexImage, style: .plain, target: self, action: #selector(openSideMenu))
        navigationItem.leftBarButtonItem?.tintColor = .black

        //LargeTitle
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Today I define"
        
        //네비게이션바 스크롤시 default 값은 다크모드시 검정색이 된다.
        //타이틀에 폰트 주기
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: MainViewController.originalFont, size: 25)!,NSAttributedString.Key.foregroundColor : UIColor.black]
        
        //delegate + dataSource
        mainTableView.delegate = self
        mainTableView.dataSource = self
        //오토!!
        mainTableView.rowHeight = UITableView.automaticDimension
        //works 확인
        tasks = localRealm.objects(DefineWordModel.self)
        //first LogIn 확인
        firstLogInCheck()
        //액션버튼 적용
        addActionButton()
        //서치바 적용
        searchBarSetting()
        print("위치 :",localRealm.configuration.fileURL!)
    }
  
    //LargeTitle 혹은 Tableview와 관련해 바운스이후 네비게이션바로 돌아가는 이슈
    //viewWillAppear에서 Tableview 상단에 inset을 주면 해결되었다.
    // 확인 : TableView의 Align Top SafeArea값에 따라 top의 값을 조정
    // 큰 값일 수록 top의 값은 작아지고 반대로 작은 값일 수록 top의 값도 크게 줘야함
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainTableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        self.mainTableView.reloadData()
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
        //overFullScreen으로 백그라운드 alpha값 주기
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
    
    //Floating Button 추가하기
    func addActionButton(){
        let actionButton = JJFloatingActionButton()
        //버튼 클릭시 상단에 뜨는 버튼들의 사이즈 비율
        actionButton.itemSizeRatio = CGFloat(0.9)
        //각 버튼들의 config
        actionButton.configureDefaultItem { item in
            // .trailing은 버튼이 왼쪽에 있을 경우
            item.titlePosition = .leading
            //커스텀 폰트 적용
            item.titleLabel.font = UIFont(name: MainViewController.originalFont, size: 17)
            item.titleLabel.textColor = .black
            item.titleLabel.backgroundColor = .white
            
            //해당 버튼 패키지에서 set을 막아두어 설정할 수 없기에
            //constraint를 직접 만져야했음..
            let paddedWidth = item.titleLabel.intrinsicContentSize.width + 20
            let paddedheight = item.titleLabel.intrinsicContentSize.height + 20
            item.titleLabel.widthAnchor.constraint(equalToConstant: paddedWidth).isActive = true
            item.titleLabel.heightAnchor.constraint(equalToConstant: paddedheight).isActive = true
            
            //Label's attribute
            item.titleLabel.textAlignment = .center
            item.titleLabel.clipsToBounds = true // -> cornerRadius
            item.titleLabel.layer.borderColor = UIColor.black.cgColor
            item.titleLabel.layer.cornerRadius = 10
            
            item.buttonColor = .white
            item.buttonImageColor = .black
            
            item.layer.shadowColor = UIColor.black.cgColor
            item.layer.shadowOffset = CGSize(width: 0, height: 1)
            item.layer.shadowOpacity = Float(0.4)
            item.layer.shadowRadius = CGFloat(2)
        }
        
        actionButton.addItem(title: "작성하기", image: UIImage(named: "writing.png")?.withRenderingMode(.alwaysTemplate)) { item in
            
            //뷰컨트롤러 넣어주고
            var storyboard = UIStoryboard(name: "WordScreen", bundle: nil)
            let ContentVC = storyboard.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
            ContentVC.delegate = self
            
            //에디터로 연결
            storyboard = UIStoryboard(name: "WordScreen", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "PageViewController") as! PageViewController
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        }

        actionButton.addItem(title: "단어 추천 받기", image: UIImage(named: "recommendation.png")?.withRenderingMode(.alwaysTemplate)) { item in
            //단어 추천 으로 연결
            let storyboard = UIStoryboard(name: "WordScreen", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "WordViewController") as! WordViewController
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        }
        //전체 뷰위에 constrain 값주고 올리기
        view.addSubview(actionButton)
        
        //여기서 overLayview의 backgroundColor를 블러 처리로 사용할 수 있으나 navigationBar에 적용이 안되는 이슈가 있음..
        // clear로 하고 item 라벨들의 backgroundColor를 줘야함
        actionButton.overlayView.backgroundColor = .clear
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        actionButton.buttonColor = .white
        actionButton.buttonImageColor = .black

    }
    //수정이 필요함
    //navigationBar 바로 밑에 두어야 할 듯 하다
    //현재 테이블뷰 상단에 고정되어있음
    func searchBarSetting(){

        searchBar.placeholder = "단어, 감정, 연관단어를 검색해보세요."
        
        //서치 아이콘 제거 - 있으니까 어색함..
        searchBar.setImage(UIImage(), for: UISearchBar.Icon.search, state: .normal)
        searchBar.setImage(UIImage(named: "icCancel"), for: .clear, state: .normal)
        
        //상하의 라인을 없애고 텍스트 필드의 컬러값을 주기 위해서는 백그라운드 이미지를 넣어주는 방법이 있다.
        //searchBarStyle에서 minimal도 있으나 검색창 커스텀이 어려움..
        searchBar.setBackgroundImage(UIImage(), for: UIBarPosition.top, barMetrics: UIBarMetrics.default)
        searchBar.setBackgroundImage(UIImage(), for: UIBarPosition.bottom, barMetrics: UIBarMetrics.default)
        
        searchBar.searchTextField.backgroundColor = UIColor.white
        searchBar.searchTextField.textColor = .black
        searchBar.searchTextField.font = UIFont(name: MainViewController.originalFont, size: 18)
    }
}
