//
//  WordList.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/20.
//

import UIKit
import RealmSwift

final class randomWords {
    
    static let wordList = randomWords()
    let localRealm = try! Realm()
    //864개
    let words : [String] = ["가격","가난","가능성","가로등","가로수","가방","가사","가수","가위","가을","가장","가정","가족","가치","가치관","각오","간식","간판","간호사","갈증","감동","감사","감수성","감정","값","강","강아지","개미","개성","거실","거울","거짓","거짓말","걱정","건물","검정색","겁","게임","겨울","결과","결심","결혼","결혼식","경영","경쟁","경쟁력","경제","경제력","경찰","경치","경험","계단","계란","계절","계좌","계획","고급","고기","고등학교","고민","고생","고양이","고집","고통","고향","곡","골목","골목길","공간","공공","공기","공무원","공부","공원","공짜","공책","공포","공항","공휴일","과거","과일","과자","과정","과제","과학","관계","관광","관광지","관념","관리","관심","관심사","관점","관찰","괴로움","교복","교사","교수","교양","교육","교통","교훈","구두","구름","구멍","구분","구역","구입","구체적","국","국가","국기","국민","국사","국제화","국회의원","군대","군사","군인","궁극적","권리","귀","귀신","규정","규칙","균형","귤","그늘","그릇","그리움","그림","그림자","극복","극장","근본","근원","근육","글","글씨","글자","금","금메달","금요일","긍정적","기계","기념","기대","기도","기록","기본","기분","기쁨","기술","기억","기업","기운","기적","기준","기차","기초","기호","기회","긴장","긴장감","길","길거리","김밥","김치","까만색","깡패","깨달음","꼬마","여자친구","꽃","꾸중","꿀","꿈","끝","끼","나라","나무","나이","낙엽","낚시","날씨","날짜","남자","낭비","낮","내일","넥타이","노동","노란색","노래","노력","노인","노트","녹색","논리","놀이","놀이터","농담","농촌","뇌","눈","눈동자","눈물","눈빛","느낌","능동적","능력","다이어트","단골","단순","단점","단풍","달","달걀","담배","담임","답","대출","대통령","대학교","대학교수","대학생","대학원생","대화","댐","더위","데이트","도구","도덕","도로","도시","도시락","도움","도전","도착","독립","독서","독창적","돈","동그라미","동물","동생","두려움","드라마","등산","디자이너","디자인","땅","뜻","라이벌","레스토랑","로봇","마약","마음","마음가짐","마이크","마중","마지막","만남","만세","만족","만화","말","맛","매너","매력","맥주","먼지","멋","메모","메시지","면접","명예","명절","모기","모범","모양","목걸이","목소리","목숨","목요일","목욕","목적","목표","무덤","무료","무용","문자","문제","문화","물","미래","미술","미움","미인","민족","민주주의","믿음","바다","바람","바보","바이러스","바지","박수","밖","반대","반성","반지","발견","밤","밤하늘","밥","방","방학","방향","배달","배우","백색","백인","백화점","버스","벌","벌레","법","법칙","베개","벽","변명","변신","변화","별","별명","병","병원","보라색","보람","보상","보통","복","복습","볼펜","봄","봉사","부","부끄러움","부담","부동산","부모님","부부","부엌","부자","부족","부처","분노","분위기","분필","분홍색","불","불교","불만","불안","불편","불평","불행","브랜드","비","비극","비난","비누","비닐봉지","비밀","비행기","빌딩","빗줄기","빚","빛","빨간색","사계절","사과","사나이","사람","사랑","사망","사생활","사실","사업","사진","사춘기","사투리","사표","사회","사회생활","사회주의","산","산책","살","삶","상담","상상","상상력","상식","상처","새벽","새해","색","색깔","생각","생명","생일","생활용품","샤워","서랍","서민","서점","석유","선","선거","선물","선배","선생님","선진국","선택","선풍기","설거지","설날","성격","성공","성별","성인","성장","성적","세계","세상","세수","세월","소나기","소나무","소녀","소년","소망","소문","소비","소유","소주","소풍","속마음","쇼핑","수염","수요일","수표","수학","순수","술","술자리","술잔","술집","숫자","숲","스님","스승","스타일","스트레스","슬픔","승리","시간","시계","시골","시도","시작","시장","시험","식구","식욕","식용유","신","신념","신발","신세대","신용","신호등","실망","실수","실천","실패","심리","싸구려","싸움","쓰레기","아기","아르바이트","아버지","아빠","아쉬움","아이","아이스크림","아저씨","아주머니","아줌마","아침","아파트","아픔","악몽","안부","안정","앞길","앞날","애인","애정","액세서리","앨범","야채","약속","약점","양보","양심","어둠","어려움","어른","어머니","언니","얼굴","엄마","에너지","에어컨","엘리베이터","여가","여권","여동생","여름","여유","여행","역사","역할","연락","연말","연설","연습","연애","연예인","연인","연필","연휴","열정","영어","영웅","영혼","영화","옆구리","예금","예술","예습","예의","예절","오늘","오랜만","오빠","오전","오징어","오후","올림픽","옷","와인","외로움","외모","요리","욕","욕심","용기","용돈","용서","우리나라","우산","우유","우정","우주","운","운동","운명","운전","웃음","월급","월드컵","월세","월요일","위기","위로","유머","유학","유행","육군","은","음료수","음식","음악","의무","의미","의사","의심","의욕","의자","의지","이력서","이름","이별","이불","이성","이웃","이해","이혼","인간","인간관계","인간성","인류","인사","인생","인연","인터넷","인형","일","일기","일상","일요일","일주일","일회용품","입대","입술","자격증","자극","자동차","자랑","자부심","자살","자신감","자연","자유","자장면","자전거","자존심","자취","잠","잠옷","장난","장례식","장마","장미","장인","장점","재능","재미","재산","재수","재주","재활용","재활용품","저녁","저축","적극적","적성","전기","전세","전쟁","전철","전통","전화","전화번호","절","절망","절약","젊음","점수","정","정거장","정답","정류장","정보","정부","정신","정장","정치","정치인","제사","조금","조깅","조상","존재","졸업","종교","종이","죄","주름살","주말","주먹","주방","주식","주인공","죽음","중국집","중년","중독","중식","즐거움","지각","지갑","지구","지금","지름길","지식","지하철","지혜","직업","직장","직장인","진리","진심","집","집안일","짜증","짝","차별","창문","채소","책","책상","책임감","챔피언","천국","천둥","천재","철학","첫날","청년","청바지","청소","청춘","초록색","초밥","초여름","초저녁","초콜릿","촛불","총","최고","최선","최악","최후","추석","추억","축구","축제","축하","출국","출근","출발","출발점","출퇴근","춤","충고","취미","취업","취직","취향","친구","친절","친척","침대","칭찬","카드","카페","캠퍼스","커피","컨디션","컴퓨터","케첩","코미디","코트","콜라","콤플렉스","쾌감","크리스마스","키","키스","타락","탄생","탓","태양","태풍","택시","터널","터미널","털","토요일","통일","통장","퇴근","퇴직금","투자","투표","튀김","팀","파도","파란색","파리","팝송","패션","편의점","편지","평화","포장마차","치킨","플라스틱","피곤","피로","피부","피아노","피자","하늘","하루","하얀색","하품","학교","학생","한마디","한숨","할머니","할아버지","해답","해외여행","핸드폰","햇볕","햇빛","햇살","행복","행운","향","향기","현재","혼잣말","화요일","화장","화장실","화장품","환갑","환경","환경오염","회사","회색","효도","효자","후회","휴가","휴식","휴일","흙","흥미","흥분","희망","희생","흰색","힘","크리스마스"
    ]
    
    func randomWord() -> String {
        return self.words.randomElement()!
    }
    
    func randomWordGenerate(date: Date) -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyy년 MM월 dd일"
        let value = format.string(from: date)

        let tasks = localRealm.objects(NotiWordModel.self).filter("date == %@",value)
        return tasks[0].word
    }
    
    func shuffleWords(date: Date){
        
        let items = localRealm.objects(NotiWordModel.self)
        try! localRealm.write {
            localRealm.delete(items)
        }
        
        let randomList = self.words.shuffled()
        
        for item in 0...self.words.count - 1 {
            let newDate = Calendar.current.date(byAdding: .day, value: item, to: date)
            let format = DateFormatter()
            format.dateFormat = "yyyy년 MM월 dd일"
            let value = format.string(from: newDate!)
            
            let newData = NotiWordModel(word: randomList[item], date: value)
            try! localRealm.write {
                localRealm.add(newData)
            }
            print(newData)
        }
    }
}
