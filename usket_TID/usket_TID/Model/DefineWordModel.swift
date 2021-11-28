//
//  DefineModel.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/24.
//

import Foundation
import RealmSwift
import UIKit

class DefineWordModel : Object{
    
    @Persisted var word : String
    @Persisted var definition : String
    @Persisted var firstWord : String
    @Persisted var emotion : String
    @Persisted var date : Date
    

    @Persisted(primaryKey: true) var _id : ObjectId
    
    convenience init(word : String, definition : String,emotion : String,firstWord : String){
        self.init()
        self.word = word
        self.firstWord = firstWord
        self.definition = definition
        self.emotion = emotion
    }
}
