install.packages("foreign")
library(foreign)
library(dplyr)
library(ggplot2)
library(readxl)

# 데이터 불러오기
getwd()
setwd("C:/Sources/StudyRStudio_/Recture/Busan_202202_R/")

# read.() 함수는 데이터 프레임으로 읽어오는 것
raw_welfare <- read.spss(file = "./Data/Koweps_hpc10_2015_beta1.sav", to.data.frame = T)

#복사본만들기 
welfare <- raw_welfare
welfare

# 데이터 검토
head(welfare)
tail(welfare)
View(welfare) # View()는 데이터가 너무 많을 경우 시간이 많이 걸리므로 사용에 유의
dim(welfare) # dim()을 통해 확인
str(welfare)
summary(welfare)

# 변수면 바꾸기
# 무조건 해야하는 것. 오른쪽의 값을 왼쪽 값으로 지정하는 것
welfare = rename(welfare,
                 sex = h10_g3, # 성별
                 birth = h10_g4, # 태어난 연도
                 marrtage = h10_g10, # 혼인 상태
                 religion = h10_g11, # 종교
                 income = p1002_8aq1, # 월급
                 code_job = h10_eco9, # 직장 코드
                 code_region = h10_reg7) # 지역 코드

summary(welfare)

welfare$sex

# 데이터 분석 절차
# 1단계: 변수 검토 및 전처리
# 데이터의 손실에 유의해서 전처리 = 분석 대상들만 선택해서 전처리
# 원본은 건들이지 않기
# 2단계: 변수 간 관계 분석
# 요약본 만들기, 시각화

# -----------------------------------------------------------------------------
# 성별에 따른 월급 차이
# 변수 검토하기
# 변수의 타입과 데이터의 타입은 다르다
# 변수와 컬럼은 다르다
# a = 10 # 일반 변수

# 성별 변수 검토 및 전처리
class(welfare$sex) # 숫자값을 가짐

# 이상치 유무를 확인 할수 있음
table(welfare$sex) # 숫자 1,2로 구성. 일반적으로 1(홀수)은 남자, 2(짝수)는 여자


# 이상치 확인
# welfara$sex에 9가 있다면 NA(결측치)로 바꾼다.
welfare$sex = ifelse(welfare$sex == 9, NA, welfare$sex)

# 결측치 확인
# 결측치가 있으면 TURE
table(is.na(welfare$sex))

# 성별 항목에 이름 부여
welfare$sex = ifelse(welfare$sex == 1, "male", "female")
table(welfare$sex)

# 빈도 확인
# 현황 확인
qplot(welfare$sex)

# 월급 변수 검토 및 전처리
# 변수 검하기
class(welfare$income) # 숫자 데이터

summary(welfare$income)

boxplot(welfare$income)
qplot(welfare$income)

# 범위가 넓어서 비어 있는 것보다 꽉 차보이는게 낫다.
qplot(welfare$income) + xlim(0,1000) 

# 이상치(결측치) 확인
summary(welfare$income)

# 이상치 결측 처리
# c(0,9999)의미는 0, 9999를 의미하는 것이지 번위가 아니다.
welfare$income = ifelse(welfare$income %in% c(0,9999), NA, welfare$income)

# 결측치 확인
table(is.na(welfare$income))

# 성별에 따른 월급 차이 분석하기
# 성별 월급 평균표 만들기
sex_income = welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(sex) %>% 
  summarise(mean_income = mean(income))

sex_income

# 그래프 만들기
ggplot(data= sex_income, aes(x= sex, y= mean_income)) + geom_col()


# 나이와 월급의 관계

# 나이 변수 검토 및 전처리
# 변수 검토하기
class(welfare$birth)

qplot(welfare$birth)
table(welfare$birth)

# 이상치 확인
summary(welfare$birth)

# 결측치 확인
table(is.na(welfare$birth))

# 이상치 결측 처리
# 현재 데이터는 결측치가 없다.

# 파생변수 만들기 - 나이
# 기준 연도를 2015년으로 
welfare$age = 2015 - welfare$birth + 1
summary(welfare$age)

# 나이에 따른 월급 평균표 만들기
age_income = welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age) %>% 
  summarise(mean_income=mean(income))

head(age_income)

# 그래프 만들기
ggplot(data = age_income, aes(x= age, y=mean_income)) + geom_line()

# 연령대에 따른 월급 차이
# 연령대 변수 검토 및 전처리
# 파생변수 만들기 - 연령대
welfare = welfare %>% 
  mutate(ageg = ifelse(age < 30, 'young',
                       ifelse(age <= 59, 'middle', 'old')))
table(welfare$ageg)

qplot(welfare$ageg) # 이것을 통해 빈도(비율)를 확인
# 일반적으로 비율이 비슷한것으로 분석을 하는 것이 좋음
# 아니면 비율의 차이를 공시해주어야 함

# 연령대별 월급 평균표 만들기
ageg_income = welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg) %>% 
  summarise(mean_income = mean(income))

ageg_income # 이런것을 바탕으로 경제 상황이나 우리나라의 성장등을 예측 가능

# 그래프 만들기
# 데이터 시각화
ggplot(data=ageg_income, aes(x=ageg, y= mean_income)) + geom_col()

ggplot(data=ageg_income, aes(x=ageg, y= mean_income)) + 
  geom_col() +
  scale_x_discrete(limits = c('young','middle','old')) # 항목을 순서를 변경

# 연령대 및 성별 월급 차이
# 성별 월급 차이는 연령대별로 다를까?
# 연령대 및 성별 월급 평균표 만들기
sex_income = welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg, sex) %>%  
  # 그룹을 2개를 기준으로 잡았으므로 그래프를 그릴때 fill이라는 것을 활용해서 
  # 다양한 그래프를 그릴 수 있음
  summarise(mean_income = mean(income))

sex_income  

# 그래프 만들기
ggplot(data = sex_income, aes(x= ageg, y=mean_income, fill = sex)) +
  geom_col()+
  scale_x_discrete(limits = c('young','middle','old'))

# 성별 막대 분리
ggplot(data = sex_income, aes(x= ageg, y=mean_income, fill = sex)) +
  geom_col(position = 'dodge') +
  scale_x_discrete(limits = c('young','middle','old'))

# 나이 및 성별 월급 차이 분석
# 성별 연령별 원급 평균표 만들기
sex_age = welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age, sex) %>% 
  summarise(mean_income = mean(income))

head(sex_age)

# 그래프 만들기
# 나이별 평균 월급을 확인할 수 있음
ggplot(data = sex_age, aes(x= age, y= mean_income, col = sex)) + geom_line()


# 직업별 월급 차이
# 어떤 직업이 월급을 가장 많이 받을까?
# 변수 검토하기
class(welfare$code_job) # 숫자 데이터

table(welfare$code_job) # 코드명으로 주어지면 메타명이 있는지 확인해야 함

# 직업분류코드 목록 불러오기
library(readxl)
list_job = read_excel("./Data/Koweps_Codebook.xlsx", col_names = T, sheet = 2)
head(list_job)

# welfare에 직업명 결합
welfare = left_join(welfare, list_job, id="code_job")

welfare

welfare %>% 
  filter(!is.na(code_job)) %>% 
  select(code_job, job) %>% 
  head(10)

# 직업별 월급 평균 만들기
job_income = welfare %>% 
  filter(!is.na(job) & !is.na(income)) %>% 
  group_by(job) %>% 
  summarise(mean_income = mean(income))

job_income

# 상위 10개 출력
top10 = job_income %>% 
  arrange(desc(mean_income)) %>% 
  head(10)

top10

# 그래프 만들기
# 가독성이 좋게
ggplot(data = top10, aes(x= reorder(job, mean_income), y= mean_income)) +
  geom_col() +
  coord_flip() # 옆으로 그린 그래프

# 하위 10위 추출
bottom_10 = job_income %>% 
  arrange(mean_income) %>% 
  head(10)

bottom_10

# 그래프 만들기
ggplot(data = bottom_10, aes(x= reorder(job, mean_income), y= mean_income)) +
  geom_col() +
  coord_flip() +
  ylim(0,850)

# 성별 직업 빈도
# 성별로 어떤 직업이 가장 많을까?
# 성별 직업 빈도표 만들기
# 남성 직업 빈도 상위 10개 추출
job_male = welfare %>% 
  filter(!is.na(job) & sex == "male") %>% 
  group_by(job) %>% 
  summarise(n=n()) %>%  # 개수 = 빈도
  arrange(desc(n)) %>% 
  head(10)

job_male











