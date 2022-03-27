//
//  CalendarTableViewCell.swift
//  usket_TID
//
//  Created by 이경후 on 2021/12/10.
//

import UIKit

final class CalendarTableViewCell: UITableViewCell {

    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var firstComeLabel: UILabel!
    @IBOutlet weak var emotionImageView: UIImageView!
    @IBOutlet weak var definitionLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //백그라운드 그림자 효과
        self.backView.layer.cornerRadius = 10
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = false
        self.contentView.clipsToBounds = false
        self.contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.contentView.layer.shadowColor = UIColor.black.cgColor
        self.contentView.layer.shadowRadius = 3
        self.contentView.layer.shadowOpacity = 0.25
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
