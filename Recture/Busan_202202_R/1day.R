library(readxl)
# 경로는 항상 헷갈린다. 조심히 하자!
getwd() # 위치 확인
setwd() # 위치 설정

exam=read.csv("./Data/csv_exam.csv")
exam
View(exam)
dim(exam)
summary(exam)

# mpg 데이터 확인하기 -> 자동차 연비 데이터(내장 데이터)
# ggplot1의 mpg 데이터를 '데이터 프래임' 형태로 불러오기.
mpg = as.data.frame(ggplot2::mpg)
mpg

# 데이터 앞/뒷부분 10개를 조회.
head(mpg,10)
tail(mpg,10)

# 데이터의 타입과 속성을 조회.
str(mpg)

summary(mpg)

# 데이터 컨트롤에 사용되는 패키지 설치 및 로드하기.
install.packages("dplyr") # dplyr 설치.
library(dplyr) # dplyr 로드.

df_raw = data.frame(var1 = c(1,2,1),
                    var2 = c(2,3,2))
df_raw

df_new = df_raw # 복사본 생성. 원본 유지.
df_new

df_new = rename(df_new, v2=var2) # 변수명 수정.
df_new

# 데이터 프레임에 새로운 변수(파생변수) 만들기.
df = data.frame(var1= c(4,3,8),
                var2=c(2,6,1))
df

df$var_sum = df$var1+df$var2 # var_sum 파생변수 생성.
df$var_sum = 10 # var_sum 파생변수 생성.
df

df$var_mean = (df$var1+df$var2)/2 # var_sum 파생변수 생성.
df$var_mean = 5
df

# -----------------------------------------------------------------
mpg
head(mpg)

mpg$total = (mpg$cty+mpg$hwy)/2 # 통합연비 (파생)변수 생성.
mpg

summary(mpg) # 요약 통계량 산출.
hist(mpg$total) # 히스토그램 생성. 막대그래프.

# 조건문 사용.
# ifelse([조건], [조건에 맞을 때 부여], [조건과 맞지 않을 때 부여])
mpg$test = ifelse(mpg$total >= 20, "pass", "fail")
head(mpg,20) # 데이터 확인.

# 통합 연비 빈도표 조회.
table(mpg$test)

library(ggplot2) # ggplot2 로드.
qplot(mpg$test) # 연비 합격 빈도 막대 그래프 생성. 데이터 시각화.

# total을 기준으로 A, B, C 등급 부여 (등급 -> 번주)
# 이중 조건문.
# 다양한 조건을 활용해서 나눌 수 있다.
mpg$grade = ifelse(mpg$total >= 30, "A",
                   ifelse(mpg$total >= 20, "B", "C"))
head(mpg)
table(mpg$grade) # 등급 빈도표 조회.
qplot(mpg$grade) # 등급 빈도를 막대 그래프로 그리기. 시각화.

# -----------------------------------------------------------------
# 실습하기.
midwest = as.data.frame(ggplot2::midwest)
head(midwest)
tail(midwest)
View(midwest)
dim(midwest) # 행과 열 개수
str(midwest)
summary(midwest)
# 빈도표=table() 빈도막대=테이블을 그려보는것.

# poptotal을 total로 변수명 수정.
library(dplyr) # rename()에서 사용.
midwest_test = rename(midwest, total = poptotal)
str(midwest_test)

# popasian을 asian으로 변수명 수정.
midwest_test_1 = rename(midwest_test, asian = popasian)
str(midwest_test_1)

# '전체 인구 대비 아시아 인구의 백분율' 파생변수를 만들고 히스토그램 보기.
midwest_test_1$percent = (midwest_test_1$asian/midwest_test_1$total)*100
str(midwest_test_1)
summary(midwest_test_1)
table(midwest_test_1$percent)
hist(midwest_test_1$percent)

# 아시아 인구 백분율 전체 평균
midwest_test_1$asian_mean = mean(midwest_test_1$percent)
str(midwest_test_1)

# 평균을 초과하면 large, 그 외는 small
midwest_test_1$asian_check = ifelse(midwest_test_1$percent > 0.487, "large", 'small')
head(midwest_test_1, 10)

# 확인..? 나 다 못함.
table(midwest_test_1$asian_check)

# -----------------------------------------------------------------
library(dplyr)
exam
dim(exam)

# exam에서 class가 1인 경우만 출력.
# filter() 함수.
# 컨트롤 + 쉬프트 + M = %>% = ~ 중에서(개념)
exam %>% filter(class == 1) # 필터링한 결과를 조회.

# 1반이 아닌 경우.
exam %>% filter(class != 1)

# 초과, 미만, 이상, 이하 조건 걸기.(비교연산자)

# 여러 조건을 충족하는 행 추출하기.
# 1반이면서 수학점수가 50번 이상인 경우.
exam %>% filter(class==1 & math>=50)

# 1반이거나 수학점수가 50번 이상인 경우.
exam %>% filter(class==1 | math>=50)

# 조건이 여러개인 경우.
exam %>% filter(class ==1 | class == 3 | class == 5) # 1, 3, 5에 해당하는 경우 추출.

# -------------------------------------------------------
# 추출한 행으로 데이터 만들기
class1 = exam %>% filter(class ==1)

# 논리연산자의 기준은 왼쪽이다. 

mpg
dim(mpg)
summary(mpg)
str(mpg)

# 자동차 배개량에 따라 고속도로 연비가 다른지 알아보려고 한다. 
# displ(배기량)이 4이하인 자동차와 5이상인 자동차 중 어떤 자동차의 hwy(고속도로 연비)가 높은지 알아보라.
four = mpg %>% filter(displ <= 4) # 이하
four
mean(four$hwy)
five = mpg %>% filter(displ >= 5) # 이상
five
mean(five$hwy)

# 자동차 제조 회사에 따라 도시 연비가 다른지 알아보려고 한다.
# audi와 toyota 중 어느 manufactor(자동차 제조 회사)가의 cty(도시 연비)가 평균적으로 높은지 알아보라.
audi = mpg %>% filter(manufacturer == "audi")
audi
mean(audi$cty)
toyota = mpg %>% filter(manufacturer == "toyota")
toyota
mean(toyota$cty)

# chevrolet, ford, honda 자동차의 고속도로 연비 평균을 알아보려고 한다.
# 이 회사들의 자동차를 추출한 뒤 hwy 전체 평균을 구해보라.
unique(mpg$manufacturer)  
mpg_new = mpg %>% filter(manufacturer %in% c("chevrolet", "ford", "honda"))
mean(mpg_new$hwy)

# ------------------------------------------------------------
exam %>% select(math) # math 컬럼 추출.

# 여러 변수 추출하기.
exam %>% select(class ,math, english)

# 변수 제외하고 추출하기.
exam %>% select(-math) # math 컬럼 제외하고 추출.
exam %>% select(-math, -english)

# class가 1인 행만 추출한 다음 english를 선택하여 추출.
exam %>% filter(class==1) %>% select(english)

exam %>% 
  filter(class==1) %>% 
  select(english)

exam %>% 
  select(id, math) %>% 
  head()

# ------------------------------------------
# mpg데이에서 class(자동차 종류), cty(도시 연비) 변수를 추출하여 새로운 데이터를 만드세요.
mpg
str(mpg)
mpg %>% select(class, cty)
mpg_two = mpg %>% select(class, cty)
mpg_two
summary(mpg_two)
head(mpg_two)

mpg = as.data.frame(ggplot2::mpg)
df = mpg %>% select(class, cty)
head(df)

# 자동차 종류에 따라 도시 연비가 다른지 알아보려고 한다.
# class가 suv인 자동차와 compact인 자동차 중에 어떤 자동차의 cty가 더 높은지 알아보시오.
df_suv = df %>% filter(class == "suv")
mean(df_suv$cty)

df_compact = df %>% filter(class == "compact")
mean(df_compact$cty)







