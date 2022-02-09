# 그래프 만들기.
# 산점도, 막대그래프(hist), 상자그림(boxplot), 곡선 그래프
# R로 만들수 있는 그래프.
# 2차원 그래프, 3차원 그래프
# 지도 그래프, 네트워크 그래프, 모션 차트, 인터랙티브 그래프

# 산점도(Scater Plot): 데이터를 x축과 y 축에 점으로 표현한 그래프
# geom_point()

getwd()
library(ggplot2)

# 배경 설정하기.
# x축, y축 설정하기.
# 데이터, 축
ggplot(data = mpg, aes(x = displ, y=hwy))

# 배경에 산점도 추가.
# 방향이나 패턴이 보이지 않으면 연관성이 없는 데이터라고 생각하면 된다.
# 떨어져 있는 데이터를 확인해야한다.
# 그래프 종류
ggplot(data = mpg, aes(x = displ, y=hwy)) + geom_point()

# x축 범위 3 ~ 6으로 지정
ggplot(data = mpg, aes(x = displ, y=hwy)) + geom_point() + xlim(3,6)

# 축 범위 지정
# 세부설정 
ggplot(data = mpg, aes(x = displ, y=hwy)) + 
  geom_point() + 
  xlim(3,6) +
  ylim(10,30)
 
# qplot(): 전처리 단계에서 데이터 확인용. 문법 간단, 기능 단순.
# ggplot(): 최종 보고용. 색, 크기,폰트 등 세부 조작 가능.
# 굳이 구분 짓기보다는 적절하게 상황에 맞춰서 쓰면 된다.

# ---------------------------------------------------------------
mpg = as.data.frame(ggplot2::mpg)

# cty(도시연비)와 hwy(고속도로 연비)간에 어떤 관계가 있는지 알아보려고 한다.
# x축은 cty, y축은 hwy로된 산점도를 만들어 보라.
ggplot(data=mpg, aes(x=cty, y=hwy)) +
  geom_point()

# midwest에서 전체인구와 아시아인 인구 간에 어떤 관계가 있는지 알아보려고 한다. 
# x축은 poptotal(전체인구), y축은 popasian(아시아인 인구)으로 된 산점도 출력.
# 전체 인구는 50만명 이하, 아시아인 인수는 1만명 이하인 지역만 산점도에 표시하라.
summary(midwest)
midwest$poptotal

ggplot(data=midwest, aes(x=poptotal, y=popasian)) +
  geom_point() +
  xlim(0, 500000) +
  ylim(0, 10000)

# 막대 그래프 - 집단 간 차이 표현하기.
# geom_col()
# geom_bar()

# 막대 그래프(Bar Chart): 데이터의 크기를 막대의 길이로 표현한 그래프.
# 주로 성별 소득 차이처럼 '집단 간 차이'를 표현할 때 주로 사용.

library(dplyr)

# 구동방식별 고속도로 평균연비 데이터.
df_mpg = mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy))

df_mpg

# 그래프 생성.
ggplot(data = df_mpg, aes(x = drv, y = mean_hwy)) + geom_col()

# 크기 순으로 정렬하기.
# reorder(,)
ggplot(data = df_mpg, aes(x = reorder(drv, -mean_hwy), y = mean_hwy)) + 
  geom_col()

# x축 범주 변수, y축 빈도.
ggplot(data = mpg, aes(x = drv)) + geom_bar()

ggplot(data = mpg, aes(x = hwy)) + geom_bar()

# ------------------------------------------------------------------
# 어떤 회사에서 생산한 suv 차종의 도시 연비가 높은지 알아보려고 한다.
# suv 차종을 대상으로 평균 cty(도시 연비)가 가장 높은 회사 5곳을 막대 그래프로 표현하라.
# 막대는 연비가 높은 순으로 정렬.
# 평균 표 생성.
mpg_new=mpg %>% filter(mpg$class == 'suv') %>% 
  group_by(manufacturer) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  arrange(desc(mean_cty)) %>% 
  head(5)

mpg_new

# 그래프 생성.
ggplot(data = mpg_new, aes(x=reorder(manufacturer, -mean_cty), y=mean_cty)) + 
  geom_col()

# 자동차 중에서 어떤 class(자동차 종류)가 가장 많은지 알아보려고 한다.
# 자동차 종류별 빈도를 표현한 막대 그래프를 그려라.
ggplot(data=mpg, aes(x = class)) + geom_bar()


# 선그래프 - 시간에 따라 달라지는 데이터 표현하기.
# 선 그래프(Line Chart) : 일정 시간 간격을 두고 나열된 시계열 데이터를
# 선으로 표현한 그래프.
# 환율, 주가지수 등 경제 지표가 시간에 따라 어떻게 변하는지 표현할 때 활용.
# geom_line()
library(dplyr)
library(ggplot2)

head(economics)
ggplot(data = economics, aes(x = date, y = unemploy)) + geom_line()

# -----------------------------------------------------------------------------
# 시간에 따른 개인 저축률의 변화를 나타낸 시계열 그래프를 만들어라.
# 이런 그래프에서 급상승/급하강의 시점을 확인해보는 것이 주 목표이다.
ggplot(data = economics, aes(x= date, y= psavert)) + geom_line()

# 상자그림 - 집단 간 분포 차이를 표현하기.
# 구동방법별 고속도로 연비.
# 기준이 되는 것은 중앙값 = 박스에 검은 줄.
ggplot(data= mpg, aes(x=drv, y=hwy)) + geom_boxplot()

# -----------------------------------------------------------------------------
# class(자동차 종류)가 compact, subcompact, suv인 자동차의 cty(도시연비)가 어떻게
# 다른지 비교해 보려고 한다. 세 종의 cty를 상자 그림으로 만들어라.
# 일반적으로는 상자그림을 먼저해서 이상치를 확인한다.
unique(mpg$class)

class_mpg = mpg %>%  filter(class %in% c("compact", "subcompact", "suv"))

ggplot(data = class_mpg, aes(x=class, y= cty)) + geom_boxplot()



