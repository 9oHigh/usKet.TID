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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell") as? MainTableViewCell else {
            return UITableViewCell()
        }
        
        cell.wordLabel.text = "행복"
//        cell.emotionImageView.image = UIImage(named: "logo.png")
        cell.contentLabel.text = "동해물과 백두산이 마르고 닳도록 동해물과 백두산이 마르고 닳도록 동해물과 백두산이 마르고 닳도록 동해물과 백두산이 마르고 닳도록 동해물과 백두산이 마르고 닳도록"
        cell.backView.layer.addBorder([.right], color: UIColor.lightGray, width: 1.0)
        
        return cell
    }
    //고민해봐야 할듯..
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UIScreen.main.bounds.height / 4
    }
    
}
