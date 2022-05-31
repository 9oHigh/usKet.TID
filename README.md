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
  
### 6. CI / CD 학습 및 적용
  <details>
 <summary> 학습 내용 정리 </summary>
 <div markdown="1">
  
  - CI / CD Github Action
    - Github Action이란
        - Pull Request, Push 등의 이벤트 발생에 따라 자동화된 작업을 진행할 수 있게 해주는 기능
        - CI / CD
            - 로컬 레포지토리에서 원격 레포지토리로 푸쉬하고 난 후, Github Actions에서는 이벤트 발생에 따라 자동으로 빌드 및 배포하는 스크립트를 실행시켜주는 것
        - Testing
            - Pull Request를 보내면 자동으로 테스트를 진행하는 것 또한 구현 가능하고 자동으로 Pull Request를 open 및 close할 수 있게 됨
        - Cron Job
            - 특정한 시간대에 스크립트를 반복 실행할 수 있음
    - Github Action의 구성요소
        - Workflow
            - 레포에 추가할 수 있는 자동화 커맨드의 집합으로 하나 이상의 Job으로 구성되어 있으며 Push나 PR과 같은 이벤트에 의해 실행될 수도 있으며 특정 시간대에 실행될 수도 있음
                
               ![Untitled](https://user-images.githubusercontent.com/53691249/169544406-155d6cee-4ccb-4350-a876-d9599202c006.png)
                
        - Event
            - Workflow를 실행시키는 특정 행동 ( Push, Pull Request, Commit 등 )을 의미 함
        - Job
            - Job이란 동일한 Runner에서 진행되는 Step의 집합
            - 하나의 workflow 내의 여러 Job은 독립적으로 실행되나 필요에 따라 의존 관계를 설정하여 순서를 지정할 수 있음
                - 가령 Test 작업과 Build 작업을 수행하는 Job들이 하나의 workflow에 존재한다면 Build 이후에 Test가 진행되어야 하기 때문에 Build Job이 마무리 된 후 Test Job을 실행할 수 있도록 지정가능 ( Build 실패시 Test는 실행하지 않음 )
        - Step
            - 커맨드를 실행할 수 있는 각각의 Task를 의미하고, Shell 커맨드가 될 수도 있고, 하나의 Action이 될 수도 있음
            - 하나의 Job 내에서 각각의 Step은 다양한 Task로 인해 생성된 데이터를 공유할 수 있음
        - Action
            - Job을 만들기 위해 Step을 결합한 커맨드로 재사용이 가능한 Workflow의 가장 작은 단위
            - 직접 만들거나 Github Community에 의해 생성된 Action을 불러와 사용할 수 있음
        - Runner
            - Runner란 Github Actions Workflow 내에 있는 Job을 실행시키기 위한 애플리케이션
            - Runner Application은 Github에서 호스팅하는 가상환경 혹은 직접 호스팅하는 가상 환경에서 실행 가능하며 Github에서 호스팅하는 가상 인스턴스의 경우 메모리 및 용량 제한이 존재
        
    - Workflow 생성 및 파일 설명
        - .github/workflows 디렉토리 내에 .yml 파일을 생성해도 되지만, Repository의 Actions 탭에서 자동으로 template를 만들어주는 기능을 사용하는 것이 좋음
        - Github에서 제공하는 가장 기본적인 Template는 set up a workflow yourself를 클릭
            
            ![스크린샷 2022-05-20 오후 9 56 20](https://user-images.githubusercontent.com/53691249/169544548-920fb460-2134-4b8a-b80a-92e5a9c43795.png)
            
        
        - 다음과 같은 양식의 .yml 파일이 생성됨
            
            ![스크린샷 2022-05-20 오후 9 58 50](https://user-images.githubusercontent.com/53691249/169544604-da39ac8f-b665-4b2c-a8d0-f62a880e7b60.png)
            
        - 설명
            
            ```yaml
            # Actions 탭에 표시될 Workflow 이름
            name: CI
            
            # Workflow를 실행시키기 위한 Event 목록
            on: # 트리거
              # 하단 코드에 따라 develop 브랜치에 Push 또는 Pull Request 이벤트가 발생한 경우에 Workflow가 실행
              push:
                branches: [main]
              # 특정한 Branch에 푸쉬되었을 때 사용하려면 가령 feature/*로 작성하면 됨
              pull_request:
                branches: [main]
            
              # 해당 옵션을 통해 Actions 탭에서 Workflow를 실행
              workflow_dispatch:
            
            # Workflow의 하나 이상의 Job 
            jobs:
              # Job 이름으로, build라는 이름으로 Job이 표시
              build:
                # Runner가 실행되는 환경을 정의
                runs-on: macos-latest
            
                # build Job 내의 step 목록
                steps:
                  # uses 키워드를 통해 Action을 불러옴
                  # 여기에서는 해당 레포지토리로 check-out 및 레포지토리에 접근할 수 있는 Action을 불러옴.
                  - uses: actions/checkout@v2
                  # 실행되는 커맨드에 대한 설명으로, Workflow에 표시
                  - name: Build
                    run: echo Hello, world!
            
                  # 하나의 커맨드가 아닌 여러 커맨드도 실행 가능
                  - name: Run tests
                    run: |
                      xcodebuild test -project "$XC_PROJECT" -scheme "$XC_SCHEME" -destination 'platform=iOS Simulator,name=iPhone 13'
            ```
  
       - Start Commit 후 Action 탭을 확인해보면 다음과 같이 정상적으로 작동한 것을 확인할 수 있음.
        ![스크린샷 2022-05-23 오후 10 41 42](https://user-images.githubusercontent.com/53691249/169832694-e4414be0-3ec1-4054-9cac-bd174721ffb6.png)


 </div>
 </details>
 
  <details>
 <summary> Github Action 방법 및 적용</summary>
 <div markdown="2">
  
  - 적용방법
    
    ```
    name: TID Automation release
    
    on:
      push:
        branches: [ main ]
      pull_request:
        branches: [ main ]
    
    jobs:
      build:
      
        runs-on: macos-latest
        env: 
    			   # 가상환경
    		   	# Xcode 버전 및 프로젝트와 스키마 설정 + 사용할 키체인 설정 ( 스크립트에서 만들어서 넣을 변수 )
          XC_VERSION: ${{ '13.1' }}
          XC_PROJECT: ${{ 'usket_TID.xcodeproj' }}
          XC_SCHEME: ${{ 'usket_TID' }}
          KEYCHAIN: ${{ 'usket.keychain' }}
          # 루트
          PROJECT_ROOT_PATH: ${{ 'usket_TID' }}
           
          ENCRYPTED_CERTS_FILE_PATH: ${{ '.github/secrets/GithubActionKey.p12.gpg' }}
    			   # 어디에 복호화 할 것인지 명시
          DECRYPTED_CERTS_FILE_PATH: ${{ '.github/secrets/GithubActionKey.p12' }}
    
          ENCRYPTED_PROVISION_FILE_PATH: ${{ '.github/secrets/GithubAction.mobileprovision.gpg' }}
    		   	# 어디에 복호화 할 것인지 명시
          DECRYPTED_PROVISION_FILE_PATH: ${{ '.github/secrets/GithubAction.mobileprovision' }} 
    			
    			   # 기존에 secrets를 가지고와서 적용
          CERTS_EXPORT_PWD: ${{ secrets.CERTS_EXPORT_PWD }}
          CERTS_ENCRYPTION_PWD: ${{ secrets.CERTS_ENCRYPTO_PWD }}
          PROFILES_ENCRYPTO_PWD: ${{ secrets.PROFILES_ENCRYPTO_PWD }}
    			
    			   # 아카이브 path 및 앱스토어에 올릴 artifacts path 설정 
          XC_ARCHIVE_PATH: ${{ 'usket_TID.xcarchive' }}
          XC_EXPORT_PATH: ${{ './artifacts' }}
          
        steps:
          - name: Select Xcode Version
            run: "sudo xcode-select -s /Applications/Xcode_$XC_VERSION.app"
        
          - uses: actions/checkout@v3
    
          - name: Build
            run: echo Hello, world!
    			
    			   # 위에서 만들어둔 키체인 적용
          - name: Configure Keychain 
            run: | 
              security create-keychain -p "" "$KEYCHAIN" 
              security list-keychains -s "$KEYCHAIN" 
              security default-keychain -s "$KEYCHAIN" 
              security unlock-keychain -p "" "$KEYCHAIN"
              
    			   # Code Signing 실행
          - name : Configure Code Signing
            run: | 
              gpg -d -o "$DECRYPTED_CERTS_FILE_PATH" --pinentry-mode=loopback --passphrase "$CERTS_ENCRYPTION_PWD" "$ENCRYPTED_CERTS_FILE_PATH"
              gpg -d -o "$DECRYPTED_PROVISION_FILE_PATH" --pinentry-mode=loopback --passphrase "$PROFILES_ENCRYPTO_PWD" "$ENCRYPTED_PROVISION_FILE_PATH"
              security import "$DECRYPTED_CERTS_FILE_PATH" -k "$KEYCHAIN" -P "$CERTS_EXPORT_PWD" -A
              security set-key-partition-list -S apple-tool:,apple: -s -k "" "$KEYCHAIN"
              mkdir -p "$HOME/Library/MobileDevice/Provisioning Profiles"
              echo `ls .github/secrets/*.mobileprovision`
              # 프로파일들을 rename하고 새로만든 디렉토리에 복사
              for PROVISION in `ls .github/secrets/*.mobileprovision`
                do
                  UUID=`/usr/libexec/PlistBuddy -c 'Print :UUID' /dev/stdin <<< $(security cms -D -i ./$PROVISION)`
                cp "./$PROVISION" "$HOME/Library/MobileDevice/Provisioning Profiles/$UUID.mobileprovision"
                done
    			   # 아카이브!
          - name: Archive
            working-directory: usket_TID
            run: | 
              mkdir artifacts
              xcodebuild archive -project "$XC_PROJECT" -scheme "$XC_SCHEME" -configuration release -archivePath "$XC_ARCHIVE_PATH"
    			   # App Store로 내보내기
          - name: Export for App Store
            run: | 
              xcodebuild -exportArchive -archivePath "$XC_ARCHIVE_PATH" -exportOptionsPlist ExportOptions.plist -exportPath "$XC_EXPORT_PATH"
    
    			   # 업로드하면 끝!
          - name: Upload Artifact
            uses: actions/upload-artifact@v3
            with:
              name: Artifacts
              path: ./artifacts
    ```
  
   </div>
 </details>
 
### 7. 업데이트

  |버전|업데이트 내역|설명|
  |:---:|:---:|:---:|
  |v2.07|추가버튼 클릭시 Navigation Bar는 Overlay View에 감싸지지 않던 오류 <br /> [ [트러블 슈팅 기록 - 블로그](https://pooh-footprints.tistory.com/65) ]|해당 오류를 해결했습니다.|
  |v2.06|개발, 앱, 리뷰를 위한 버튼 생성|각각 깃허브 링크, 앱관련 문의를 위한 이메일 딥링크, 리뷰페이지로 이동가능한 버튼을 추가|
  |v2.05|로고 디자이너 인스타그램 링크|요청으로 링크를 첨부 및 추가 버튼 클릭시 백그라운드 컬러 |
  |v2.04|Firebase Crashlytics|Firebase Crashlytics 적용 및 기타 오류수정|
  |v2.03|Local Notification <br /> [ [트러블 슈팅 기록 - 블로그](https://pooh-footprints.tistory.com/58) ]|로컬알림시 한 단어만 반복해서 오는 이슈를 수정했습니다.|
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
