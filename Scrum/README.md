# Scrum
## 일일 Scrum
* ### 05.30(화)
  * #### 전체
    * [ ] 오토레이아웃
  * #### 전한나
    * [x] 현위치 재설정 했을 경우엔 현위치 반경 1km로 카페목록 초기화
    * [x] 폐업신고 api 생성, 버튼 기능 활성화
    * [x] 카페 리스트 텍스트 마지막 \n 삭제
    * [x] 위치 설정 label 크기 수정
    * [x] 비밀번호 유효성 검사, placeholder 추가
    * [ ] listMapView 카페 핀 터치 시 올라오는 뷰에 카페 이미지 적용
  * #### 구찬우
    * [ ] 메인 스크롤뷰 자동 스크롤 및 indicator 추가
    * [x] ListTableView 내 별점 위치 정렬
    * [ ] Deep Link 구현
    * [x] 남은거리 글자크기 키우기
    * [x] 리뷰 더보기 cell 리뷰 갯수만큼 보이기
    * [x] detailView 에 평점 기능 추가
  * #### 이단비
    * [ ] 메인 오토레이아웃 설정
    * [ ] 회원가입 오토레이아웃 설정
    * [ ] 북마크 컬렉션 뷰 리디자인
    * [ ] 리뷰작성 뷰 리디자인
    * [ ] 디테일뷰 네비게이션바에 타이틀 삭제  
    * [ ] 전화하기, 제보하기 버튼 위치 통일
  * #### 조민재
    * [ ] 현 위치 구글 주소 검색 국가 설정( 한국만 검색 )
    * [ ] 리뷰 이미지 동그라미로
    * [ ] 리스트 뷰 cell선택 시 여백에 이미지 나오는거 수정
    * [ ] 오토레이아웃 공부

* ### 05.27(토)
  * #### 전한나
    * [x] 카페 정보 주소, 전화번호 위치 수정
    * [x] cafeDetailView 이미지 스크롤뷰 생성
    * [x] 서버 cafe에 평점 추가되어 클라이언트 모델, 네트워크 수정된 내용에 대응
    * [x] review 등록 시 카페 별점 평균 내서 카페 정보 수정
    * [x] 유저 이미지 get static폴더 지정 및 클라이언트 통신 구현
    * [x] 전체적인 유저 모델 kakao유저와 local유저 구분하여 전체 코드 대응
    * [x] 리뷰 등록 및 보일때 리뷰등록한 유저의 프로필 사진 보이는 기능 구현
  * #### 구찬우
    * [ ] ReviewView more 버튼 수정
    * [ ] 서버 local user 프로필 이미지 업르드 api 생성
    * [ ] 클라이언트 user 프로필 이미지 추가
  * #### 이단비
    * [ ] 공유 기능 마무리
    * [ ] cafeDetailView 카테고리 cell 높이 수정
    * [ ] cafeDetailView 리뷰 cell 오토레이아웃 리팩토링
    * [ ] '제보해주세요' 버튼 디자인
  * #### 조민재
    * [ ] 업데이트 예정

* ### 05.26(금)
  * #### 전한나
    * [x] 디테일뷰 없는 항목 정리( '제보해주세요' 버튼 추가 및 SuggestionView 연결 )
    * [x] editCafe api 생성
    * [ ] 리뷰 cell count 리팩토링
  * #### 구찬우
    * [x] 전체카페리스트 일 경우 카테고리 선택 항목 안보이게 리팩토링
    * [x] 기존 미터로 나오는 현상 1000m 이상 넘어가면 km로 나오게 리팩토링
    * [x] CafeDetailView 더보기 버튼(수정제보, 폐업신고) 생성( 기능구현 X )
  * #### 이단비
    * [ ] 공유 기능 마무리
    * [x] CafeDetailView 카페의 카테고리 항목 보이는 기능
  * #### 조민재
    * [ ] 키보드 Response

* ### 05.23(화)
  * #### 전한나
    * [x] NetworkBookmark, 변수 이름 등 리팩토링
    * [x] 서버 bookmark api 경로 수정
    * [x] 서버 message 변수 result로 변경
    * [x] review 등록 시 날짜 생성
    * [x] suggestionNewCafe시 좌표 전송, 서버에서 request 대응
    * [x] SpecificCafe GET api 생성
  * #### 구찬우
    * [ ] DetailView 리팩토링(정보 없는 cell정리)
    * [ ] DetailView 카테고리 표시 (FilterCollectionViewCell 이용)
  * #### 이단비
    * [ ] DetailView 리팩토링
    * [ ] Share 기능 구현 (Link)
  * #### 조민재
    * [x] ListView cell간 간격 조정
    * [x] ListView cell 각 카페별 tag 표시

* ### 05.22(월)
  * #### 전한나
    * [x] 카카오톡 로그인 연동
  * #### 구찬우
    * [x] Review Client 구현
    * [x] Review Server Api 구현
  * #### 이단비
    * [x] Share 기능 구현 (Deep Link 구현)
  * #### 조민재
    * [x] 현위치와 카페간 직선 거리 표시

* ### 05.17(수)
  * #### 전한나
    * [x] Filter 기능 구현
  * #### 구찬우
    * [x] View Present 코드 개선
    * [ ] Search Bar Cancel 버튼 Hide
    * [x] GMSAutoCompleteViewController 내 SearchBar 색상 변경
  * #### 이단비
    * [ ] cafeDetailView 코드 리팩토링 & Share 기능 구현
    * [ ] ListView 코드 리팩토링
  * #### 조민재
    * [x] WriteReviewView Cell 추가 적용

* ### 05.16(화)
  * #### 전한나
    * [x] 경기도 DB 크롤링
    * [x] Filter 기능 구현
  * #### 구찬우
    * [x] Filter 기능 구현
    * [x] SetLocationView 주소 검색 기능 추가
    * [x] SuggestionView내 주소 검색 기능 추가
  * #### 이단비
    * [x] SuggestionView 카테고리 CollectionView 가져와 적용하기
  * #### 조민재
    * [x] Review 작성
    * [x] WriteReviewView 뷰 구성
    * [x] WriteReviewView starRaking 적용

* ### 05.15(월)
  * #### 전한나
    * [x] SuggestionView Client Api 구현
    * [x] 지도 움직일 때 마다 데이터 불러오기 (중복 제외 로직 구현)
    * [x] Image Networking 이슈 해결
    * [x] BookmarkView 코드 리팩토링
  * #### 구찬우
    * [x] 지도 움직일 때 마다 데이터 불러오기 (중복 제외 로직 구현)
    * [ ] Keyboard Response
    * [x] Image Networking 이슈 해결
    * [ ] 장소 검색 Api 적용
  * #### 이단비
    * [x] SuggestionView Client Api 구현
    * [x] FilterView 디자인 Support
      [x] FilterView 초기화 기능 구현
      [x] CollectionView 동적 Cell Size 구현
  * #### 조민재
    * [x] FilterView 초기화 기능 구현
    * [x] CollectionView 동적 Cell Size 구현
    * [x] ReviewView 뷰 구성
    * [x] ReviewView tableView

  * ### 05.10(수)
    * #### 전한나
      * [x] DB 백업
      * [x] SuggestionView Server Api 구현
    * #### 구찬우
      * [x] ListContainerView Bug 수정
    * #### 이단비
      * [x] ImagePicker 다중 선택 CollectionView 만들기
      * [x] SuggestionView request Api 구현
    * #### 조민재
      * [x] FilterView 카테고리 수정

  * ### 05.09(화)
    * #### 전한나
      * [x] DB구조 변경으로 NetworkCafe 코드 수정
    * #### 구찬우
      * [x] 일정 거리내 데이터 불러오는 기능 구현
    * #### 이단비
      * [x] imagePicker 다중 선택 CocoaPod 적용
    * #### 조민재
      * [x] Background 위치 추적

  * ### 05.08(월)
    * #### 전체
      * [x] DB Model 재정의
    * #### 전한나
      * [x] 크롤링 및 DB 자동화 로직
    * #### 구찬우
      * [x] 코드 개선
    * #### 이단비
      * [x] ImagePicker 추가 (다중 선택)
    * #### 조민재
      * [x] Background 위치 추적

  * ### 05.04(목)
    * #### 전체 코드 리팩토링
    * #### 전한나
      * [x] SwiftyJSON 모듈을 이용한 Network 코드 리팩토링
      * [x] LogIn & SignUp View 코드 리팩토링
    * #### 구찬우
      * [x] 현재 사용자 위치 보여주기
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
      * [x] 현재 사용자 위치 보여주기
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
      * [x] ModelCafe Data MapView에 보여주기
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
* ### 5주차 (5.15 ~ 5.21)
  * #### View 구현 계획
    * ##### 전체
      * [ ] Back-Log 재정리
      * [ ] 코드 리뷰 & 리팩토링
    * ##### SuggestionView
      * [x] 선택한 이미지 삭제 기능 추가
      * [x] 카테고리 버튼 추가
    * ##### FilterView
      * [x] 카테고리 버튼 구현 (CollectionView)
      * [ ] 카테고리 필터 표시
      * [ ] 필터 검색 기능 구현
    * ##### CafeDetailView
      * [x] 별점 기능 추가
      * [ ] 값이 없는 경우 Cell 보이지 않기
    * ##### MapView
      * [ ] 현위치와 카페간 직선 거리 표시
      * [ ] 지도 움직일 때 마다 데이터 불러오기 (중복 제외 로직 구현)
    * ##### Keyboard Response
      * [ ] TextField 선택 시 View 올리기
      * [ ] 키보드 없애기
    * ##### Status Bar
      * [x] View 배경에 따라 Status Bar Style 변경
  * #### Model
    * ##### DB
      * [x] 서울시 데이터 크롤링 (서울시 5,700여개 완료)
      * [x] 경기도 데이터 크롤링

* ### 4주차 (5.8 ~ 5.14)
  * #### View 구현 계획
    * ##### 전체
      * [ ] Back-Log 재정리
      * [x] 코드 리뷰 & 리팩토링
    * ##### SuggestionView
      * [x] 서버 API
      * [x] 네트워크 클래스 생성
      * [x] ImagePicker 추가 (다중 선택)
    * ##### FilterView
      * [x] 카테고리 확정 후 모델 리팩토링
    * ##### CafeDetailView
      * [ ] 별점 기능 추가
    * ##### MapView
      * [x] 서버로 부터 일정 반경 내 위치한 데이터만 불러오기
      * [x] Background 위치 추적
      * [ ] 현위치와 카페간 직선 거리 표시
  * #### Model
    * ##### DB
      * [x] 크롤링 및 DB 자동화 로직
      * [x] DB Model 재정의
      * [x] List 카테고리 HTML 크롤링

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
      * ##### FilterView
        * [x] View 그리기
        * [x] 카테고리 종류 만큼 버튼 만들기
        * [x] UIButton or CollectionView로 구현
      * ##### MainView
        * [x] 카테고리 선택 버튼 추가(6개)
        * [x] '내게 맞는 카페찾기' 버튼 추가 -> FilterView 연결
        * [x] 상단 배너 추가(스크롤)
    * #### Model
      * ##### DataModel
        * [x] Getter / Setter 메서드 구현
        * [x] CafeData Default 이미지 만들기
    * #### Network
      * ##### SwiftyJSON
        * [x] SwiftyJSON 모듈을 이용한 코드 리팩토링
