//
//  MainViewController + Extension.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/23.
//

import Foundation
import UIKit
import RealmSwift

extension MainViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering{
            return filtered.count
        } else {
            return tasks.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell") as? MainTableViewCell else {
            return UITableViewCell()
        }
        let works : Results<DefineWordModel>!
        if isFiltering{
            works = filtered
        } else {
            works = tasks
        }
        cell.wordLabel.text = works[indexPath.row].word
        cell.contentLabel.text = works[indexPath.row].definition
        cell.emotionImageView.image = UIImage(named: works[indexPath.row].emotion)
        
        var format = DateFormatter()
        format.timeZone = TimeZone(abbreviation: "KST")
        format.dateFormat = "dd"
        var value = format.string(from: works[indexPath.row].date)
        cell.dateLabel.text = value
        
        format = DateFormatter()
        format.dateFormat = "EEEE"
        value = format.string(from: works[indexPath.row].date)
        cell.dayLabel.text = value
        
        cell.backView.layer.addBorder([.right], color: UIColor.lightGray, width: 1.0)
        
        return cell
    }
    //선택시 -> 수정
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "WordScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PageViewController") as! PageViewController
        if isFiltering{
            vc.idOfCell = filtered[indexPath.row]._id
        } else {
            vc.idOfCell = tasks[indexPath.row]._id
        }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    //고정 높이로가자.. 레이아웃오류가 너무 많다.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 204
    }
}
extension MainViewController : shareToMain {
    //저장
    func getDatas(word: String, firstComes: String, emotion: String,definition: String) {
        let newData = DefineWordModel(word: word, definition: definition, emotion: emotion, firstWord: firstComes)
        
        try! localRealm.write{
            localRealm.add(newData)
        }
    }
    //수정
    func getDatas(word: String, firstComes: String, emotion: String, definition: String, id: ObjectId) {
        
        //어차피 하나니까 인덱스는 [0]
        let works = localRealm.objects(DefineWordModel.self)
        let data = works.filter("_id == %@",id)[0]
        
        try! localRealm.write{
            data.word = word
            data.definition = definition
            data.emotion = emotion
            data.firstWord = firstComes
            data.date = Date()
            localRealm.add(data,update: .modified)
        }
    }
}
extension MainViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        //모든 요소 검사
        //추후 업데이트시 텍스트에 백그라운드 혹은 애니메이션 줘보기!
        filtered = self.localRealm.objects(DefineWordModel.self).filter("word CONTAINS '\(text)' || definition CONTAINS '\(text)' || firstWord CONTAINS '\(text)' ")
        
        self.mainTableView.reloadData()
        
    }
}
