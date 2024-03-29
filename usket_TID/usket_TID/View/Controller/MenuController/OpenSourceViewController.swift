//
//  OpenSourceViewController.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/21.
//

import UIKit

final class OpenSourceViewController: UIViewController {
    
    @IBOutlet weak var licenseTableView: UITableView!
    let opensourceList : [String] = [
        "Alamofire",
        "SwiftyJson",
        "Realm",
        "hackiftekhar:IQKeyboardManager",
        "jonkykong:SideMenu",
        "kciter:Floaty",
        "alxrguz:ALProgressView",
        "WenchaoD:FSCalendar",
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
                showAlert(title: I18N.errorInform, message: I18N.errorCannotLoad)
            }
        } else {
            showAlert(title: I18N.errorInform, message: I18N.errorCannotLoad)
        }
        return ""
    }
}
extension OpenSourceViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
