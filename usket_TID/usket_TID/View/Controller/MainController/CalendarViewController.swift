//
//  CalendarViewController.swift
//  usket_TID
//
//  Created by 이경후 on 2021/12/09.
//

import UIKit
import FSCalendar
import RealmSwift

final class CalendarViewController: UIViewController {
    
    @IBOutlet weak var calendarTableView: UITableView!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    
    //Scope Gesture
    fileprivate lazy var scopeGesture: UIPanGestureRecognizer = {
        [unowned self] in
        let panGesture = UIPanGestureRecognizer(target: self.calendar, action: #selector(self.calendar.handleScopeGesture(_:)))
        panGesture.delegate = self
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 2
        return panGesture
    }()
    
    let localRealm = try! Realm()
    var tasks : Results<DefineWordModel>!
    var pressedDate : String = Date().dateToValue(){
        didSet{
            calendarTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegate + datasource
        calendar.delegate = self
        calendar.dataSource = self
        calendarTableView.delegate = self
        calendarTableView.dataSource = self
        
        view.addGestureRecognizer(self.scopeGesture)
        calendarTableView.panGestureRecognizer.require(toFail: self.scopeGesture)
        self.calendar.scope = .month
        
        //tableView에서 사용할 tasks
        tasks = localRealm.objects(DefineWordModel.self).sorted(byKeyPath: "date", ascending: false)
        
        //Check Today isEmpty
        let today = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy년 MM월 dd일"
        let value = format.string(from: today)
        
        if tasks.filter("storedDate = %@",value).count > 0 {
            emptyLabel.isHidden = true
        } else {
            emptyLabel.isHidden = false
            emptyLabel.text = "텅 비었어요!\n하루에 하나씩 꾸준히 적어봐요 🤗"
        }
        
        //캘린더 컬러
        calendar.appearance.titleDefaultColor = .black
        calendar.appearance.titleWeekendColor = .black
        calendar.appearance.headerTitleColor = .black
        calendar.appearance.weekdayTextColor = .darkGray
        
        // 달력의 년월 글자 바꾸기
        calendar.appearance.headerDateFormat = "YYYY년 M월"
        
        //폰트
        let customFont = UIFont(name: Helper.shared.originalFont, size: 18)
        calendar.appearance.titleFont = customFont
        calendar.appearance.weekdayFont = customFont
        calendar.appearance.subtitleFont = customFont
        calendar.appearance.headerTitleFont = customFont
        
        //이벤트 컬러
        calendar.appearance.eventDefaultColor = UIColor.black
        calendar.appearance.selectionColor = UIColor.lightGray
        calendar.appearance.todayColor = UIColor.gray
        calendar.appearance.todaySelectionColor = UIColor.gray
        calendar.layer.addBorder([.top], color: .black, width: 0.25)
        
        // 한국기준
        calendar.locale = Locale(identifier: "ko_KR")
        
        // 년월에 흐릿하게 보이는 애들 없애기
        calendar.appearance.headerMinimumDissolvedAlpha = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        calendar.reloadData()
        calendarTableView.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        calendarTableView.reloadData()
    }
    
    @IBAction func closeClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let shouldBegin = self.calendarTableView.contentOffset.y <= -self.calendarTableView.contentInset.top
        if shouldBegin {
            let velocity = self.scopeGesture.velocity(in: self.view)
            switch self.calendar.scope {
            case .month:
                return velocity.y < 0
            case .week:
                return velocity.y > 0
            @unknown default:
                fatalError()
            }
        }
        return shouldBegin
    }
}

extension CalendarViewController : FSCalendarDelegate,FSCalendarDataSource,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate{
    //MARK: Calendar
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        let format = DateFormatter()
        format.dateFormat = "yyyy년 MM월 dd일"
        let value = format.string(from: date)
        
        if tasks.filter("storedDate = %@", value).count > 0 {
            return 1
        } else {
            return 0
        }
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let format = DateFormatter()
        format.dateFormat = "yyyy년 MM월 dd일"
        let value = format.string(from: date)
        
        //해당 날짜에 테이블 뷰를 새롭게 그리기 위한 감시자 프로퍼티
        pressedDate = value
        
        if tasks.filter("storedDate = %@", value).count > 0{
            calendarTableView.isHidden = false
            emptyLabel.isHidden = true
            
        } else {
            calendarTableView.isHidden = true
            emptyLabel.isHidden = false
            emptyLabel.text = "텅 비었어요!\n하루에 하나씩 꾸준히 적어봐요 🤗"
        }
    }
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendarHeightConstraint.constant = bounds.height
        self.view.layoutIfNeeded()
    }
    
    //MARK: Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let works : Results<DefineWordModel>!
        works = localRealm.objects(DefineWordModel.self).filter("storedDate == %@", pressedDate)
        
        if works.count > 0 {
            return works.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CalendarTableViewCell.identifier) as? CalendarTableViewCell else {
            return UITableViewCell()
        }
        
        let works : Results<DefineWordModel>!
        works = localRealm.objects(DefineWordModel.self).filter("storedDate == %@", pressedDate)
        
        if works.count > 0 {
            self.calendarTableView.isHidden = false
            cell.wordLabel.text = works[indexPath.row].word
            cell.firstComeLabel.text = "[" + works[indexPath.row].firstWord + "]"
            cell.emotionImageView.image = UIImage(named: works[indexPath.row].emotion)
            cell.definitionLabel.text = works[indexPath.row].definition
            return cell
        } else {
            self.calendarTableView.isHidden = true
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let works : Results<DefineWordModel>!
        works = localRealm.objects(DefineWordModel.self).filter("storedDate == %@", pressedDate)
        if works.count > 0 {
            let compliment : String = " 짝짝짝👏 정의한 단어 \(works.count)개가 있어요!"
            let attributedString = NSMutableAttributedString(string: compliment, attributes: [
                .font: UIFont(name: Helper.shared.originalFont, size: 20)!,
                .foregroundColor: UIColor.black
            ])
            return attributedString.string
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let works: Results<DefineWordModel>!
        works = localRealm.objects(DefineWordModel.self).filter("storedDate == %@", pressedDate)
        if works.isEmpty {
            return
        } else {
            let storyboard = UIStoryboard(name: "WordScreen", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "PageViewController") as! PageViewController
            
            vc.idOfCell = works[indexPath.row]._id
                        
            vc.modalPresentationStyle = .fullScreen
            
            self.present(vc, animated: true, completion: nil)
        }
    }
}
