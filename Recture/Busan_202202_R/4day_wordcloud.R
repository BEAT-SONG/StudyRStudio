# 대통령 취임사를 워드클라우드로 키워드 분석하기

# 경로 확인
getwd()
setwd("C:/Sources/StudyRStudio_/Recture/Busan_202202_R")

# 패키지 로드
library(wordcloud) # wordcloud 패키지
library(RColorBrewer) # 색상 목록을 불러오는 패키지
library(KoNLP) # 한글을 파악하기 위한 패키지
# dplyr 는 데이터 프레임을 처리하는 함수군으로 구성
# dplyr 패키지의 기본: filter(), select(), mutate(), arrange(), summarise()
library(dplyr) # 정확히는 모르겠는데 renamr()도 하기위한 패키지 +++

# 데이터 불러오기
# 제13대 대통령 취임사_노태우
txt_13 = readLines("./DAY4/13.txt", encoding='UTF-8')
txt_13

# 명사 추출하기
nouns_13 = extractNoun(txt_13)
nouns_13

# 추출한 명사 list를 문자열 벡터로 변환
wordcount_13 = table(unlist(nouns_13))
head(wordcount_13)

# 데이터 프레임으로 변환
# stringsAsFactors = F : 문자는 문자로 인식하게 할거야
word_13 = as.data.frame(wordcount_13, stringsAsFactors = F)

table(word_13)

# 변수명 지정
word_13 = rename(word_13,
                 word =Var1, # 컬럼명을 대문자(오른쪽)에서 소문자(왼쪽)으로 바꿈
                 freq =Freq)
head(word_13)

# 두 글자 이상 단어만 추출
word_13 = filter(word_13, nchar(word) >= 2)

head(word_13)

# 워드 클라우드는 거의 비슷해서 복사해서 사용  
# 단어 색상 목록 만들기
pal = brewer.pal(8, 'Dark2') # Dark2 라는 색상 목록에서 8개 색상 가져오기

# 워드 클라우드 생성
set.seed(1234) # 난수(무작위로 생성한 수) 고정
wordcloud(words = word_13$word, # 단어
          freq = word_13$freq, # 빈도
          min.freq = 2, #최소 단어 빈도
          max.words = 200, # 표현 단어 수
          random.order = F, # 고빈도 단어 중앙 배치, 랜덤하게 퍼져나갈 수 있게
          rot.per = .2, # 회전 단어 비율
          scale = c(4,0.2), # 단어 크기 범위
          colors = pal)# 색상 목록

# -------------------------------------------------------------------------
# 데이터 불러오기
# 제14 대통령 취임사_김영삼
txt_14 = readLines("./DAY4/14.txt", encoding='UTF-8')
txt_14

# 명사 추출하기
nouns_14 = extractNoun(txt_14)
nouns_14

# 추출한 명사 list를 문자열 벡터로 변환
wordcount_14 = table(unlist(nouns_14))
head(wordcount_14)

# 데이터 프레임으로 변환
# stringsAsFactors = F : 문자는 문자로 인식하게 할거야
word_14 = as.data.frame(wordcount_14, stringsAsFactors = F)

table(word_14)

# 변수명 지정
word_14 = rename(word_14,
                 word =Var1, # 컬럼명을 대문자(오른쪽)에서 소문자(왼쪽)으로 바꿈
                 freq =Freq)
head(word_14)

# 두 글자 이상 단어만 추출
word_14 = filter(word_14, nchar(word) >= 2)

head(word_14)

# 워드 클라우드는 거의 비슷해서 복사해서 사용  
# 단어 색상 목록 만들기
pal = brewer.pal(8, 'Dark2') # Dark2 라는 색상 목록에서 8개 색상 가져오기

# 워드 클라우드 생성
set.seed(1234) # 난수(무작위로 생성한 수) 고정
wordcloud(words = word_14$word, # 단어
          freq = word_14$freq, # 빈도
          min.freq = 2, #최소 단어 빈도
          max.words = 200, # 표현 단어 수
          random.order = F, # 고빈도 단어 중앙 배치, 랜덤하게 퍼져나갈 수 있게
          rot.per = .2, # 회전 단어 비율
          scale = c(4,0.2), # 단어 크기 범위
          colors = pal)# 색상 목록

# -------------------------------------------------------------------------
# 데이터 불러오기
# 제15 대통령 취임사_김대중
txt_15 = readLines("./DAY4/15.txt", encoding='UTF-8')
txt_15

# 명사 추출하기
nouns_15 = extractNoun(txt_15)
nouns_15

# 추출한 명사 list를 문자열 벡터로 변환
wordcount_15 = table(unlist(nouns_15))
head(wordcount_15)

# 데이터 프레임으로 변환
# stringsAsFactors = F : 문자는 문자로 인식하게 할거야
word_15 = as.data.frame(wordcount_15, stringsAsFactors = F)

table(word_15)

# 변수명 지정
word_15 = rename(word_15,
                 word =Var1, # 컬럼명을 대문자(오른쪽)에서 소문자(왼쪽)으로 바꿈
                 freq =Freq)
head(word_15)

# 두 글자 이상 단어만 추출
word_15 = filter(word_15, nchar(word) >= 2)

head(word_15)

# 워드 클라우드는 거의 비슷해서 복사해서 사용  
# 단어 색상 목록 만들기
pal = brewer.pal(8, 'Dark2') # Dark2 라는 색상 목록에서 8개 색상 가져오기

# 워드 클라우드 생성
set.seed(1234) # 난수(무작위로 생성한 수) 고정
wordcloud(words = word_15$word, # 단어
          freq = word_15$freq, # 빈도
          min.freq = 2, #최소 단어 빈도
          max.words = 200, # 표현 단어 수
          random.order = F, # 고빈도 단어 중앙 배치, 랜덤하게 퍼져나갈 수 있게
          rot.per = .2, # 회전 단어 비율
          scale = c(4,0.2), # 단어 크기 범위
          colors = pal)# 색상 목록

# -------------------------------------------------------------------------
# 데이터 불러오기
# 제16 대 대통령 취임사_노무현
txt_16 = readLines("./DAY4/16.txt", encoding='UTF-8')
txt_16

# 명사 추출하기
nouns_16 = extractNoun(txt_16)
nouns_16

# 추출한 명사 list를 문자열 벡터로 변환
wordcount_16 = table(unlist(nouns_16))
head(wordcount_16)

# 데이터 프레임으로 변환
# stringsAsFactors = F : 문자는 문자로 인식하게 할거야
word_16 = as.data.frame(wordcount_16, stringsAsFactors = F)

table(word_16)

# 변수명 지정
word_16 = rename(word_16,
                 word =Var1, # 컬럼명을 대문자(오른쪽)에서 소문자(왼쪽)으로 바꿈
                 freq =Freq)
head(word_16)

# 두 글자 이상 단어만 추출
word_16 = filter(word_16, nchar(word) >= 2)

head(word_16)

# 워드 클라우드는 거의 비슷해서 복사해서 사용  
# 단어 색상 목록 만들기
pal = brewer.pal(8, 'Dark2') # Dark2 라는 색상 목록에서 8개 색상 가져오기

# 워드 클라우드 생성
set.seed(1234) # 난수(무작위로 생성한 수) 고정
wordcloud(words = word_16$word, # 단어
          freq = word_16$freq, # 빈도
          min.freq = 2, #최소 단어 빈도
          max.words = 200, # 표현 단어 수
          random.order = F, # 고빈도 단어 중앙 배치, 랜덤하게 퍼져나갈 수 있게
          rot.per = .1, # 회전 단어 비율
          scale = c(4,0.2), # 단어 크기 범위
          colors = pal)# 색상 목록
