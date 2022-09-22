//
//  String + Extenstion.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/23.
//
import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    // 정규식으로 제거하기
    func matchString (_string : String) -> String {
        // 문자열 한글자씩 확인을 위해 배열에 담는다
        let strArr = Array(_string)
        
        // 정규식 : 한글, 영어, 숫자만 허용 (공백, 특수문자 제거)
        // let pattern = "^[ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9]$"
        // 정규식 : 한글, 영어, 숫자, 공백만 허용 (특수문자 제거)
        let pattern = "^[ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9\\s~,.]$"
        
        // 문자열 길이가 한개 이상인 경우만 패턴 검사 수행
        var resultString = ""
        if strArr.count > 0 {
            if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) {
                var index = 0
                // string 문자 하나 마다 개별 정규식 체크
                while index < strArr.count {
                    let checkString = regex.matches(in: String(strArr[index]), options: [], range: NSRange(location: 0, length: 1))
                    // 정규식 패턴 외의 문자가 포함된 경우
                    if checkString.count == 0 {
                        index += 1
                    }
                    // 정규식 포함 패턴의 문자
                    else {
                        // 리턴 문자열에 추가
                        resultString += String(strArr[index])
                        index += 1
                    }
                }
            }
            return resultString
        }
        else {
            // 원본 문자 다시 리턴
            return _string
        }
    }
}
