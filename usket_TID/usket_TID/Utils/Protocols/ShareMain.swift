//
//  MainDataProtocol.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/28.
//

import Foundation
import RealmSwift

protocol shareToMain {
    //기본저장시
    func getDatas(word : String, firstComes: String, emotion : String, definition: String)
    //수정시
    func getDatas(word : String, firstComes: String, emotion : String, definition: String,id : ObjectId)
}
