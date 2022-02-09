# StudyRStudio-
빅데이터_RStudio_학습_리포지토리

### 1일차
- 프로그램에 연결되어 있는 경로 확인
    - 경로(위치) 확인: getwd()
    - 경로(위치) 설정: setwd()

- 파일 불러오기
    - read.csv()
    - read.excel()

- 데이터 프레임 만들기
    - data.frame()

- 데이터 프레임 CSV 파일로 저장하기
    - write.csv(,file=)

- 데이터를 데이터 프레임 형태로 불러오기
    - as.data.frame()

- 데이터 프레임에 파생변수 추가
    - 예시
    - df = data.frame(var1= c(4,3,8), var2=c(2,6,1))
    - df$var_sum = df$var1+df$var2 # var_sum 
    - df$var_sum = 10 # var_sum 

- 히스토그램 생성
    - hist()
    - 예시
    df$var_mean = (df$var1+df$var2)/2 # var_sum 파생변수 생성
    df$var_mean = 5
    df

- 조건문 사용
    - ifelse(): (조건, 참일때, 거짓일때)

- %>%, %in%
    - %>%: ~ 중에서, 뒤에 함수 사용
    - %in%: ~ 중에서, 뒤에 c(,...,) 사용

- 데이터 파악하기
    - head(): 데이터 앞부분 출력
    - tail(): 데이터 뒷부분 출력
    - View(): 뷰어 창에서 데이터 확인
    - dim(): 데이터 차원 출력
    - str(): 데이터 속성 출력
    - summary(): 요약통계량 출력


### 2일차
- 데이터 정렬  
    - 오름차순: arrange()
    - 내립차순: arrange(desc())

- 파생변수(칼럼) 추가
    - mutate()

- mutate()에 ifelse() 적용하기
    - 파생변수를 추가하면서 조건문을 추가하여 사용하는 경우가 많음 
    - 조회할때만 사용 가능
    - 변수에 지정을 해주어야 저장

- summarise()
    - 예시
    exam_1 %>% summarise(mean_math = mean(math))
    - exam_1에 mean_math라는 변수에 mean()함수를 이용하여 mean(math)를 추가
    
- group_by()

- filter()

- select()

- 데이터 합치기. join()
    - 가로로 합치기
        - left_join( , ,by=''): 왼쪽을 기준으로 join(결합)을 해주는 함수
    - 세로로 합치기
        - bind_rows(, )

- 결측치 확인하기
    - is.na()
    - table(is.na()): 결측치 빈도 출력



### 3일차
- 변수명 변경
    - rename()

- 변수 검토
    - class()
    - table(): 이상치( | 결측치) 유무 확인. 

