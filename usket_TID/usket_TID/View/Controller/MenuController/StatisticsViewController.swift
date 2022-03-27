//
//  StatisticsViewController.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/21.
//

import UIKit
import ALProgressView
import RealmSwift

final class StatisticsViewController: UIViewController {
    
    private lazy var progressRing = ALProgressRing()
    
    @IBOutlet weak var countView: UIView!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var emotionVIew: UIView!
    
    @IBOutlet weak var countWordLabel: UILabel!
    @IBOutlet weak var countMorphemeLabel: UILabel!
    
    @IBOutlet weak var happyCountLabel: UILabel!
    @IBOutlet weak var sadCountLabel: UILabel!
    @IBOutlet weak var normalCountLabel: UILabel!
    @IBOutlet weak var angryCountLabel: UILabel!
    
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    
    let localRealm = try! Realm()
    var tasks : Results<DefineWordModel>!
    var gauge : Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countView.toShadowView()
        progressView.toShadowView()
        emotionVIew.toShadowView()
        fetchDatas()
        //프로그레스링 추가
        progressView.addSubview(progressRing)
        
        progressRing.translatesAutoresizingMaskIntoConstraints = false
        //중앙에 위치
        progressRing.centerXAnchor.constraint(equalTo: progressView.centerXAnchor).isActive = true
        progressRing.centerYAnchor.constraint(equalTo: progressView.centerYAnchor).isActive = true
        
        //0.65배만큼만
        progressRing.widthAnchor.constraint(equalToConstant: progressView.frame.width * 0.7).isActive = true
        progressRing.heightAnchor.constraint(equalToConstant: progressView.frame.height * 0.7).isActive = true
        
        progressRing.startColor = UIColor(red: 255/255, green: 0, blue: 0, alpha: 0.5)
        progressRing.endColor = UIColor(red: 255/255, green: 0, blue: 0, alpha: 0.5)
        progressRing.lineWidth = 15
        
        //viewWillAppear에서 제공
        progressRing.setProgress(0.0, animated: true)
    }
    //클로즈
    @IBAction func closeButtonClicked(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //여기다가 실제 수치
        progressRing.setProgress(self.gauge * 0.01, animated: true)
    }
    
    func fetchDatas(){
        
        tasks = localRealm.objects(DefineWordModel.self)
        //마지막일
        //년
        let year = Date()
        let formatYear = DateFormatter()
        formatYear.dateFormat = "yyyy"
        let nowYear = formatYear.string(from: year)
        
        //월
        let month = Date()
        let formatMonth = DateFormatter()
        formatMonth.dateFormat = "M"
        let nowMonth = formatMonth.string(from: month)
        monthLabel.text = nowMonth + "월❗️"
        
        //한달 일수
        let totalDay = lastDay(ofMonth: Int(nowMonth)!, year: Int(nowYear)!)
        
        //존재할때만 계산
        if tasks.count > 0 {
            //감정 개수 반환
            var image = tasks.filter("emotion == %@","happyFace.png")
            self.happyCountLabel.text = String(image.count) + "개"
            
            image = tasks.filter("emotion == %@","sadFace.png")
            self.sadCountLabel.text = String(image.count) + "개"
            
            image = tasks.filter("emotion == %@","normalFace.png")
            self.normalCountLabel.text = String(image.count) + "개"
            
            image = tasks.filter("emotion == %@","angryFace.png")
            self.angryCountLabel.text = String(image.count) + "개"
            
            //단어 개수 및 글자 수 반환
            self.countWordLabel.text = String(tasks.count) + "개"
            var cnt : Int = 0
            for item in 0...tasks.count - 1{
                cnt += tasks[item].word.count
                cnt += tasks[item].firstWord.count
                cnt += tasks[item].definition.count
            }
            self.countMorphemeLabel.text = numberFormatter(number: cnt) + "개"
            
            //프로그레스 체크!
            //이번달에 등록한 날의 개수.. 중복제거가 어렵다..
            let countDay = tasks.filter("date <= %@",Date() as Date)
            let writeDay = countDay.filter("date >= %@",Date().getStart(of: .month, calendar: .current)!)
            
            //MARK: writeDay 개수가 카운트 되지 않는다.
            
            //writeDay에서 중복제거하면 day로 가능할 듯
            var dayArr : [String] = []
            var writeCount : Int = 0
            
            if writeDay.count == 0 {
                
                writeCount = 0
                
            } else {
                
                for item in 0...writeDay.count - 1 {
                    
                    if dayArr.contains(writeDay[item].storedDate){
                        continue
                    } else {
                        dayArr.append(writeDay[item].storedDate)
                    }
                    
                }
                writeCount = dayArr.count
            }
            
            
            //퍼센테이지 계산
            if writeCount == 0{
                
                self.progressLabel.text = "0일 / \(totalDay)일"
                self.percentLabel.text = "0% 달성중.."
                
            } else {
                
                let percent = Double(writeCount) / Double(totalDay) * 100
                self.gauge = Float(percent)
                self.progressLabel.text = "\(writeCount)일 / \(totalDay)일"
                if percent == 100 {
                    self.percentLabel.text = "\(Int(percent))% 달성🎉"
                } else {
                    self.percentLabel.text = "\(Int(percent))% 달성중!"
                }
            }
        } else {
            //한게없으뮤
            self.countWordLabel.text = "0개"
            self.countMorphemeLabel.text = "0개"
            self.percentLabel.text = "0% 달성중"
            self.progressLabel.text = "0일 /\(totalDay)일"
            self.happyCountLabel.text = "0개"
            self.sadCountLabel.text = "0개"
            self.normalCountLabel.text = "0개"
            self.angryCountLabel.text = "0개"
        }
        
    }
    //NumberFormmater : 세자리마다 컴마!
    func numberFormatter(number: Int) -> String {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(value: number))!
    }
    //마지막날을 가지고 오는 함수
    func lastDay(ofMonth m: Int, year y: Int) -> Int {
        
        let cal = Calendar.current
        var comps = DateComponents(calendar: cal, year: y, month: m)
        
        comps.setValue(m + 1, for: .month)
        comps.setValue(0, for: .day)
        
        let date = cal.date(from: comps)!
        
        return cal.component(.day, from: date)
    }
}

