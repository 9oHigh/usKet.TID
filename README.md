# Today I Define ( TID ) 🧐  

### ✨출시완료✨ 
  * [![29](https://user-images.githubusercontent.com/53691249/153768166-1c7d7c43-0405-441e-8381-32af0273b4c4.png)](https://apps.apple.com/kr/app/%ED%8B%B0%EB%93%9C-%EB%82%98%EB%8A%94-%EC%9D%B4%EA%B1%B8-%EC%9D%B4%EB%A0%87%EA%B2%8C-%EB%B6%80%EB%A5%B4%EA%B8%B0%EB%A1%9C-%ED%96%88%EB%8B%A4/id1597847159)
  * [개발 이터레이션 : 공수산정, 개발이슈 정리](https://jasper-atom-7c6.notion.site/9becfca153ff4e00a180a0e58228ef5c)
  * [업데이트 이터레이션 : 공수산정](https://jasper-atom-7c6.notion.site/be2d3b61f3af42f48d850b9efc69dc8c)


### 주요 기술 스택
`Realm` `AutoLayout` `Alamofire` `SwiftyJSON` `MVC`

###  ✔ 학습 및 적용 🏃🏻‍♂️

### 1. AutoLayout 
  * 약 1주일 ~ 2주일 동안 꾸준히 레이아웃을 조정해봤습니다. 상수값이 아닌 비율을 기준으로 조정하는 것이 시각적인 측면, 개발 속도 측면에서 더 효율이 좋았고 후반부 작업에서는 대부분 비율을 이용해 레이아웃을 만들었습니다.

  <details>
<summary>레이아웃 펼쳐보기</summary>
<div markdown="1">
 <br></br>
 
  ![스크린샷 2022-02-14 오전 4 07 40](https://user-images.githubusercontent.com/53691249/153770662-83d5642a-b010-4039-b0c6-65f754789b59.png)
 
</div>
</details>

### 2. Realm 
  * 유저가 저장한 단어를 기록하기 위해 Realm을 선택했습니다.
  * 개발이슈: 기존의 스키마에서 날짜 데이터를 저장할 시에 임시로 넣어뒀던 Date()값을 새로운 Object로 변환해야했습니다. Realm의 스키마를 변경해야 된다는 것 즉, **마이그레이션**을 할 수 있다는 것을 알았고 다음과 같이 적용함으로써 문제를 해결할 수 있었습니다.

     ```swift
     //Realm migration
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
     
### 3. Alamofire + SwiftyJson
  * API 통신을 위해 Alamofire를, 받아온 Json 형태의 데이터를 사용하기 위해 SwiftyJSON을 학습 및 적용하여 랜덤으로 나온 단어의 정의를 보여줄 수 있었습니다.

### 4. Network Status
  * 추천 단어 기능을 만들기 위해 [우리말샘API](https://opendict.korean.go.kr/service/openApiInfo)를 이용했습니다. 
  * 초기, 유저의 네트워크 상태를 고려하지 않고 코드를 작성했고 이를 발견하고 원하는 ViewController에 진입시 Network 상태를 확인할 수 있게 함수를 만들어 사용했습니다.

    ```swift
     import Network
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
    
### 5. 애플리케이션 출시 과정 
  * 서비스를 개발하고 배포하는 일련의 과정을 경험할 수 있었습니다.
  * 업데이트를 꾸준히 진행하고 있습니다. ( 가장 최근 업데이트 : 2022.3.14 ) 
  
  
### 6. 업데이트

  |버전|업데이트 내역|설명|
  |:---:|:---:|:---:|
  |v2.07|추가버튼 클릭시 Navigation Bar는 Overlay View에 감싸지지 않던 오류|해당 오류를 해결했습니다.|
  |v2.06|개발, 앱, 리뷰를 위한 버튼 생성|각각 깃허브 링크, 앱관련 문의를 위한 이메일 딥링크, 리뷰페이지로 이동가능한 버튼을 추가|
  |v2.05|로고 디자이너 인스타그램 링크|요청으로 링크를 첨부 및 추가 버튼 클릭시 백그라운드 컬러 |
  |v2.04|Firebase Crashlytics|Firebase Crashlytics 적용 및 기타 오류수정|
  |v2.03|Local Notification|로컬알림시 한 단어만 반복해서 오는 이슈를 수정했습니다.|
  |v2.02|레이아웃 버그 수정|단어의 뜻을 보여주는 TableView에서 발생한 오류를 해결했습니다.|
  |v2.01|통계 버그 수정|월이 바뀌게 될 경우 기존의 코드에서 nil 처리로 인한 오류가 존재, 이를 해결했습니다.|
  |v2.0|레이아웃 버그 수정, 저장시 토스트 알림 추가, 작성페이지 진입시 제스처로 나가기 추가, 수정시 감정과 정의 부분까지 보이게 추가, 통계수치 수정, 로컬 알림 제공, 캘린더 제공|출시 이후 받은 피드백 통해 캘린더와 알림을 중점으로 업데이트를 진행했습니다.|
  
  ---
  
  
###  ✔ 배워야할 & 배우고 싶은 기술 🏃🏻‍♂
  * SnapKit
    * 레이아웃에 관해 검색을 하다보면 SnapKit에 대한 답변들이 많이 보였습니다. 코드를 이용하여 레이아웃을 잡을 수 있는 라이브러리인 것을 알게 되었고 간단한 뷰들 같은 경우에는 코드를 활용해 만든다면 개발시간 측면에서 높은 활용도가 있다고 생각이 들었고 다음 프로젝트에는 이를 적극적으로 활용해 보고 싶어졌습니다.

  * MVVM
    * 기존의 MVC 디자인 패턴을 활용하여 개발을 했지만 ViewController에 UI + 기능을 모두 넣어야했기에 가독성이 떨어진다고 생각이 들었습니다. 가독성을 높이고 효율적인 관리를 위해 MVVM 디자인 패턴을 학습해야 겠다고 다짐했습니다.


<br></br>
