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
        //알림을 허용했다면
        if UserDefaults.standard.bool(forKey: "pushAllow"){
            notiSwitch.isOn = true
        //알림을 허용하지 않았다면
        } else {
            notiSwitch.isOn = false
        }
        //지정한 알림 시간이 있다면
        if UserDefaults.standard.double(forKey: "setAlarm") > 0 {
            let date = Date(timeIntervalSince1970: UserDefaults.standard.double(forKey: "setAlarm"))
            notiTimePicker.date = date
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //실제로 설정이동후 알림을 켰는지 안켰는지 확인용 - 확인이 안된다.
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { (settings) in
            if(settings.authorizationStatus == .authorized) {
                DispatchQueue.main.async {
                    self.notiSwitch.isOn = true
                }
                UserDefaults.standard.set(true,forKey: "pushAllow")
            }
            else {
                DispatchQueue.main.async {
                    self.notiSwitch.isOn = false
                }
                UserDefaults.standard.set(false,forKey: "pushAllow")
            }
        }
    }
    
    // 클로즈
    @IBAction func closeButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // 알림 여부 토글
    @IBAction func switchChanged(_ sender: UISwitch) {
        //알림을 켰을 경우 - 설정으로 이동하여 키기
        if sender.isOn {
            UserDefaults.standard.set(true,forKey: "pushAllow")
            showAlertWithCancel(title: "알림 설정 안내", message: "알림 설정 화면으로 이동하시겠습니까?") { action in
                guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            } noHandler: { action in
                self.notiSwitch.isOn = false
                UserDefaults.standard.set(false,forKey: "pushAllow")
            }
        //알림을 끌 경우 - 설정으로 이동하여 꺼기
        } else {
            UserDefaults.standard.set(false,forKey: "pushAllow")
            showAlertWithCancel(title: "알림 설정 안내", message: "알림 설정 화면으로 이동하시겠습니까?") { action in
                guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            } noHandler: { action in
                self.notiSwitch.isOn = true
                UserDefaults.standard.set(true,forKey: "pushAllow")
            }
        }
    }
    // 새로운 업데이트 예정 알림
    @IBAction func commingSoonButtonClicked(_ sender: UIButton) {
        self.showAlert(title: "업데이트 안내", message: "다크모드와 폰트 준비중🤗")
    }
    
    @IBAction func pickTimeAdded(_ sender: UIDatePicker) {
        if UserDefaults.standard.bool(forKey: "pushAllow"){
            self.sendNoti()
            showToast(message: "알림시간 저장완료😊")
            //알림 시간 저장
            UserDefaults.standard.set(sender.date.timeIntervalSince1970, forKey: "setAlarm")
        } else {
            showToast(message: "알림시간 저장실패😅")
        }
    }
    
    func sendNoti() {
        userNotiCenter.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        
        content.title = "오늘도 티드와 함께 해요🏃🏻‍♂️"
        content.body = "오늘의 추천 단어는 [ \(randomWords.wordList.randomWordGenerate()) ]입니다❗️\n\(randomWords.wordList.randomWordGenerate())에 대해 어떻게 생각하시나요? 작성하러 가요😊"
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: Calendar.current.dateComponents([.hour, .minute], from: notiTimePicker.date), repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        userNotiCenter.add(request) { (error) in
            
        }
    }
}
