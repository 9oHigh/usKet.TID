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
            
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
