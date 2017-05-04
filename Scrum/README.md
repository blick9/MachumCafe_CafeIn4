# Scrum
## 일일 Scrum
  * ### 05.04(목)
    * #### 전체 코드 리팩토링
    * #### 전한나
      * [x] SwiftyJSON 모듈을 이용한 Network 코드 리팩토링
      * [x] LogIn & SignUp View 코드 리팩토링
    * #### 구찬우
      * [ ] 현재 사용자 위치 보여주기
      * [x] BookmarkView Code 보완(CafeImage 비동기 방식 해결)
      * [x] 코드 리팩토링
    * #### 이단비
      * [x] 등록제안 View 구현
    * #### 조민재
      * [x] FilterView 버튼 기능 연결

  * ### 05.03(수)
    * #### 전한나
      * [x] MainView View배치
      * [x] CafeDefault Image HTTP 통신으로 ModelCafe에 Image 적용
    * #### 구찬우
      * [x] CafeDetailView 데이터 보여주는 방식 수정
      * [ ] 현재 사용자 위치 보여주기
      * [x] BookmarkView Code 보완(비로그인시 로그인권장, 데이터 불러와서 보여주기)
    * #### 이단비
      * [x] FilterView Design Support
      * [x] FilterView 일부 구현
      * [x] MainView 구현
    * #### 조민재
      * [x] FilterView Design
      * [x] FilterView 일부 구현

  * ### 05.02(화)
    * #### 전한나
      * [x] Bookmark GET API Response 수정
      * [x] networkBookmark Class 수정
      * [x] MainView 구현
      * [x] CafeDefault Image 서버와 연동
    * #### 구찬우
      * [x] ListView Bookmark 상태 적용하기
      * [ ] ModelCafe Data MapView에 보여주기
    * #### 이단비
      * [x] DetailTableView Category 셀 추가 구현
      * [x] DetailView Category Icon 디자인
      * [x] DetailTableView AutoLayout 작업중
    * #### 조민재
      * [x] BookmarkView 구현 (ModelCafe BookmarkList Data 그려주기)
      * [x] FilterView 디자인
      * [x] FilterView 구현

  * ### 05.01(월)
    * #### 전한나
      * [x] ListContainerView 구현, DataModel 메서드 구현
    * #### 구찬우
      * [x] ListContainerView 구현, DataModel 메서드 구현
    * #### 이단비
      * [x] LogIn & SignUp View 구현 (서버 연동)
    * #### 조민재
      * [x] BookmarkView 구현

## 주차별 계획
  * ### 3주차 (5.1 ~ 5.7)
    * #### View 구현 계획
      * ##### LogIn & SignUp View
        * [x] 서버와 연동하여 정상적인 동작을 목표
        * [x] ModelUser 저장 확인
        * [x] LogIn 성공 시 SideBarView내 LogIn 상태 적용 (Nickname 보이기, LogIn버튼 )
        * [x] LogIn & SignUp View 코드 리팩토링
      * ##### ListContainerView (ListView & MapView)
        * [x] 서버로 부터 받아온 CafeList Data 전체 보여주기
      * ##### BookmarkView
        * [x] CollectionView로 뷰 구현
        * [x] UserModel로부터 Bookmark 목록 불러오기
        * [x] DetailView 연결
      * ##### DetailView
        * [x] CafeList Data에 저장된 ModelCafe 보여주기
        * [x] 즐겨찾기 추가 & 삭제 정상 구동 (BookmarkView와 동기 시킬 수 있어야 함)
        * [x] 카테고리 보여주는 방식 정하기
      * ##### DataModel
        * [x] Getter / Setter 메서드 구현
        * [x] CafeData Default 이미지 만들기
      * ##### FilterView
        * [x] View 그리기
        * [x] 카테고리 종류 만큼 버튼 만들기
        * [x] UIButton or CollectionView로 구현
      * ##### MainView
        * [x] 카테고리 선택 버튼 추가(6개)
        * [x] '내게 맞는 카페찾기' 버튼 추가 -> FilterView 연결
        * [x] 상단 배너 추가(스크롤)
      * ##### Network
        * [x] SwiftyJSON 모듈을 이용한 코드 리팩토링
