//
//  OpenSourceViewController.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/21.
//

import UIKit

class OpenSourceViewController: UIViewController {
    
    @IBOutlet weak var licenseTableView: UITableView!
    let opensourceList : [String] = [
        "Realm",
        "jonkykong:SideMenu",
        "SwiftyJson",
        "Alamofire",
        "kciter:Floaty",
        "hackiftekhar:IQKeyboardManager",
        "Font:Cafe24Oneprettynight"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        licenseTableView.delegate = self
        licenseTableView.dataSource = self
    }
    //클로즈
    @IBAction func closeButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    //파일 열어서 텍스트 뽑아오기 , txt
    func loadFile(file name : String) -> String {
        if let path = Bundle.main.path(forResource: name, ofType: "txt") {
            if let contents = try? String(contentsOfFile: path) {
                return contents
            } else {
           showAlert(title: "오류 안내", message: "죄송합니다. 현재 파일을 가지고 올 수 없습니다.")
            }
        } else {
            showAlert(title: "오류 안내", message: "죄송합니다. 현재 파일을 가지고 올 수 없습니다.")
        }
        return ""
    }
}
extension OpenSourceViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return opensourceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OpensourceTableViewCell") as? OpensourceTableViewCell else {
            return UITableViewCell()
        }
        
        cell.nameLabel.text = self.opensourceList[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LicenseViewController") as! LicenseViewController
        vc.content = self.loadFile(file: opensourceList[indexPath.row])
        self.present(vc, animated: true, completion: nil)
    }
    
}
