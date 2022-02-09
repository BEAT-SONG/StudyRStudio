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

df$var_mean = (df$var1+df$var2)/2 # var_sum 파생변수 생성.
df$var_mean = 5
df


### 2일차
- 데이터 정렬
    - 오름차순: arrange()
    - 내립차순: arrange(desc())

- 파생변수(칼럼) 추가
    - mutate()

- mutate()에 ifelse() 적용하기
    - 파생변수를 추가하면서 조건문을 추가하여 사용하는 경우가 많음. 

