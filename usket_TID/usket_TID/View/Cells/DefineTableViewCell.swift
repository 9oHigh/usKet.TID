//
//  DefineTableViewCell.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/22.
//

import UIKit

class DefineTableViewCell: UITableViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var defineLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //백그라운드 그림자 효과
        self.contentView.layer.masksToBounds = false
        self.contentView.clipsToBounds = false
        
        self.contentView.layer.cornerRadius = 2
        self.contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.contentView.layer.shadowColor = UIColor.black.cgColor
        self.contentView.layer.shadowRadius = 1
        self.contentView.layer.shadowOpacity = 0.25
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //셀간 간격 주기
        let margin : CGFloat = 3
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: margin , left: margin, bottom: margin, right: margin))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
