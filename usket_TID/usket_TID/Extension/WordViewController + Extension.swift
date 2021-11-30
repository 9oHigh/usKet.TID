//
//  UIViewController + Extension.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/23.
//

import Foundation
import Alamofire
import SwiftyJSON
import Network
import UIKit

extension WordViewController {
    //표준국어대사전 API를 이용해 단어의 정의 3개 가지고 오기
    func fetchWordData(){
        //표준국어대사전 API
        let urlString = "https://stdict.korean.go.kr/api/search.do?certkey_no=3233&key=9973B24A6DA7D5D70D5DD231CC8CE1CA&type_search=search&req_type=json&q=\(String(describing: todayWord))"
        //혹시 모를 오류를 대비해 인코딩 처리
        let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedString)!
        
        // 오류 처리 필요없음, 데이터만 연결되어 있고 API 자체가 문제 없다면 OK
        // 데이터(통신) 처리 했음.
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for number in 0...1 {
                    var word = json["channel"]["item"][number]["word"].stringValue
                    var definition = json["channel"]["item"][number]["sense"]["definition"].stringValue
                    word = word.matchString(_string: word)
                    definition = definition.matchString(_string: definition)
                    //단어가 없어도 ""값을 넣는듯 -> 셀에서 계속나옴
                    //맞았네 나이스
                    if word.isEmpty{
                        continue
                    } else {
                        self.numbering.append(word)
                        self.definitions.append(definition)
                    }
                }
                self.defineTableView.reloadData()
            case .failure(let error):
                self.showAlert(title: "네트워크에서 응답이 없어요.\n잠시후 다시 시도해 주세요 🥲", connection: false)
                print(error)
            }
        }
    }
    func monitorNetwork(){
        
        let monitor = NWPathMonitor()
        
        monitor.pathUpdateHandler = {
            path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    return
                }
            } else {
                DispatchQueue.main.async {
                    print("연결되어 있지 않음")
                    self.showAlert(title: "네트워크에 연결되어 있지 않아요.\n설정화면으로 이동합니다 🥲",connection: true)
                }
            }
        }
        let queue = DispatchQueue(label: "Network")
        monitor.start(queue: queue)
    }
    func showAlert(title : String, connection : Bool){
        
        let alert = UIAlertController(title: "네트워크 오류 안내", message: title, preferredStyle: .alert)
        let ok = UIAlertAction(title: "화인", style: .default) { action in
            if connection{
                guard let url = URL(string:UIApplication.openSettingsURLString) else { return }
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            }
        }
        
        alert.addAction(ok)
        present(alert, animated: true,completion: nil)
    }
}
