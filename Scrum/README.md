# Scrum
## 일일 Scrum
  * ### 05.03(수)
    * #### 전한나
      * [ ] MainView 구현
      * [ ] CafeDefault Image HTTP 통신으로 ModelCafe에 Image 적용
    * #### 구찬우
      * [ ] CafeDetailView 데이터 보여주는 방식 수정
      * [ ] 현재 사용자 위치 보여주기
    * #### 이단비
      * [ ] FilterView Design Support
      * [ ] FilterView 일부 구현
    * #### 조민재
      * [ ] FilterView Design
      * [ ] FilterView 일부 구현

  * ### 05.02(화)
    * #### 전한나
      * [x] Bookmark GET API Response 수정
      * [x] networkBookmark Class 수정
      * [ ] MainView 구현
      * [ ] CafeDefault Image 서버와 연동
    * #### 구찬우
      * [x] ListView Bookmark 상태 적용하기
      * [ ] ModelCafe Data MapView에 보여주기
    * #### 이단비
      * [x] DetailTableView Category 셀 추가 구현
      * [x] DetailView Category Icon 디자인
      * [x] DetailTableView AutoLayout 작업중
    * #### 조민재
      * [x] BookmarkView 구현 (ModelCafe BookmarkList Data 그려주기)
      * [ ] FilterView 디자인
      * [ ] FilterView 구현

  * ### 05.01(월)
    * #### 전한나
      * [x] ListContainerView 구현, DataModel 메서드 구현
    * #### 구찬우
      * [x] ListContainerView 구현, DataModel 메서드 구현
    * #### 이단비
      * [x] LogIn & SignUp View 구현 (서버 연동)
    * #### 조민재
      * [ ] BookmarkView 구현

## 주차별 계획
  * ### 3주차 (5.1 ~ 5.7)
    * #### View 구현 계획
      * ##### LogIn & SignUp View
        * [x] 서버와 연동하여 정상적인 동작을 목표
        * [x] ModelUser 저장 확인
        * [x] LogIn 성공 시 SideBarView내 LogIn 상태 적용 (Nickname 보이기, LogIn버튼 )
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
        * [ ] View 그리기
        * [ ] 카테고리 종류 만큼 버튼 만들기
        * [ ] UIButton or CollectionView로 구현
      * ##### MainView
        * [ ] 카테고리 선택 버튼 추가(6개)
        * [ ] '내게 맞는 카페찾기' 버튼 추가 -> FilterView 연결
        * [ ] 상단 배너 추가(스크롤)
