//
//  MainTableViewCell.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/23.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var firstComesWord: UILabel!
    @IBOutlet weak var emotionImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = CGColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1)
        contentView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    //셀간 간격 주기
    override func layoutSubviews() {
        super.layoutSubviews()
        let margin : CGFloat = 5
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: margin, left: margin-2, bottom: margin, right: margin-2))
    }
}
