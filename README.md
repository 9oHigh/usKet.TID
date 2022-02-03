
<br></br>

# usKet_TID ( 티드 )

👉 **출시완료** : **[Today I Define](https://apps.apple.com/kr/app/%ED%8B%B0%EB%93%9C-%EB%82%98%EB%8A%94-%EC%9D%B4%EA%B1%B8-%EC%9D%B4%EB%A0%87%EA%B2%8C-%EB%B6%80%EB%A5%B4%EA%B8%B0%EB%A1%9C-%ED%96%88%EB%8B%A4/id1597847159)**

 👉 **Notion** : **[이터레이션 / 팀빌딩 및 일정 / 개발과정 🧑🏻‍💻](https://jasper-atom-7c6.notion.site/a815c7d1282143f1bdcca2bd7eda7c16)**
 
 <details>
<summary>아이디어 구상 및 계획</summary>
<div markdown="3">

### ✔️ 아이디어

- 세상을 바라보는 시각은 우리 모두가 다르기 때문에 단어를 보고 떠오르는 **의미, 이미지, 생각, 감정** 등 각양각색일 것이며 시간이 지남에 따라 변하기도 할 것이다.
- 자신만의 표현으로 단어를 정의해보고 단어에 대한 감정을 기록하고 가장 먼저 떠오르는 단어를 적어보면서 내가 바라보고 있는 세상은 어떤 세상인지, 또 단어에 대한 나의 정의나 의미가 어떻게 변화해 가는지 알아가보면 어떨까하는 생각에서 착안했다.

### ✔️ 기능

- 단어 - 사전에 저장한 단어들 중에서 랜덤하게 단어가 나온다. ( 기존의 정의된 단어는 배제 )
- 단어 선택 - 정해진 단어 혹은 다른 단어로 선택할 수 있다.
- 감정 + 처음 떠오르는 단어 + [정의 / 의미] + [이유 / 단어를 사용한 간단한 글] 순서로 입력하고 저장한다.
- 태그 - 각 단어에 자신이 생각하는 태그를 넣고 검색에 활용한다.
- 통계 - 타임라인(꾸준함), 감정의 분포, 태그 분포, 단어에 대한 정의, 감정의 변화 등을 보여 준다.
- (선택사항) 내가 바라보는 세상 - 인쇄물로 받을 수 있게 만들어보면 어떨까.
- (선택사항) 공유 - 다른 유저들의 정의를 함께 볼 수 있다.

### ✔️ 컬러 및 폰트 : 심플 is BEST 😂

- 흰색 : 백그라운드
- 검정색 : 글씨 및 버튼
- 폰트 : **카페24 고운밤** [ https://fonts.cafe24.com/ ]
- DarkMode 지원
### ✔️ 오픈소스 및 API

- Realm : 단어, 감정, 처음 떠오르는 단어, 정의 등을 저장한다.
- PNChart : 통계에 활용한다.
- 우리말샘API : 단어의 뜻을 가지고온다. ( 1일/ 50,000회, 그 이상은 불가능 하지만 Excel 파일로 가지고 올 수 있다. )

### ✔️**배포**
- iOS : 15.0 이상
- 유료 버전으로 배포해보고 싶다. 나에게는 50여명의 소비자가 확보되어 있다. ( By Jack )

### ✔️ UI & UX
<br></br>
<p align="center">
 
<img src="https://user-images.githubusercontent.com/53691249/142445742-40080331-31ec-4ead-8e04-88babdbe90bd.jpg" width="80%" height="80%" aligment = "center">
 
 </p>

- 메인, 통계, 설정 : TabBar
- 메인 : TableView
- 우측 상단 버튼 : 단어 추천, 선택 → Editor Page ( 사진과 다름 )
- 통계 : PNChart를 이용 Card 형태의 UI 
<br></br>
<br></br>
 
 </div>
</details>
### 정리를 해보자👀

###### 주요 기술 스택
`MVC` `Realm` `Alamofire`  `SwifyJson`

✔  **이런걸 배웠어요 🏃🏻‍♂️**

1️⃣  **AutoLayout :** 기기별로 레이아웃을 대응하는 것이 굉장히 어려웠습니다. 약 1주일 ~ 2주일 동안 **꾸준히 레이아웃을 조정**해보면서 비율을 기준으로 다시 시작했을 때 시각적인 측면, 개발 속도 측면에서 모두 좋은 결과물을 얻을 수 있었습니다. 

2️⃣  **Realm :** 유저가 저장한 단어를 기록하기 위해 Realm을 선택했습니다. 다만, 기존의 **스키마**에서 날짜 데이터를 저장할 시에 임시로 넣어뒀던 Date()값을 변환해야 했으며 새로운 Object로 변환 해야 했습니다. 결과적으로 Realm의 **스키마를 변경해야 된다는 것**을 알게 되었고 이를 적용해봤습니다.
<details>
<summary>코드</summary>
<div markdown="1">

```swift
//realm migration
let config = Realm.Configuration(
    schemaVersion: 2,
    migrationBlock: { migration,oldSchemaVersion in
        if (oldSchemaVersion < 2){
            migration.enumerateObjects(ofType: DefineWordModel.className()) { oldObject, newObject in
                //기존의 날짜들을 변환하고 storedDate에 값을 남긴다.
                let format = DateFormatter()
                format.dateFormat = "yyyy년 MM월 dd일"
                let value = format.string(from: oldObject?["date"] as! Date)

                newObject?["storedDate"] = value
            }
        }

    }
)
```
                                  
</div>
</details>

3️⃣  **Alamofire + SwiftyJson :** API 통신을 위해 Alamofire를, 받아온 Json 형태의 데이터를 사용하기 위해 SwiftyJson을 학습 및 응용하면서 프로젝트에 적용해 봤습니다.

4️⃣  **Network :** 추천단어기능을 만들기 위해 우리말사전API를 이용했습니다. 현재 유저의 네트워크 상태를 고려하지 않고 코드를 작성했고 출시 이후 발견되어 해당 ViewController에 진입시 Network 상태를 확인하는 함수를 만들어 사용해봤습니다.

<details>
<summary>코드</summary>
<div markdown="2">
 
```swift
//네트워크 상태 모니터
func monitorNetwork(){

    let monitor = NWPathMonitor()

    monitor.pathUpdateHandler = {
        path in
        if path.status == .satisfied {
            DispatchQueue.main.async {
                return
            }
        } else {
            DispatchQueue.main.async {

                self.showAlert(title: "네트워크에 연결되어 있지 않아요.\n설정화면으로 이동합니다 🥲",connection: true)
            }
        }
    }
    let queue = DispatchQueue(label: "Network")
    monitor.start(queue: queue)
}
```
 
</div>
</details>
    
5️⃣  **애플리케이션 출시 과정 :** 서비스를 배포하는 과정을 학습했으며 이를 이용해 업데이트시에도 적용하며 현재 두번의 업데이트를 진행했습니다.

✔  **이런 걸 배우고 싶어졌어요** 🔥

1️⃣  **AutoLayout :** 레이아웃에 관해 검색을 하다보면 SnapKit에 대한 답변들이 많이 보였어요. 검색을 통해 알아보니 코드를 이용하여 레이아웃을 잡을 수 있는 라이브러리인 것을 알게 되었습니다. 기존의 방법에 큰 문제가 있는 것은 아니였지만  간단한 뷰들 같은 경우에는 코드를 활용해 만든다면 개발시간 측면에서 높은 활용도가 있다고 생각이 들었고 다음번 프로젝트에는 이를 적극적으로 활용해 보고 싶어졌습니다.

2️⃣  **MVVM :** 기존의 MVC 디자인 패턴을 활용하여 개발을 했지만 ViewController에 UI + 기능을 모두 넣어야했기에 가독성이 떨어진다고 생각이 들었습니다. 가독성을 높이고 효율적인 관리를 위해 MVVM 디자인 패턴을 학습해야 겠다고 다짐했습니다.
