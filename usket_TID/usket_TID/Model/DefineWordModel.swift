//
//  DefineModel.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/24.
//

import UIKit
import RealmSwift

class DefineWordModel : Object {
    
    @Persisted var word : String
    @Persisted var definition : String
    @Persisted var firstWord : String
    @Persisted var emotion : String
    @Persisted var date : Date
    @Persisted var storedDate : String
    
    @Persisted(primaryKey: true) var _id : ObjectId
    
    convenience init(word : String, definition : String,emotion : String,firstWord : String){
        self.init()
        self.word = word
        self.firstWord = firstWord
        self.definition = definition
        self.emotion = emotion
        
        let format = DateFormatter()
        format.dateFormat = "yyyy년 MM월 dd일"
        let value = format.string(from: self.date)
        self.storedDate = value
    }
}
