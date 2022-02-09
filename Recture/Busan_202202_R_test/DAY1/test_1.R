# data frame 만들기
english = c(90,80,60,70)
english

math = c(50,60,100,20)
math

class = c(1,1,2,2)
class

df_midterm = data.frame(english, math, class)
df_midterm

mean(df_midterm$english)
mean(df_midterm$math) 

install.packages("readxl")
library(readxl)

# 접속하기
getwd()
setwd("C:/Sources/StudyR_Studio/Recture/Busan_202202_R/DAY1")
getwd()
setwd("C:/Sources/R/Recture/Busan_202202_R/DAY1")

# 엑셀 파일 불러와서 df_exam 할당.
df_exam = read_excel("./Data/excel_exam.xlsx")
df_exam
# 데이터의 형태가 '데이터 프레임'이므로 데이터 프레임으로 접급해야함.
mean(df_exam$english)
mean(df_exam$math)

df_exam_novar = read_excel("./Data/excel_exam_novar.xlsx",col_names=F)
df_exam_novar

#엑셀 파일의 세번째 시트에 있는 데이터 불러오기
df_exam_sheet = read_excel("./Data/excel_exam_sheet.xlsx",sheet=3)
df_exam_sheet

# 외부 데이터를 이용하여 데이터 프레임 만들기 -> csv 파일
df_csv_exam = read.csv("./Data/csv_exam.csv")
df_csv_exam


df_midterm = data.frame(english= c(90,80,60,70),
                        mat= c(50,60,100,20), 
                        class= c(1,1,2,2))
df_midterm

# 데이터 프레임 CSV 파일로 저장하기
write.csv(df_midterm, file="./Data/df_midterm.csv")

# 데이터를 확인할 수 있는 함수
# head(), tail(), dim()[몇행 몇열인가], View(), str(), summary()[기초통계]







