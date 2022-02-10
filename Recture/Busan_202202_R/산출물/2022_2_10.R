# 지도 시각화
# 패키지 설치하기
install.packages('ggiraphExtra')
library(ggiraphExtra)

# 미국 주별 범죄 데이터 준비하기
str(USArrests) # num: 실수, int: 정수
# 50 obs. of  4 variables: 50개의 열, 4개의 행(칼럼)
head(USArrests)

library(tibble)

# 행 이름을 state 변수로 바꾸어 데이터 프레임 생성
# 인덱스도 추가
# 이거는 꼭 외우기!
crime = rownames_to_column(USArrests, var = 'state')
crime

# 지도 데이터와 동일하게 맞추기 위해 state의 값을 소문자로 수정
crime$state = tolower(crime$state)
crime

str(crime)

# 미국 주 지도 데이터 준비하기
library(ggplot2)
states_map = map_data('state')
str(states_map) # long, lat : 위도, 경도

# 단계 구분도 만들기
ggChoropleth(data = crime, # 지도에 표현할 데이터
             aes(fill = Murder, # 색생으로 표현할 변수, 빈도가 높을수록 진하게 표현
                 map_id = state), # 지역 기준 변수, 지도의 위치 기준!
             map = states_map) # 지도 데이터

# 인터랙티브 단계 구분도 만들기
# interactive = T 를 추가
# 위보다 더 새련되게 그려지는 함수
ggChoropleth(data = crime, # 지도에 표현할 데이터
             aes(fill = Murder, # 색생으로 표현할 변수, 빈도가 높을수록 진하게 표현
                 map_id = state), # 지역 기준 변수, 지도의 위치 기준!
             map = states_map, # 지도 데이터
             interactive = T) # 인터랙티브 

# ---------------------------------------------------------------
# 대한민국 시도별 인구, 결핵 환자 수 단계 구분도 만들기
# 대한민국 시도별 인구 단계 구분도 만들기
# Kormaps2014 패키지를 이용하는 데 필요한 stringi 패키지를 설치.

install.packages("stringi")

# devtools 패키지를 설치한 후 install_github()를 이용해 패키지 개발자가 깃허브에 공유한 kormaps2014 패키지를 설치하고 로드하겠다.
install.packages("devtools")
devtools::install_github("cardiomoon/kormaps2014") # 대한민국 지도 데이터

library(kormaps2014)

# 대한민국 시도별 데이터 준비하기
# kormaps2014 는 UTF-8로 만들어져 있어 그대로 사용하면 깨짐..
# changeCode() 함수는 인코딩을 cp949로 변환해 주어야 함!
str(changeCode(korpop1)) # 17 obs. of  25 variables: 17개 열, 25개 행

library(dplyr)
korpop1 = rename(korpop1,
                 pop = 총인구_명,
                 name = 행정구역별_읍면동)
str(changeCode(korpop1))

# 지도로 표현해야하는 경우에는 
# 주소나 위도&경도등 위치를 나타낼 수 있는 데이터가 있는지 
# 확인해야함 
str(changeCode(kormap1))

#단계 구분도 만들기
library(ggiraphExtra) # 지도 데이터를 만들어주는 library
ggChoropleth(data = korpop1, # 지도에 표현할 데이터
             aes(fill = pop, # 색생으로 표현할 변수, 빈도가 높을수록 진하게 표현
                 map_id = code, # 지역 기준 변수, 지도의 위치 기준!
                 tooltip = name), # 지도 위에 표시할 지역명
             map = kormap1, # 지도 데이터
             interactive = T) # 인터랙티브 

# 대한민국 시도별 결핵 환자 수 단계 구분도 만들기
str(changeCode(tbc))

ggChoropleth(data= tbc, # 지도에 표현할 데이터
             aes(fill = NewPts, # 색상으로 표현할 변수
                 map_id = code, # 지역 기준 변수
                 tooltip = name), # 지도 위에 표시할 지역명
             map = kormap1, # 지도 데이터
             interactive = T) # 인터랙티브

# 대한민국 시도별 결핵 환자 수 단계 구분도 만들기
# 데이터 검수
dim(korpop1)
summary(korpop1)
str(changeCode(korpop1))
str(changeCode(tbc))

# 1. 대한민국 시도별 성별비율
# 변수 검토하기
# 변수명 변경
korpop1 = rename(korpop1,
                 male = 남자_명,
                 female = 여자_명)

# 성별 변수 검토 및 전처리
class(korpop1$male)
class(korpop1$female)

# 이상치 유무를 확인 할수 있음
table(korpop1$male)
table(korpop1$female)

# 이상치 확인
# korpop1$male, korpop1$female에 0이 있다면 NA(결측치)로 바꾼다.
korpop1$male = ifelse(korpop1$male == 0, NA, korpop1$male)
table(korpop1$male)

korpop1$female = ifelse(korpop1$female == 0, NA, korpop1$female)
table(korpop1$female)

# 결측치 확인
table(is.na(korpop1$male)) # FALSE 면 결측치(NA)가 없음
table(is.na(korpop1$female))

# 대한민국 시도별 여자 비율
library(dplyr)
korpop1_sex_female = korpop1 %>% 
  select(female, name, code) %>% 
  mutate(total_female = sum(female)) %>% 
  mutate(pct = round(female/total_female*100,1))

changeCode(korpop1_sex_female)

# 대한민국 시도별 여자 비율 그래프 그리기
library(ggplot2)
ggplot(data = changeCode(korpop1_sex_female), aes(x=name, y=pct)) +
  geom_col() +
  coord_flip()

# 대한민국 시도별 남자 비율
library(dplyr)
korpop1_sex_male = korpop1 %>% 
  select(male, name, code)%>% 
  mutate(total_male = sum(male)) %>% 
  mutate(pct = round(male/total_male*100,1))

changeCode(korpop1_sex_male)

# 대한민국 시도별 남자 비율 그래프 그리기
library(ggplot2)
ggplot(data = changeCode(korpop1_sex_male), aes(x=name, y=pct)) +
  geom_col()+
  coord_flip()

# 대한민국 시도별 여자 비율 지도 그래프 그리기
ggChoropleth(data = korpop1_sex_female, #지도에 표현할 데이터
             aes(fill = pct, #색상으로 표현할 변수
                 map_id = code, #지역 기준 변수
                 tooltip = name), #지역 위에 표시할 지역
             map = kormap1, #지도 데이터
             interactive = T) #인터랙티브

# 대한민국 시도별 남자 비율 지도 그래프 그리기
ggChoropleth(data = korpop1_sex_male, #지도에 표현할 데이터
             aes(fill = pct, #색상으로 표현할 변수
                 map_id = code, #지역 기준 변수
                 tooltip = name), #지역 위에 표시할 지역
             map = kormap1, #지도 데이터
             interactive = T) #인터랙티브

# 대한민국 시도별 여자, 남자 비율 막대그래프로 동시에 그리기
# 대한민국 시도별 여자, 남자수를 각 데이터로 분류
str(changeCode(korpop1))
male = korpop1 %>% 
  select(code, male) %>% 
  mutate(sex = 1) %>% 
  mutate(count = male/1) %>% 
  select(code, count, sex)

str(male)
head(male)

female = korpop1 %>% 
  select(code, female)%>% 
  mutate(sex = 2) %>% 
  mutate(count = female/1) %>% 
  select(code, count, sex)

changeCode(female)
str(female)

# code를 기준으로 밑으로 붙이기, 행결합
sex_new = rbind(female, male)
sex_new

# 대한민국 시도별 남여 성비


# 연령대 및 성별 월급 평균표 만들기
sex_income = welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg, sex) %>%  
  # 그룹을 2개를 기준으로 잡았으므로 그래프를 그릴때 fill이라는 것을 활용해서 
  # 다양한 그래프를 그릴 수 있음
  summarise(mean_income = mean(income))
