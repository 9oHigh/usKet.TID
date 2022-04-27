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
import UserNotifications

final class MainViewController: UIViewController {
    
    //First Login 구현을 위해 UserDefaults
    let userDefaults = UserDefaults.standard
    //알람설정
    let userNotiCenter = UNUserNotificationCenter.current()
    //realm
    let localRealm = try! Realm()
    var tasks : Results<DefineWordModel>!
    // 저장 및 수정 확인
    static var toastMessage : String?
    //서치바에서 검색중인지 아닌지 확인하고 filtered로 사용하기
    //오류방지
    var filtered : Results<DefineWordModel>!
    var isFiltering: Bool{
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        return isActive && isSearchBarHasText
    }
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        //Left Button - sideMenu
        let config = UIImage.SymbolConfiguration(pointSize:35, weight: .light , scale: .default)
        let lineImage = UIImage(systemName: "line.3.horizontal", withConfiguration: config)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: lineImage, style: .plain, target: self, action: #selector(openSideMenu))
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        //Right Button - Calendar
        let calendarImage = UIImage(systemName: "calendar", withConfiguration: config)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: calendarImage, style: .plain, target: self, action: #selector(openCalendar))
        
        //네비게이션바 스크롤시 default 값은 다크모드시 검정색이 된다.
        navigationController?.navigationBar.barTintColor = .white
        //타이틀에 폰트 주기
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Helper.shared.originalFont, size: 25)!,NSAttributedString.Key.foregroundColor : UIColor.black]
        
        //delegate + dataSource
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        //tasks 확인 - 먼저입력한게 하단으로..
        tasks = localRealm.objects(DefineWordModel.self).sorted(byKeyPath: "date", ascending: false)
        
        firstLogInCheck() //first LogIn 확인
        addActionButton() //액션버튼 적용
        searchBarSetting() //서치바 적용
        requestNotificationAuthorization() //알림 요청
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        
        //상단에 짤리지 않게 인셋
        mainTableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        
        //리로드!
        tasks = localRealm.objects(DefineWordModel.self).sorted(byKeyPath: "date", ascending: false)
        self.mainTableView.reloadData()
        
        //저장한 값이 있거나 수정한 값이 있을 때!
        if MainViewController.toastMessage != nil {
            self.showToast(message: MainViewController.toastMessage!)
            MainViewController.toastMessage = nil
        }
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
    // SideMenu
    @objc func openSideMenu(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let sideMenuViewController : SideMenuNavigationViewController = storyboard.instantiateViewController(withIdentifier: "SideMenuNavigationViewController") as! SideMenuNavigationViewController
        
        let menu = CustomSideMenuNavigation(rootViewController: sideMenuViewController)
        
        self.present(menu,animated: true,completion: nil)
    }
    // Calendar
    @objc func openCalendar(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
        
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true, completion: nil)
    }
    //로컬 푸시 권한
    func requestNotificationAuthorization(){
        
        let authOptions : UNAuthorizationOptions = [.alert,.sound,.badge]
        
        userNotiCenter.requestAuthorization(options: authOptions) { success, error in
            //푸시 허용상태인지 저장
            UserDefaults.standard.set(success,forKey: "pushAllow")
        }
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
            // 커스텀 폰트 적용
            item.titleLabel.font = UIFont(name: Helper.shared.originalFont, size: 17)
            item.titleLabel.textColor = .black
            item.titleLabel.backgroundColor = .white
            
            // 해당 버튼 패키지에서 set을 막아두어 설정할 수 없기에
            // constraint를 직접 만져야했음..
            let paddedWidth = item.titleLabel.intrinsicContentSize.width + 20
            let paddedheight = item.titleLabel.intrinsicContentSize.height + 20
            item.titleLabel.widthAnchor.constraint(equalToConstant: paddedWidth).isActive = true
            item.titleLabel.heightAnchor.constraint(equalToConstant: paddedheight).isActive = true
            
            //Label attribute
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
            //에디터로 연결
            let storyboard = UIStoryboard(name: "WordScreen", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "PageViewController") as! PageViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
        
        actionButton.addItem(title: "단어 추천 받기", image: UIImage(named: "recommendation.png")?.withRenderingMode(.alwaysTemplate)) { item in
            //단어 추천 으로 연결
            let storyboard = UIStoryboard(name: "WordScreen", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "WordViewController") as! WordViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
        view.addSubview(actionButton)
        
        //여기서 overLayview의 backgroundColor를 블러 처리로 사용할 수 있으나 navigationBar에 적용이 안되는 이슈가 있음..
        actionButton.overlayView.backgroundColor =
            .black.withAlphaComponent(0.3)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        actionButton.buttonColor = .white
        actionButton.buttonImageColor = .black
        
        
    }
    //서치바
    func searchBarSetting(){
        
        //생성
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.enablesReturnKeyAutomatically = true
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "단어, 연관단어, 내용을 검색해보세요."
        
        //네비게이션
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        //서치바 속성
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.backgroundColor = .clear
        
        //텍스트 필드 속성
        searchController.searchBar.searchTextField.backgroundColor = .clear
        searchController.searchBar.searchTextField.borderStyle = .none
        searchController.searchBar.searchTextField.textColor = .black
        searchController.searchBar.searchTextField.font = UIFont(name: Helper.shared.originalFont, size: 18)
        searchController.searchBar.searchTextField.leftView?.tintColor = .lightGray
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
        
        //폰트 + 컬러
        let attributes:[NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: Helper.shared.originalFont, size: 17)!
        ]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
    }
}
