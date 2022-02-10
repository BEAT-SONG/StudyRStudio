# 텍스트 마이닝(Text mining)
# 문자로 된 데이터에서 가치 있는 정보를 얻어 내는 분석 기법
# 형태소 분석: 문장을 구성하는 어절등이 어떤 품사로 되어 있는지 분석
# 분석 절차: 형태소 분석 / 명사, 동사, 형용사 등 의마를 지닌 품사 단어 추출 
# / 빈도표 만들기 / 시각화
# 보통은 명사 찾기를 많이 함
# 고로 키워드의 분포 및 빈도를 확인하는데 주로 사용
# KoNLP = 텍스트 마이닝을 하기 위한 자바 해석기
# KoNLP를 JAVA에서 만듬
# 환경 설정 = 1차 방어선

install.packages('usethis')
usethis::edit_r_environ() # R Tools와 JAVA의 환경설정을 연결해주는 함수
# 위를 실행하면 .Renviron*이라는 창이 생김
# 그 창에다가 아래의 주석 내용 입력
# PATH="${RTOOLS40_HOME}\usr\bin;${PATH}"
# 이 과정이 텍스트 마이닝을 하기 위한 과정
Sys.which("make")

# 위의 내용은 안정성을 위해 추가한 것인데 내 컴퓨터는 안된다.. pass!
# 운에 맞기자!
# 위의 내용 = 2차 방어선

install.packages("rJava") # JAVA 라이브러리를 R에서 실행하기 위한 패키지
install.packages("remotes") # 원격을 위한 패키지
remotes::install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts=c("--no-multiarch"))
# 위의 내용은 원격으로 가져오는 것을 포함하는 함수

library(KoNLP)

text <- "R은 통계 계산과 그래픽을 위한 프로그래밍 언어이자 소프트웨어 환경이자 프리웨어이다.[2] 뉴질랜드 오클랜드 대학의 로버트 젠틀맨(Robert Gentleman)과 로스 이하카(Ross Ihaka)에 의해 시작되어 현재는 R 코어 팀이 개발하고 있다. R는 GPL 하에 배포되는 S 프로그래밍 언어의 구현으로 GNU S라고도 한다. R는 통계 소프트웨어 개발과 자료 분석에 널리 사용되고 있으며, 패키지 개발이 용이해 통계 소프트웨어 개발에 많이 쓰이고 있다."
extractNoun(text)

# 패키지 로드
library(KoNLP)
library(dplyr)

# 사전 설정하기
useNIADic() # 사전 # 만약에 updata할거냐라는 문자가 나오면 Esc로 나가면 됨
# 사전에 형태소를 분석할 수 있는 규칙들이 들어 있음

# 경로 설정! DEV에 설치한 경우 경로를 확인하고 변경해주는 것이 필요!
getwd()
setwd("C:/Sources/StudyRStudio_/Recture/Busan_202202_R")

# 데이터 불러오기
txt = readLines("./Data/hiphop.txt", encoding='UTF-8')

txt %>% head(5)

# 특수문자 제거
install.packages('stringr')
library(stringr)

# 특수문자 제거
txt = str_replace_all(txt, '//W', ' ') # /W : 정규표현. 특수문자를 제외한 모든 워드(한글, 영어, 숫자)를 의미 
# //W : 한글, 영문, 숫자 제외한 나머지를 찾을 때 사용 = 특수문자
# 위의 함수는 한글, 영문, 숫자 제외한 나머지를 공백으로 바꾸겠다는 의미
# 출력할때 ""를 붙여서 출력해줌
txt
txt %>% head(5)

# 명사 추출하기
extractNoun("대한민국의 영토는 한반도와 그 부속도시로 한다")

# 가사에서 명사 추출
nouns = extractNoun(txt)

# 추출한 명사 list를 문자열 백터로 변환, 단어별 빈도표 생성
# 리스트를 벡터로 바꿈으로써 크기를 가져서 개수(빈도)를 확인하기 위해 벡터로 바꿈
 
wordcount <- table(unlist(nouns))

head(wordcount)

# 데이터 프레임으로 변환
# stringsAsFactors = F : 문자는 문자로 인식하게 할거야
df_word = as.data.frame(wordcount, stringsAsFactors = F)

head(df_word)

# 변수명 지정
df_word = rename(df_word,
                 word =Var1, # 컬럼명을 대문자(오른쪽)에서 소문자(왼쪽)으로 바꿈
                 freq =Freq)
head(df_word)

# 두 글자 이상 단어 추출
df_word = filter(df_word, nchar(word) >= 2)

head(df_word)
tail(df_word, 20)

top_20 = df_word %>% 
  arrange(desc(freq)) %>% 
  head(20)

top_20











