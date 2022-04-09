//
//  WordViewController.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/22.
//

import UIKit
import Alamofire
import SwiftyJSON

final class WordViewController: UIViewController {
    
    @IBOutlet weak var newWordButton: UIButton!
    @IBOutlet weak var defineTableView: UITableView!
    @IBOutlet weak var todayWordLabel: UILabel!
    @IBOutlet weak var defineLabel: UILabel!
    var prevCount : Int = 0
    // 감시자 프로퍼티
    // 오늘의 단어가 버튼으로 지속적으로 바뀐다.
    var todayWord : String = "시작" {
        didSet{
            todayWordLabel.text = "추천 단어는 \(todayWord)입니다."
            defineLabel.text = "먼저, \(todayWord)의 정의를 볼까요?"
            //로딩중 화면을 위해 필요한 듯
            coloredText()
        }
    }
    var numbering : [String] = []
    var definitions : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todayWord = randomWords.wordList.randomWord()
        
        todayWordLabel.text = "추천 단어는 \(todayWord)입니다."
        defineLabel.text = "먼저, \(todayWord)의 정의를 볼까요?"
        
        defineTableView.delegate = self
        defineTableView.dataSource = self
        
        coloredText()
        monitorNetwork()
        fetchWordData()
    }
    @IBAction func closeButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func wantButtonClicked(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "WordScreen", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "PageViewController") as! PageViewController
        vc.recommendWord = todayWord
        vc.modalPresentationStyle = .overFullScreen
        
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func newWord(_ sender: UIButton) {
        todayWord = randomWords.wordList.randomWord()
        //로딩 중 표시를 위해 reloadData + 배열 초기화
        numbering = []
        definitions = []
        self.defineTableView.reloadData()
        //데이터 찾아오기
        fetchWordData()
        //여기서 버튼 클릭 이벤트가 발생하지 않게 조정 -> reload시에 값을 가지고 왔을 경우 다시 true
        newWordButton.isUserInteractionEnabled = false
    }
    // 가져온 word값만 컬러주기
    func coloredText(){
        
        let attributtedToday = NSMutableAttributedString(string: todayWordLabel.text!)
        attributtedToday.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.purple, range: (todayWordLabel.text! as NSString).range(of:"\(todayWord)"))
        attributtedToday.addAttribute(NSAttributedString.Key.font, value: UIFont(name: Helper.shared.originalFont, size: 26)!, range: (todayWordLabel.text! as NSString).range(of:"\(todayWord)"))
        todayWordLabel.attributedText = attributtedToday
        
        let attributtedDefine = NSMutableAttributedString(string: defineLabel.text!)
        attributtedDefine.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.purple, range: (defineLabel.text! as NSString).range(of:"\(todayWord)"))
        attributtedDefine.addAttribute(NSAttributedString.Key.font, value: UIFont(name: Helper.shared.originalFont, size: 26)!, range: (defineLabel.text! as NSString).range(of:"\(todayWord)"))
        defineLabel.attributedText = attributtedDefine
    }
}
extension WordViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if numbering.count == 0 {
            if section == 0 { return 1 }
        }
        return numbering.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DefineTableViewCell") as? DefineTableViewCell else {
            return UITableViewCell()
        }
        //가지고온 값이 없다면
        if definitions.isEmpty {
            newWordButton.isUserInteractionEnabled = false
            cell.defineLabel.text = "로딩중..."
            cell.numberLabel.text = ""
            return cell
        }else {
            //결과를 보여주게 되면 버튼 클릭이 가능하게
            newWordButton.isUserInteractionEnabled = true
            cell.numberLabel.text = numbering[indexPath.row]
            cell.defineLabel.lineBreakStrategy = .hangulWordPriority
            cell.defineLabel.text = definitions[indexPath.row]
            return cell
        }
    }
}
