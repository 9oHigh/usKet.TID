//
//  SettingViewController.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/21.
//

import UIKit
import UserNotifications
import RealmSwift

class SettingViewController: UIViewController {
    
    @IBOutlet weak var notiSwitch: UISwitch!
    @IBOutlet weak var notiTimePicker: UIDatePicker!
    
    let indicator = IndicatorView()
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
        view.addSubview(indicator)
        indicator.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        indicator.isHidden = true
        notiTimePicker.calendar.timeZone = .current
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
        self.dismiss(animated: true) {
            if UserDefaults.standard.bool(forKey: "pushAllow"){

                self.sendNoti()
                
                DispatchQueue.main.async {
                    self.showToast(message: "알림시간 저장완료😊")
                }
                //알림 시간 저장
                print("pick!",sender.date)
                UserDefaults.standard.set(sender.date.timeIntervalSince1970, forKey: "setAlarm")
            } else {
                DispatchQueue.main.async {
                    self.showToast(message: "알림시간 저장실패😅")
                }
            }
        }
    }
    
    func sendNoti() {
        
        userNotiCenter.removeAllPendingNotificationRequests()
        indicator.isHidden = false
        DispatchQueue.main.async {
            randomWords.wordList.shuffleWords(date: Date())
            self.registerContent {
                self.indicator.isHidden = true
            }
        }
    }
    
    func registerContent(onCompletion: @escaping () -> Void){
        
        let date : Date = Date()
        var pickDate = notiTimePicker.date
        
        for item in 0...randomWords.wordList.words.count - 1 {
            
            let newDate = Calendar.current.date(byAdding: .day, value: item, to: date)
            let word = randomWords.wordList.randomWordGenerate(date: newDate!)
            let content = UNMutableNotificationContent()
            
            
            content.title = "오늘도 티드와 함께 해요🏃🏻‍♂️"
            content.body = "오늘의 추천 단어는 [ \(word) ]입니다❗️\n\(word)에 대해 어떻게 생각하시나요? 작성하러 가요😊"
            content.sound = .default
            
            let trigger = UNCalendarNotificationTrigger(
                dateMatching: Calendar.current.dateComponents([.month,.day,.hour, .minute], from: pickDate), repeats: false)
            
            pickDate.addTimeInterval(86400)
            
            let request = UNNotificationRequest(identifier: content.body, content: content, trigger: trigger)
            print("-------------------")
            print(pickDate,trigger,content)
            self.userNotiCenter.add(request) { error in
                guard error != nil else {
                    return
                }
                DispatchQueue.main.async {
                    self.showToast(message: "다시 시도해주세요!")
                }
            }
        }
        onCompletion()
    }
}
