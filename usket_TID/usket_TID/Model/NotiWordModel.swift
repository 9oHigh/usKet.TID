//
//  NotiWordModel.swift
//  usket_TID
//
//  Created by 이경후 on 2022/03/13.
//

import RealmSwift
import UIKit

class NotiWordModel : Object {
    
    @Persisted var word : String
    @Persisted var date : Date
    
    convenience init(word: String, date: Date){
        self.init()
        self.word = word
        self.date = date
    }
}
