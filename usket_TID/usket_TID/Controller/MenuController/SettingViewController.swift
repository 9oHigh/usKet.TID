//
//  SettingViewController.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/21.
//

import UIKit
import UserNotifications

class SettingViewController: UIViewController {
    
    @IBOutlet weak var notiSwitch: UISwitch!
    @IBOutlet weak var notiTimePicker: UIDatePicker!
    let userNotiCenter  = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if MainViewController.switchToggle == "on"{
            notiSwitch.isOn = true
        } else {
            notiSwitch.isOn = false
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //실제로 설정이동후 알림을 켰는지 안켰는지 확인용
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { (settings) in
            if(settings.authorizationStatus == .authorized) {
                DispatchQueue.main.async {
                    self.notiSwitch.isOn = true
                }
                MainViewController.switchToggle = "on"
            }
            else {
                DispatchQueue.main.async {
                    self.notiSwitch.isOn = false
                }
                MainViewController.switchToggle = "off"
            }
        }
    }
    
    // 클로즈
    @IBAction func closeButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // 알림 여부 토글
    @IBAction func switchChanged(_ sender: UISwitch) {
        if sender.isOn {
            MainViewController.switchToggle = "on"
            showAlertWithCancel(title: "알림 설정 안내", message: "알림 설정 화면으로 이동하시겠습니까?") { action in
                guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            } noHandler: { action in
                self.notiSwitch.isOn = false
                MainViewController.switchToggle = "off"
            }
        } else {
            MainViewController.switchToggle = "off"
            showAlertWithCancel(title: "알림 설정 안내", message: "알림 설정 화면으로 이동하시겠습니까?") { action in
                guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            } noHandler: { action in
                self.notiSwitch.isOn = true
                MainViewController.switchToggle = "on"
            }
        }
    }
    // 새로운 업데이트 예정 알림
    @IBAction func commingSoonButtonClicked(_ sender: UIButton) {
        self.showAlert(title: "업데이트 안내", message: "다크모드와 폰트 준비중🤗")
    }
    
    @IBAction func pickTimeAdded(_ sender: UIDatePicker) {
        if MainViewController.switchToggle == "on"{
            self.sendNoti()
            showToast(message: "알림시간 저장완료😊")
        } else {
            showToast(message: "알림시간 저장실패😅")
        }
    }
    
    func sendNoti() {
        userNotiCenter.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "오늘도 티드와 함께 해요🏃🏻‍♂️"
        content.body = "오늘의 추천 단어는 [\(randomWords.wordList.randomWordGenerate())]입니다. \n작성하러 Go! Go!"
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: Calendar.current.dateComponents([.hour, .minute], from: notiTimePicker.date), repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        userNotiCenter.add(request) { (error) in
            
        }
    }
}
