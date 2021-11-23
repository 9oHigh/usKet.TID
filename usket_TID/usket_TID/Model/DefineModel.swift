//
//  DefineModel.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/24.
//

import Foundation
import RealmSwift
import UIKit

class DefineList : Object{
    
    @Persisted var pinChecked : Bool
    
    @Persisted var title : String
    
    @Persisted var content : String
    
    @Persisted var date : Date
    
    @Persisted var pinImage : String
    
    @Persisted var classification : String
    
    @Persisted(primaryKey: true) var _id : ObjectId
    
    convenience init(title : String, content : String) {
        self.init()
        self.title = title
        self.content = content
        self.pinChecked = false
        self.classification = "메모"
        self.pinImage = "pin.fill"
    }
}
