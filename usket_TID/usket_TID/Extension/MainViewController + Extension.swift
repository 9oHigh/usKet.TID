//
//  MainViewController + Extension.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/23.
//

import Foundation
import UIKit

extension MainViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell") as? MainTableViewCell else {
            return UITableViewCell()
        }
        
        cell.wordLabel.text = tasks[indexPath.row].word
        cell.contentLabel.text = tasks[indexPath.row].definition
        cell.emotionImageView.image = UIImage(named: tasks[indexPath.row].emotion)
        cell.backView.layer.addBorder([.right], color: UIColor.lightGray, width: 1.0)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 204
    }
}
extension MainViewController : passToMainData {
    func getDatas(word: String, firstComes: String, emotion: String,definition: String) {
        let newData = DefineWordModel(word: word, definition: definition, emotion: emotion, firstWord: firstComes)
        
        try! localRealm.write{
            localRealm.add(newData)
        }
        self.mainTableView.reloadData()
    }
}
