# 맞춤카페
`Cafe-In4(카페인포)`팀 - 이단비, 구찬우, 전한나, 조민재
### App ADS
개인의 취향의 맞는 카페를 찾고싶어하는 사람들을 위한 카테고리 검색이 가능한 카페 정보 애플리케이션

## 규칙
  * ### 코딩 규칙
    MVC패턴을 준수한다.  
    K&R의 코딩스타일을 준수한다.  
    * #### 네이밍
      * 파일명을 비롯한 모든 네이밍에는 언더바(`_`)와 공백(` `)을 사용하지 않는다.
      * 함수명은 동사형, 변수 및 상수명은 명사형으로 작성한다.
      * IBOutlet 이름은 축약형으로 사용하지 않는다.  
        예) UIButton = Button(O) / Btn (X)
      * IBOutlet 이름은 기능을 정확히 명시하도록 한다.  
        예) 로그인 버튼 : LogInButton
      * 새로운 swift 파일 생성 시 파일명과 class명이 동일하게 명명한다.
    * #### 스토리보드
      * 스토리보드는 뷰 마다 파일 단위로 나눠서 작성하되, 연관된 뷰는 묶어서 작성한다.
    <!-- 3. ##### 모델 -->

  * ### Git 규칙
    * #### Branch
      * `master` - `develop` - `기능단위브랜치` 로 구성한다.  
      * `master` 에는 즉시 배포하여도 문제 없는 상태의 코드로 구성한다.
      * `develop` 는 개발중인 코드를 Merge하는 브랜치로, `기능단위브랜치`와 Merge된다.
      * `기능단위브랜치`는 Github issue에 등록된 이슈 번호를 기준으로 `f`+`이슈번호`로 명명한다.  
      -> 예) `f1`
      * 개발이 완료된 `기능단위브랜치`는 삭제한다.

    * #### Commit
      * 커밋메세지 시작부에는 커밋하는 사람의 이니셜을 기입한다.  
      * 커밋메세지는 한글로 자세히 작성한다.  
        -> 예) `[9] LogInViewController 이메일 TextField 추가`
      * 커밋은 최대한 자주한다.

    * #### Merge & Pull Request
      * `develop`와 `기능단위브랜치`의 Merge는 Pull Request를 통해 팀원들의 리뷰를 거친 후 실행한다.  
        Base : `develop` / Compare : `기능단위브랜치`
      * `develop`와 `master`는 3주에 한번 Merge한다.


  * ### 그 외 규칙
    * 프로젝트 구성 파일(`*.swift`, `*.storyboard`...)은 뷰 단위로 그룹핑한다.  
    -> 예) Login & SignUp, MainView ...
    * 매주 금요일 오후 마다 전체 코드리뷰를 통해 피드백과 코드 개선 작업을 한다.

## Back-End
  * Node.js


## Back Log
  * [바로가기(준비중)](http://goo.gl/VjykF2)

## 협업 툴
  * [Github Project](https://github.com/ni9n/MachumCafe_CafeIn4/projects/1)
  * [Github Issue](https://github.com/ni9n/MachumCafe_CafeIn4/issues)

## 기타

  * ### 팀원 이니셜
    ```
    구찬우 - [9]
    이단비 - [B]
    전한나 - [H]
    조민재 - [J]
    ```
