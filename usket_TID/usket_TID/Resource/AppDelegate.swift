//
//  AppDelegate.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/19.
//

import UIKit
import Realm
import RealmSwift
import IQKeyboardManagerSwift
import UserNotifications
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //IQKeyboardManager
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.toolbarTintColor = .lightGray
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "완료"
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        
        //Realm migration
        let config = Realm.Configuration(
            schemaVersion: 2,
            migrationBlock: { migration,oldSchemaVersion in
                if (oldSchemaVersion < 2){
                    migration.enumerateObjects(ofType: DefineWordModel.className()) { oldObject, newObject in
                        //기존의 날짜들을 변환하고 storedDate에 값을 남긴다.
                        let format = DateFormatter()
                        format.dateFormat = "yyyy년 MM월 dd일"
                        let value = format.string(from: oldObject?["date"] as! Date)
                        
                        newObject?["storedDate"] = value
                    }
                }
            }
        )
        Realm.Configuration.defaultConfiguration = config
        UNUserNotificationCenter.current().delegate = self
        
        //User Id setting
        if let uuid = UserDefaults.standard.value(forKey: "MY_UUID") as? String, !uuid.isEmpty {
            
        } else {
            let uuid = UUID().uuidString
            UserDefaults.standard.set(uuid, forKey: "MY_UUID")
        }
        
        //Analytics
        FirebaseApp.configure()
        let event = "AppOpened"
        Analytics.setUserID("\(UserDefaults.standard.value(forKey: "MY_UUID") as? String ?? "Error_UUID")")
        Analytics.logEvent(event, parameters: nil)
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    //세로방향만 반환하기
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        //세로방향 고정
        return UIInterfaceOrientationMask.portrait
    }
    
}
extension AppDelegate: UNUserNotificationCenterDelegate {
    //알림이 뷰컨에서 안뜰 수도 있으니 Appdelegate에서도 설정해두기
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .badge, .sound,.list ])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}
