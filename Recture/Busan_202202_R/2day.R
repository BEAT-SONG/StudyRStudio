# 꼭 하기~
getwd() # 위치 확인
setwd() # 위치 설정

library(dplyr)

exam=read.csv("./Data/csv_exam.csv")
exam

# 오름차순으로 정렬하기.
# 오름차순 asending
# 내림차순 desending
exam %>% arrange(math) # math 오름차순 정렬.

# 내림차순으로 정렬하기.
exam %>% arrange(desc(math)) # math 내림차순 정렬.

# 정렬 기준 변수 여러개 지정.
# 첫번째 기준에 동일한 값에서 그 다음 기준으로 정렬한다.
exam %>% arrange(class, math) # class 및 math 오름차순 정렬.

# --------------------------------------------------------
# 실습
# audi 에서 생산한 자동차 중에 어떤 자동차 모델의 hwy(고속도로 연지)가 높은지 알아보려고 한다.
# audi 에서 생산한 자동차중 hwy가 1~5위에 해당하는 자동차 데이처응 출력하라.
mpg = as.data.frame(ggplot2::mpg)
mpg
summary(mpg)
mpg$manufacturer
mpg_audi = mpg %>% filter(manufacturer == "audi")
mpg_audi
mpg_audi_hwy = mpg_audi %>% select(manufacturer, hwy)
audi_hwy = mpg_audi_hwy %>% arrange(desc(hwy))
head(audi_hwy, 5)

# 강사님
# 데이터의 컬럼이 무엇인지 알아내는 것부터가 데이터 분석이다.
mpg = as.data.frame(ggplot2::mpg)
mpg
summary(mpg)

mpg %>% filter(manufacturer == "audi") %>%  # audi 출력.
  arrange(desc(hwy)) %>%  # hwy 내림차순 정렬.
  head(5) # 5행까지 출력.

# 파생변수(컬럼) 추가하기.
exam
exam %>% mutate(total = math+english+science) %>%  # 총합 변수 추가.
  head # 일부 추출.

# 여러 파생변수 한 번에 추가하기.
exam %>% mutate(total = math+english+science, # 총합 변수 추가.
                mean = (math+english+science)/3) %>%   # 총평균 변수 추가.
        head # 일부 추출.

# mutate()에 ifelse() 적용하기.
# 자주 사용하는 함수의 활용!!
# 조회할때만 가능. 즉, 저장이 되어서 추가되지는 않고 확인하는 용도로 사용.
exam %>% 
  mutate(test = ifelse(science >= 60, "pass", "fail")) %>% 
  head

exam

# ------------------------------------------------------------
# mpg 에서 통합연비 변수 추가.
# mpg 데이터의 복사본을 만들고, cty와 hwy을 더한 '합산 연비 변수'를 추가.
mpg
mpg_test = mpg
mpg_test
mpg_test$ch = mpg_test$cty + mpg_test$hwy
mpg_test

# 강사님.
mpg_test = mpg_test %>% mutate(ch = cty + hwy)

# '합산 연비 변수'를 2로 나눠 '평균 연비 변수' 추가.
mpg_test$ch_mean = mpg_test$ch/2
mpg_test

# 강사님.
mpg_test = mpg_test %>% mutate(ch_mean = ch/2)

# '평균 연비 변수'가 가장 높은 자동차 3대
mpg_test %>% 
  arrange(ch_mean) %>% 
  head(3)

# 위의 3가지 문제를 하나로 해결할 수 있는 하나로 연결된 dplyr 구문을 만들어 출력하라.
# 데이터 복사본 대신 mpg 원본을 이용하라.
mpg_re = mpg %>% 
  mutate(ch = cty + hwy,
         ch_mean = ch/2) %>% 
  arrange(desc(ch_mean)) %>% 
  head(3)

mpg_re

# 집단별로 요약하기.
# summarise()함수의 기능.
# mean_math라는 변수에 mean()함수를 이용하여 mean(math)를 추가한다.
# 이거는 조회된 데이터 이다.
# 조회된 데이터는 변수에 추가할 수 있다. 
# 추가할 때 행과 열이 맞는 데이터만 추가할 수 있음. 아님 오류남.
exam_1 = exam
exam_1
exam_1 %>% summarise(mean_math = mean(math)) # math 평균 산출.


# 집단별로 요약하기.
exam
exam %>% 
  group_by(class) %>%  # class 별로 분리.
  summarise(mean_math = mean(math)) # math 평균 산출.

# 여러 요약통계량 한 번에 산출하기.
exam
exam %>% 
  group_by(class) %>%  # class 별로 분리.
  summarise(mean_math = mean(math), # math 평균.
            sum_math = sum(math), # math 합계.
            median_math = median(math), # math 중앙값.
            n=n()) # 학생 수.

# 각 깁단별로 다시 집단 나누기.
# group_by()함수에 2개 이상의 변수로 집단을 나누면,
# 그 변수들을 동시에 만족시키는 것으로 집단을 나눠서 출력.
mpg %>% 
  group_by(manufacturer, drv) %>%  # 회사별, 구동방식별 분리.
  summarise(mean_cty = mean(cty)) %>%  # cty 평균 산출.
  head(10) # 일부 출력.

# -------------------------------------------------------------------
# 회사별로 suv 자동차의 도시 및 고속도로 통합연비 평균을 구해 내림차순으로 정렬.
# 1 ~ 5위 출력.
# 분석절차가 중요!
summary(mpg)
unique(mpg$class)
mpg = mpg %>% group_by(manufacturer) %>%  # 회사별로 분리.
  filter(class == "suv") %>%  # suv 추출.
  mutate(ch=(cty+hwy)) %>%  # 통합 연비 변수 생성 및 추가.
  summarise(mean_ch=mean(ch)) %>% 
  arrange(desc(mean_ch)) %>% 
  head(5)
mpg  
dim(mpg)

mpg=as.data.frame(ggplot2::mpg)

# -------------------------------------------------------------------------
# mpg 데이터의 class가 suv, compact 등 자동차를 특징에 따라 일곱 종류로 분류한 변수 이다.
# 어떤 자동차의 연비가 높은지 비교해 볼려고 한다. class 별 cty의 평균 구해라.
mpg=as.data.frame(ggplot2::mpg)
mpg
mpg %>% group_by(class) %>% 
  summarise(mean_cty = mean(cty))

# 앞 문제의 출력 결과는 class 값 알파벳 순으로 정렬되어 있습니다.
# 평균이 높은 순으로 정렬.
mpg %>% group_by(class) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  arrange(desc(mean_cty))

# 어떤 회사 자동차의 hwy(고속도로 연비)가 가장 높은지 알아보려고 한다.
# hwy의 평균이 가장 높은 회사 3곳을 출력.
mpg %>% group_by(manufacturer) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  arrange(desc(mean_cty)) %>% 
  head(3)

# 어떤 회사에서 compact(경차)차종을 가장 많이 생산하는지 알아보려고 합니다.
# 각 회사별 compact 차종 수를 내림차순으로 정렬해 출력.
# n()함수는 group_by()함수에서 집계 단위 별 레코드(행) 수를 카운트하는 함수.
mpg %>% group_by(manufacturer) %>% 
  filter(class == "compact") %>% 
  summarise(num_compact = n()) %>% 
  arrange(desc(num_compact))

# 강사님.
# 조건이 있다면 먼저 filter을 사용해서 걸러내고 gruop화하는 것이 속도에서 이점이 있음.
# 생각하고 쿼리 짜기.
mpg %>% filter(class == "compact") %>% 
  group_by(manufacturer) %>% 
  summarise(num_compact = n()) %>% 
  arrange(desc(num_compact))

# 가로로 합치기
# 중간고사 데이터 생성
test1 = data.frame(id = c(1,2,3,4,5),
                   midterm = c(60,80,70,90,85))

# 기말고사 데이터 생성
test2 = data.frame(id = c(1,2,3,4,5),
                   final = c(70,83,65,95,80))
test1
test2

# id 기준으로 합치기
# join()
# left_join(): 왼쪽을 기준으로 join(결합)을 해주는 함수.
# 자주 사용하는 함수!
total = left_join(test1, test2, by = 'id') # id 기준으로 합쳐 total에 할당.
total # total 출력.

# 반별 담임교사 명단 생성.
name = data.frame(class = c(1,2,3,4,5),
                  tescher = c("kim", 'lee', 'park', 'choi', 'jung'))
name

exam_new = left_join(exam, name, dy = 'class')
exam_new

# 세로로 합치기.

# 학생 1 ~ 5번 시험 데이터 생성.
group_a = data.frame(id = c(1,2,3,4,5),
                     test = c(60,80,70,90,85))

# 학생 6 ~ 10번 시험 데이터 생성.
group_b = data.frame(id = c(1,2,3,4,5),
                     test = c(70,83,65,50,90))

# 세로로 합치기.
group_all = bind_rows(group_a, group_b) # 데이터를 합쳐서 group_all 에 할당.
group_all

# ---------------------------------------------------------------------------
# mpg
fuel = data.frame(fl = c('c','d','e','p','r'),
                  price_fl = c(2.35,2.38,2.11,2.76,2.22),
                  srtingAsFactor = F)
fuel

# fuel데이터를 mpg 데이터에 price_fl(연료 가격)변수를 합쳐라.
mpg$fl
mpg_fuel = left_join(mpg, fuel, by = 'fl')
mpg_fuel

# 연료 가격 변수가 잘 추가되었는지 확인하기 위해서 model, fl, price_fl변수를 추출,
# 앞부분 5줄을 출력.
mpg_fuel_se = mpg_fuel %>%  select(model, fl, price_fl) %>%  # model, fl, price_fl 추출.
  head(5)
mpg_fuel_se

# --------------------------------------------------------------------------
# 데이터 정제.
# 빠진 데이터, 이상한 데이터 제거하기.

# 결측치.
# 누락되어 있는 값, 비어있는 값
# 함수 적용 불가, 분석 결과 왜곡
# 제거 후 분석 실시

# 결측치가 있는 데이터 생성.
# NA란
# 공간은 차지하나, 그 공간에 아무것도 존재하지 않는다라고 파악한다. 
# 아예 존재하지 않는다.
# 화이트 스페이스.
df = data.frame(sex = c('M', 'F', NA, 'M', 'F'),
                score = c(5,4,3,4,NA))
df

# 결측치 확인하기.
is.na(df) # 결측치 확인. 행 하나마다 NA가 있는지 확인해 주는 함수.

table(is.na(df)) # 결측치 빈도 출력.

table(is.na(df$sex)) 
table(is.na(df$score)) 

# 결측치 포함된 상태로 분석.
# 결측치가 포함되어 있으면 우선순위로 인해 NA값이 나온다.
# 고로 결측치의 처리가 필요.
mean(df$score)
sum(df$score)

# 결측치 제거.

# 결측치 있는 행 제거.
df %>% filter(is.na(score)) # score가 NA민 데이터만 출력.

df %>% filter(!is.na(score)) # score 결측치 제거.

# 결측치 제외한 데이터로 분석하기.
df_nomiss = df %>%  filter(!is.na(score))
mean(df_nomiss$score)
sum(df_nomiss$score)

df_nomiss= df %>% filter(!is.na(sex))
df_nomiss

# score, sex 결측치 제외.
df_nomiss = df %>% filter(!is.na(sex) & !is.na(score))
df_nomiss

# 결측치가 하나라도 있으면 제거.
# 분석에 필요한 데이터까지 손실 위험이 있음.
df_nomiss2 = na.omit(df) # 모든 변수에 결측치 없는 데이터 출력.
df_nomiss2

# 함수의 결측치 제외 기능 이용하기.
mean(df$score, na.rm = T) # 결측치 제외하고 평균 산출.

sum(df$score, na.rm = T) # 결측치 제외하고 합계 산출.

# 결측치 생성.
exam = read.csv("./Data/csv_exam.csv")
exam[c(3,8,15), 'math'] = NA # 3,8,15행의 math에 NA 할당.
exam

# 평균 구하기.
exam %>% summarise(mean_math = mean(math)) # 평균 산출.

exam %>% summarise(mean_math = mean(math, na.rm = T)) # 결측치를 제외하고 평균 산출.

# 결측치 대체하기.
# 결측치 많을 경우 모두 제외하면 데이터 손실이 큼
# 대안: 다른 값 채워 넣기
# 일반적으로 평균으로 채워 넣는다.

# 평균으로 재체하기.
exam$math = ifelse(is.na(exam$math), 55, exam$math) # math가 NA이면 55로 대체.
table(is.na(exam$math))
exam

# ------------------------------------------------------------------------------
mpg = as.data.frame(ggplot2::mpg)
mpg[c(65,124,131,153,212), "hwy"] = NA # 이런 방식으로 결측치를 다른 값으로 대체할 수 있다. 
mpg$hwy # NA 할당하기.

# drv(구동방식)별로 hwy(고속도로 연비)평균이 어떻게 다른지 알아보려고 한다.
# 두 변수의 결측치 유무 확인.
table(is.na(mpg$drv))
table(is.na(mpg$hwy))

# filter()를 이용해 hwy변수의 결측치를 제외하고, 어떤 구동방식의 hwy 평균이 높은지 알아보라.
# 하나의 dplyr로 만들기.
mpg %>% filter(!is.na(hwy)) %>%  # 결측치 제거.
  group_by(drv) %>%  # drv별 분리
  summarise(mean_hwy = mean(hwy)) # hwy 평균 구하기.

# 이상치 정제하기.
# 이상치란
# 이상치 포함시 분석 결과 왜곡.
# 결측 처리 후 제외하고 분석.
# 정상범주를 벗어나는 데이터.

# 이상치 포함한 데이터 생성.(sex 3, score 6)
outliner = data.frame(sex = c(1,2,1,3,2,1),
                      score = c(5,4,3,4,2,6))
outliner

table(outliner$sex)
table(outliner$score)

# sex가 3이면 NA 할당.
outliner$sex = ifelse(outliner$sex == 3, NA, outliner$sex)
outliner

# score가 1 ~ 5가 아니면 NA 할당.
outliner$score= ifelse(outliner$score > 5, NA, outliner$score)
outliner

# 결측치를 제외하고 분석.
outliner %>% 
  filter(!is.na(sex) & !is.na(score)) %>% 
  group_by(sex) %>% 
  summarise(mean_score = mean(score))

# 이상치 제거하기.
# 극단적인 값.

# 상자그림으로 극단치 기준 정해서 제거하기
# 상자그림 생성.
mpg = as.data.frame(ggplot2::mpg)
boxplot(mpg$hwy)
boxplot(mpg$hwy)$stats # 상자그림 통계치 출력. 최상단과 최하위단의 값을 알 수 있다.

# 12 ~ 37 벗어나면 NA 할당.
# 이상치를 바로 바꾸는 것 보다 NA로 할당하고 바꾸는 것이 쉽다.
mpg$hwy = ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)
table(is.na(mpg$hwy))

# 결측치 제외하고 분석하기.
mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy, na.rm = T))

# -----------------------------------------------------------------------
mpg = as.data.frame(ggplot2::mpg) # mpg 데이터 불러오기.
mpg[c(10,14,58,93), 'drv'] = 'k' # drv 이상치 할당.
mpg[c(29,43,129,203), 'cty'] = c(3,4,39,42) # cty 이상치 할당.
mpg$drv
mpg$cty

# drv에 이상치가 있는지 확인.
# 이상치를 결측 처리한 다음 이상치가 사려졌는지 확인. 
# 결측을 처리할때 %in% 기호를 활용.
unique(mpg$drv)
table(mpg$drv)
mpg$drv = ifelse(mpg$drv %in% c(4,'f','r'), mpg$drv, NA)
table(mpg$drv)

# 상자그림을 활용하여 cty에 이상치가 있는지 확인.
# 결측 처리 후 상자그림으로 이상치가 사라졌는지 확인.
boxplot(mpg$cty)$stats
mpg$cty = ifelse(mpg$cty < 9 | mpg$cty > 26, NA, mpg$cty)
boxplot(mpg$cty)

# 밑에는 이상치 데이터를 평균으로 만든 것.
mpg %>% summarise(mean_cty = mean(cty, na.rm = T))
mpg$cty = ifelse(is.na(mpg$cty), 16, mpg$cty)
boxplot(mpg$cty)

# 이상치를 제외한 다음 drv별로 cty평균이 어떻게 다른지 알아보세요.
# 하나의 dplyr구문으로 만들기

mpg %>% filter(!is.na(drv) &  !is.na(cty)) %>%  # 결측치 제외.
                 group_by(drv) %>% # drv별 분리.
                 summarise(mean_cty = mean(cty)) # cty 평균 구하기.







