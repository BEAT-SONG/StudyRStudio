# 인터랙티브 그래프
# 패키지 준비하기
install.packages('ployly')
library(plotly)

# ggplot으로 그래프 그리기
library(ggplot2)
p = ggplot(data = mpg, aes(x= displ, y= hwy, col= drv)) +
  geom_point()
p

# 인터랙티브 그래프 만들기
ggplotly(p)

# 인터랙티브 막대 그래프 만들기
# fill= : 색상을 입히는 함수
p = ggplot(data= diamonds, aes(x= cut, fill= clarity)) +
  geom_bar(position = 'dodge')

p

ggplotly(p)

# 인터랙티브 시계열 그래프 만들기
# 패키지 준비하기
install.packages('dygraphs')
library(dygraphs)

# 데이터 준비하기
economics = ggplot2::economics
head(economics)

# 시간 순서 속성을 지니는 xts 데이터 타입으로 변경
# 데이터가 연월일 순서로 배열되어야 함
library(xts)
eco = xts(economics$unemploy, order.by = economics$date)
head(eco)

# 그래프 생성
dygraph(eco)

# 날짜 번위 선택 기능
dygraph(eco) %>% dyRangeSelector()

# 여러 값 표현하기
# 저축률
eco_a = xts(economics$psavert, order.by = economics$date)

# 실업자 수
eco_b = xts(economics$unemploy/1000, order.by = economics$date)

# 합치기
eco2 = cbind(eco_a, eco_b) # 데이터 결합
colnames(eco2) = c('pasavert', 'unemploy') # 변수명 바꾸기
head(eco2)

# 그래프 만들기
dygraph(eco2) %>% dyRangeSelector()






