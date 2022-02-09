# 덱스트 마이닝(Text mining)
# 문자로 된 데이터에서 가치 있는 정보를 얻어 내는 분석 기법
# 형태소 분석: 문장을 구성하는 어절등이 어떤 품사로 되어 있는지 분석
# 분석 절차: 형태소 분석 / 명사, 동사, 형용사 등 의마를 지닌 품사 단어 추출 
# / 빈도표 만들기 / 시각화
# 보통은 명사 찾기를 많이 함

install.packages('usethis')
usethis::edit_r_environ()
# 위를 실행하면 .Renviron*이라는 창이 생김
# 그 창에다가 아래의 주석 내용 입력
# PATH="${RTOOLS40_HOME}\usr\bin;${PATH}"
# 이 과정이 텍스트 마이닝을 하기 위한 과정
Sys.which("make")

# 위의 내용은 안정성을 위해 추가한 것인데 내 컴퓨터는 안된다.. pass!
# 운에 맞기자!

install.packages("rJava")
install.packages("remotes")
remotes::install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts=c("--no-multiarch"))

library(KoNLP)

text <- "R은 통계 계산과 그래픽을 위한 프로그래밍 언어이자 소프트웨어 환경이자 프리웨어이다.[2] 뉴질랜드 오클랜드 대학의 로버트 젠틀맨(Robert Gentleman)과 로스 이하카(Ross Ihaka)에 의해 시작되어 현재는 R 코어 팀이 개발하고 있다. R는 GPL 하에 배포되는 S 프로그래밍 언어의 구현으로 GNU S라고도 한다. R는 통계 소프트웨어 개발과 자료 분석에 널리 사용되고 있으며, 패키지 개발이 용이해 통계 소프트웨어 개발에 많이 쓰이고 있다."
extractNoun(text)

# 패키지 로드
library(KoNLP)
library(dplyr)

useNIADic() # 사전 # 만약에 updata할거냐라는 문자가 나오면 Esc로 나가면 됨됨

getwd()
setwd("C:/Sources/StudyRStudio_/Recture/Busan_202202_R")

txt = readLines("./Data/hiphop.txt", encoding='UTF-8')
txt









