//
//  WordViewController.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/22.
//

import UIKit
import Alamofire
import SwiftyJSON

class WordViewController: UIViewController {
    
    @IBOutlet weak var defineTableView: UITableView!
    @IBOutlet weak var todayWordLabel: UILabel!
    @IBOutlet weak var defineLabel: UILabel!
    
    var todayWord : String = "명예"
    var numbering : [String] = ["첫 번째, ","두 번째, ","세 번째, "]
    var definitions : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todayWordLabel.text = "오늘의 단어는 \(todayWord)입니다."
        defineLabel.text = "먼저, \(todayWord)의 정의를 볼까요?"
        
        fetchWordData()
        
        defineTableView.delegate = self
        defineTableView.dataSource = self
    }
   
    @IBAction func closeButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    //여기서 바로 에디터로 가야한다. 취소가 아님!
    @IBAction func wantButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func newWord(_ sender: UIButton) {
        todayWord = "부부"
        todayWordLabel.text = "오늘의 단어는 \(todayWord)입니다."
        defineLabel.text = "먼저, \(todayWord)의 정의를 볼까요?"
        //찾는 중 표시를 위해 reloadData + 배열 초기화
        definitions = []
        self.defineTableView.reloadData()
        //데이터 찾아오기
        fetchWordData()
    }
    
    func fetchWordData(){
        
        let urlString =
        "https://opendict.korean.go.kr/api/search?certkey_no=3231&key=&target_type=search&req_type=json&part=word&q=\(String(describing: todayWord))&sort=dict&start=1&num=10"
        let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedString)!
        
        //새로운 단어를 뽑을 시에 초기화
        self.definitions = []
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for number in 0...2 {
                    let definition = json["channel"]["item"][number]["sense"][0]["definition"].stringValue
                    self.definitions.append(definition)
                }
                self.defineTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
extension WordViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DefineTableViewCell") as? DefineTableViewCell else {
            return UITableViewCell()
        }
        if definitions.isEmpty {
            cell.defineLabel.text = "잠시만 기다려주세요!"
            cell.numberLabel.text = "찾는중.."
            return cell
        }else {
            cell.numberLabel.text = numbering[indexPath.row]
            cell.defineLabel.text = definitions[indexPath.row]
            return cell
        }
    }
}
