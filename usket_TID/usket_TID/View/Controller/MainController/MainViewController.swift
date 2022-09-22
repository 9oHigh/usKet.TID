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
import Firebase

final class MainViewController: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!
    let userDefaults = UserDefaults.standard
    let userNotiCenter = UNUserNotificationCenter.current()
    static var toastMessage : String?
    
    // Realm
    let localRealm = try! Realm()
    var tasks : Results<DefineWordModel>!
    
    // Check User Searching Status
    var filtered : Results<DefineWordModel>!
    var isFiltering: Bool{
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        return isActive && isSearchBarHasText
    }
    
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
        
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Helper.shared.originalFont, size: 25)!,NSAttributedString.Key.foregroundColor : UIColor.black]
        
        //delegate + dataSource
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        // Sort Task
        tasks = localRealm.objects(DefineWordModel.self).sorted(byKeyPath: "date", ascending: false)
        
        firstLogInCheck() //first LogIn 확인
        addActionButton() //액션버튼 적용
        searchBarSetting() //서치바 적용
        requestNotificationAuthorization() //알림 요청
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        
        //상단에 짤리지 않게 Inset
        mainTableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        //변경사항 확인
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
        if userDefaults.bool(forKey: "FirstLogIn") { return }
        userDefaults.set(true,forKey: "FirstLogIn")

        let storyboard = UIStoryboard(name: "Walkthrough", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FirstLoginViewController") as! FirstLoginViewController

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
        
        let event = "CalendarButtonClicked"
        Analytics.setUserID("\(UserDefaults.standard.value(forKey: "MY_UUID") as? String ?? "Error_UUID")")
        Analytics.logEvent(event, parameters: nil)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
        
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true, completion: nil)
    }
    //Auth Loacl Push
    func requestNotificationAuthorization(){
        
        let authOptions : UNAuthorizationOptions = [.alert,.sound,.badge]
        
        userNotiCenter.requestAuthorization(options: authOptions) { success, error in
            //푸시 허용상태인지 저장
            UserDefaults.standard.set(success,forKey: "pushAllow")
        }
    }
    //Floating Button 추가하기
    // MARK: Need Refactor by Utils / ActionButton
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
        
        actionButton.addItem(title: I18N.write, image: UIImage(named: "writing.png")?.withRenderingMode(.alwaysTemplate)) { item in
            //에디터로 연결
            let storyboard = UIStoryboard(name: "WordScreen", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "PageViewController") as! PageViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
        
        actionButton.addItem(title: I18N.recomment, image: UIImage(named: "recommendation.png")?.withRenderingMode(.alwaysTemplate)) { item in
            //단어 추천 으로 연결
            let storyboard = UIStoryboard(name: "WordScreen", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "WordViewController") as! WordViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
        self.navigationController?.view.addSubview(actionButton)
        
        //여기서 overLayview의 backgroundColor를 블러 처리로 사용할 수 있으나 navigationBar에 적용이 안되는 이슈가 있음..
        actionButton.overlayView.backgroundColor =
            .black.withAlphaComponent(0.3)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.trailingAnchor.constraint(equalTo: (self.navigationController?.view.safeAreaLayoutGuide.trailingAnchor)!, constant: -30).isActive = true
        actionButton.bottomAnchor.constraint(equalTo: (self.navigationController?.view.safeAreaLayoutGuide.bottomAnchor)!, constant: -20).isActive = true
        actionButton.buttonColor = .white
        actionButton.buttonImageColor = .black
    }
    //MARK: Need Refactor by Utils / SearchBar
    func searchBarSetting(){
        //생성
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.enablesReturnKeyAutomatically = true
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = I18N.searchBar
        
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
        searchController.searchBar.setValue(I18N.cancel, forKey: "cancelButtonText")
        
        //폰트 + 컬러
        let attributes:[NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: Helper.shared.originalFont, size: 17)!
        ]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
    }
}
