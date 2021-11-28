//
//  MainTableViewCell.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/23.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var emotionImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var contentLabelView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //백그라운드 그림자 효과 
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
    override func layoutSubviews() {
        super.layoutSubviews()
        //셀간 간격 주기
        let margin : CGFloat = 5
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: margin + 5, left: margin + 5, bottom: margin, right: margin + 5))
        
    }
}
