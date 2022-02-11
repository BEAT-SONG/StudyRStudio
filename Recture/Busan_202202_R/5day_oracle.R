# RJDBC 는 JAVA프로그램 방식으로 연결해주는 것..?
# 자바프로그램으로 오라클에 연결할 수 있는 패키지
install.packages('RJDBC')
library(RJDBC)

# 오라클 드라이버(통로) 연결 경로 설정
# 경로 확인
getwd()
setwd('C:/Sources/StudyRStudio_/Recture/Busan_202202_R')

driver = JDBC("oracle.jdbc.OracleDriver",
              classPath ='C:/Sources/StudyRStudio_/Recture/Busan_202202_R/ojdbc8.jar')
driver

# 오라클 접속하기
conn = dbConnect(driver,
                 "jdbc:oracle:thin:@//localhost:1521/orcl",
                 'scott', 'tiger')
conn

# <JDBCConnection> = 잘 연결 되었다는 것을 의미

conn = dbConnect(driver,
                 "jdbc:oracle:thin:@//localhost:1521/orcl",
                 'busan', 'dbdb')

conn

# 데이터를 입력해 보기
# paste(): 하나의 문장으로 합치는 함수(명령어)
spl_in = paste('Insert into test', 
               '(AA, BB, CC)',
               "values('al', 'bl', 'cl')")
spl_in

# dbSendQuery(): 데이터 베이스에 요청하는 함수(명령어)
# 접속됨
in_stat = dbSendQuery(conn, spl_in)
in_stat

# dbClearResult(): 접속은 된 상태이고 서버에게 일이 끊났다고 알려주는 함수(명령어)
# 서버에 과부하를 예방
dbClearResult(in_stat)

# 데이터 조건 조회하기
spl_sel = "Select*From test where AA = 'al'"
spl_sel

getData = dbGetQuery(conn, spl_sel)
getData





