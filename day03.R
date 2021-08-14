setwd("d:/2021_march_micro_yerimseo/R/r_data")
getwd()

# 작업용데이터 불러오기
# 파일이름 확인
list.files()

list.files(all.files = T)
list.files(recursive = T)

# scan() : 텍스트 파일을 읽어서 배열에 저장
sc1 = scan("scan_1.txt")
sc1

sc2 = scan("scan_2.txt", what = "")
sc2

sc3 = scan("scan_3.txt", what = "")
sc3

sc4 = scan("scan_4.txt", what = "")
sc4

inp = scan()
inp

inp2 = scan(what = "")
inp2

# readline() : 한줄 읽기
inp3 = readline()
inp3

inp4 = readline("R U ok? : ")
inp4

# readLines() : 파일을 읽어서 배열에 담기
inp5 = readLines("scan_4.txt")
inp5

# read.table() 통해서 데이터를 불러들여 데이터프레임에 담는다.
f = read.table("fruits.txt")
f

f = read.table("fruits.txt", header = T)
f

# 주석이나 공백을 제거
f2 = read.table("fruits_2.txt")
f2

f3 = read.table("fruits_2.txt", skip = 4, nrows = 3)
f3

f4 = read.table("fruits.txt", header = F, nrows = 2, skip = 2)
f4

# read.csv() : 구분자를 콤마로 구분하는 것
f5 = read.csv("fruits_3.csv")
f5

f6 = read.csv("fruits_4.csv", header = F) 
f6

# 라벨명 지정
lab = c('NO', 'NAME', 'PRICE', 'QTY')
f7 = read.csv("fruits_4.csv", header = F, col.names = lab) 
f7

# read.csv.sql() : 원하는 데이터를 sql 쿼리로 불러오기
install.packages("googleVis")
library(googleVis)

install.packages("sqldf")
library(sqldf)

Fruits

write.csv(Fruits, "f_sql.csv", quote = F, row.names = F)
f8 = read.csv.sql("f_sql.csv", sql = "select * from file where Year = 2008")
f8

# 엑셀파일로 부터 데이터프레임에 저장
install.packages("XLConnect")
library(XLConnect)

d1 = loadWorkbook("fruits_6.xls", create = T)
d2 = readWorksheet(d1, sheet = "sheet1",
                   startRow = 1,
                   endRow = 8,
                   startCol = 1,
                   endCol = 5)
d2

install.packages("readxl")
library(readxl)
d1 = read_excel("d:/2021_march_micro_yerimseo/R/r_data/전국_지역별_연도별_1인당_소득현황_2004년_2013년_가로.xlsx", sheet = 1, col_names = T, col_types = NULL, na = "", skip = 0)
d1
View(d1)


# 클립보드의 내용을 데이터프레임 생성
f9 = read.delim("clipboard", header = T)
f9

# read -> write
# read.table() -> write.table()
# read.csv() -> write.csv()
# readLines() -> write()

f
write.table(f, "f_1.txt")
f_1_1 = read.table("f_1.txt", header = T)
f_1_1

# 엑셀파일 저장
install.packages("xlsx")
library(xlsx)
names = c("Apple", "Banana", "Peach")
price = c(300, 200, 100)
item = data.frame(NAME = names, PRICE = price)
item
write.xlsx(item, "item.xlsx")


# readLines() / read.table() / read.csv()
t1 = read.csv("csv_test.txt")
t1

t2 = readLines("csv_test.txt")
t2

t3 = read.table("csv_test.txt")
t3

t4 = read.table("csv_test.txt", sep = ",", header = T) # read.table()은 헤더가 기본적으로 없다고 보기 때문
t4

t1 = readLines("write_test.txt")
t1
write(t1, "write_2.txt")


# 많이 사용되는 기본 함수들
# aggregate() : 다양한 함수를 사용해서 결과 출력
# apply() : 다양한 기능 제공
# cor() : 상관함수
# cumsum() : 설정된 지점까지의 누적합
# cumprom() : 설정된 지점까지의 누적곱
# diff() : 차이나는 부분을 찾음
# length() : 요소 갯수
# max() : 최대값
# min() : 최소값
# mean() : 평균
# median() : 중앙값
# order() : 각 요소의 위치
# prod() : 누적곱
# range() : 범위
# rank() : 순위
# rev() : 역순
# sd() : 표준편차
# sort() : 정렬
# sum() : 총합
# summary() : 요약통계
# sweep() : 일괄적 데이터 빼기
# tapply() : 벡터에서 주어진 함수연산 수행
# var() : 분산

v1 = c(1, 2, 3, 4, 5)
v2 = c('a', 'b', 'c', 'd', 'e')

max(v1)
max(v2)
mean(v1)
mean(v2)
min(v1)
min(v2)
sd(v1)
sum(v1)
var(v1)


# aggregate(계산될 컬럼~기준될 컬럼, 데이터, 함수) : 데이터프레임 상대로 주어진 함수 구하기
Fruits

# 년도별로 판매된 과일의 수량을 합계한 결과
aggregate(Sales~Year, Fruits, sum)

# 과일별로 판매된 과일의 수량을 합계한 결과
aggregate(Sales~Fruit, Fruits, sum)

aggregate(Sales~Fruit, Fruits, max)

# 과일별 최대 판매량에 년도를 추가해서 과일별 년도별 최대 판매량을 출력
aggregate(Sales~Fruit+Year, Fruits, max)

# apply(데이터, 행/열, 함수) : matrix 상대(행이나 열을 상대로 하기때문에 matrix에 유용하게 사용)
m1 = matrix(c(1, 2, 3,
              4, 5, 6), nrow = 2, by = T)
m1

apply(m1, 1, sum) # 각 행의 합계
apply(m1, 2, sum) # 각 열의 합계
# 2열과 3열의 최대값
apply(m1[, c(2, 3)], 2, max)

# lapply(데이터, 함수) / sapply(데이터, 함수) : list를 처리
l1 = list(Fruits$Sales)
l1

l2 = list(Fruits$Profit)
l2

lapply(c(l1, l2), max)
sapply(c(l1, l2), max)

# 데이터프레임에서 사용
lapply(Fruits[, c(4, 5)], max)
sapply(Fruits[, c(4, 5)], max)

# tapply(출력값, 기준컬럼, 함수) : 데이터셋의 특정요소(factor)를 처리
# mapply(함수, 벡터1, 벡터2, ...., 벡터n) : 벡터나 리스트를 데이터프레임처럼 처리

# 변수를 직접 사용하기 위한 함수 : attach()
attach(Fruits)
tapply(Sales, Fruit, sum)

# 만약 데이터프레임이 아닌 벡터나 리스트형태로 데이터들이 있을 때 마치 데이터프레임처럼 연산을 해주는 함수가 mapply(), 단, 벡터들의 요소개수가 동일해야 한다.

v1 = c(1, 2, 3, 4, 5)
v2 = c(10, 20, 30, 40, 50)
v3 = c(100, 200, 300, 400, 500)
mapply(sum, v1, v2, v3)

# [apply() 계열 함수 연습문제]
# 1-1. data1.csv파일을 d1변수에 불러오시오.
d1 = read.csv("data1.csv")
d1
# 1-2. 년도별 합계를 구하는 식
apply(d1[, c(2:15)], 2, sum)

# 1-3. 연령별 합계를 구하는 식
apply(d1[, c(2:15)], 1, sum)

# 2-1. "1-4호선승하차승객수.csv"파일 data2변수에 불러오시오.
data2 = read.csv("1-4호선승하차승객수.csv")
data2

# 2-2. 노선 번호별 승차 인원수 합계 
attach(data2)
tapply(승차, 노선번호, sum)

# 2-3. 노선 번호별 하차 인원수 합계
tapply(하차, 노선번호, sum)

# 2-4. 노선 번호 상관없이 승차 인원수 합계
sapply(data2[, c(3:4)], sum)

# 2-5. 노선 번호별 승하차 인원수 합계
aggregate(승차+하차~노선번호, data2, sum)

# 2-6. 노선 번호별 승차 인원수 합계
aggregate(승차~노선번호, data2, sum)

# 2-7. 노선 번호별 하차 인원수 합계
aggregate(하차~노선번호, data2, sum)

# 2-8. 노선 번호별 승차 최대 인원수
aggregate(승차~노선번호, data2, max)


# sweep() : 한꺼번에 차이를 구하기(여러 데이터들에 일괄적 기준 적용)
# 벡터, 매트릭스, 배열, 데이터프레임으로 구성된 여러 데이터들에 동일 기준을 적용시켜 차이나는 부분을 일목요연하게 보여주는 함수
m1

a = c(1, 1, 1)
sweep(m1, 2, a) # 행:2, 열:1로 표시함

# length() : 요소개수나 줄 수
a = c(1, 2, 3, 4, 5)
length(a)
Fruits
length(Fruits) # 데이터프레임에서는 라벨수를 출력

# 수학관련 함수
# abs() : 절대값
abs(1)
abs(-1)
v1 = c(1, -2, 3, -4)
abs(v1)

# ceiling() : 올림함수
v2 = c(1.2, 1.9, 2.1, -1.2, -1.9, -2.1)
ceiling(v2)

# choose() : 5C3 = 5*4*3/3*2*1
choose(5, 3)
choose(5, 1)
choose(5, 2)

# floor() : 버림함수(x보다 작은 수 중 가장 큰 정수)
# trunc() : 버림함수(0과 x사이에 가장 큰 정수)
floor(v2)
trunc(v2)

# sqrt()
sqrt(2)
sqrt(9)

# 사용자 정의 함수 : 함수를 직접 만들어서 사용
# 함수명 = function(인수 또는 입력값) {
#   식1
#   식2
#   return(반환값)
# }

# 입력값이 없는 경우
my1 = function() {
  return(10)
}

my1

my1()

# 입력값(인자)이 있는 경우
my2 = function(a) {
  b = a^2
  return(b)
}

my2(3)

my3 = function(a, b) {
  return(a*b)
}

my3(2, 3)


# 두개의 숫자를 입력받아서 곱한값이 무조건 양수로 출력
my4 = function(a, b) {
  return(abs(a*b))
}

my4(-2, 3)

# sort() : 정렬
s1 = Fruits$Sales
s1
sort(s1)

sort(s1, decreasing = T) # 내림차순 정렬렬

# plyr 패키지 : 아주 많이 사용, 원본데이터를 분석하기 쉬운 형태로 나누어서 다시 새로운 형태로 만들어주는 패키지
# apply()함수를 확장한 것
# ply()함수 앞에 2글자를 적어주는데, 첫 글자는 입력데이터 유형, 두 번째 글자는 출력 데이터 유형
# d : dataframe
# a : array(matrix 포함)
# l : list
# 
# ldply() - 입력데이터는 list, 출력데이터는 dataframe, daply() - 입력 데이터는 dataframe, 출력데이터는 array

install.packages("plyr")
library(plyr)
f = read.csv("fruits_10.csv", header = T)
f

# ddply(데이터, 기준컬럼, 함수)
# summarise : 기준컬럼의 데이터끼리 모은 후 함수를 적용해서 출력하라. sql에 group by와 비슷

# 과일의 이름을 기준으로 판매량 합계와 가격 합계를 구함
ddply(f, 'name', summarise, sum_qty = sum(qty), sum_price = sum(price))

# 동일한 과일끼리 모은 후 최대 판매량, 최저 가격을 출력
ddply(f, 'name', summarise, max_qty = max(qty), min_price = min(price))

# 년도별 이름별 최대 판매수량과 최저 가격을 출력
ddply(f, c('year', 'name'), summarise, max_qty = max(qty), min_price = min(price))

# 만약 동일한 컬럼이 아닌 각 행별로 연산을 수행해서 해당값을 함께 출력해야 하는 경우 transform을 사용
# pct_qty는 해당 과일의 판매수량이 기준 컬럼으로 합계한 총 판매개수 대비 몇 %를 차지하는지 계산
ddply(f, 'name', transform, sum_qty = sum(qty), pct_qty = round((100*qty)/sum(qty), 2))

# 주어진 데이터프레임에서 기준 컬럼으로 모은 후 계산해서 출력하고 싶을 경우 : summarise,
# 다른 계산을 해서 각각 행별로 출력하고 싶은 경우 : transform


# dplyr() 패키지
# [특징]
# 1. filter  : 필터링
# 2. select  : 여러 컬럼이 있는 데이터셋에서 특정 컬럼만 선택
# 3. arrange : 정렬
# 4. mutate  : 기존 변수를 활용해서 새로운 변수를 생성
# 5. summarise(with group_by) : 주어진 데이터를 집계(min, max, mean, count)

install.packages("dplyr")
library(dplyr)

d1 = read.csv("2013년_프로야구선수_성적.csv")
d1
View(d1)

# filter
# 경기수가 120경기 이상인 선수만 출력
d2 = filter(d1, 경기 >= 120)
d2

# 경기수가 120경기 이상이면서 득점도 80점 이상인 선수만 출력
d3 = filter(d1, 경기 >= 120 & 득점 >= 80)
d3

# 포지션이 1루수와 3루수인 선수만 출력
d4 = filter(d1, 포지션 == '1루수' | 포지션 == '3루수')
d4

d5 = filter(d1, 포지션 %in% c("1루수", "3루수"))
d5

# select
# 선수명, 포지션, 팀 컬럼만 조회
select(d1, 선수명, 포지션, 팀)

# 순위~타수 컬럼까지 출력
select(d1, 순위:타수)

# 특정 컬럼만 제외하고 출력
select(d1, -홈런, -타점, -도루)

# 여러문장을 조합하는 %>% (ctrl + Shift + m 단축기)
# 선수명, 팀, 경기, 타수를 조회하되 타수가 400이상인 선수만 출력
d1 %>%
  select(선수명, 팀, 경기, 타수) %>%
  filter(타수 >= 400)

# arrange 
d1 %>%
  select(선수명, 팀, 경기, 타수) %>%
  filter(타수 >= 400) %>%
  arrange(desc(타수)) # desc() 내림차순 정렬

# mutate
d1 %>% 
  select(선수명, 팀, 경기, 타수) %>% 
  mutate(경기X타수 = 경기*타수) %>% 
  arrange(경기X타수)

# 안타율 변수 생성(안타율 = 안타/타수)하되, 할푼리로 표현
d1 %>% 
  select(선수명, 팀, 안타, 타수) %>% 
  mutate(안타율 = round(안타/타수, 3)) %>% 
  arrange(desc(안타율))

# summarise와 group_by
# 팀별로 평균 경기 횟수 구하기
d1 %>% 
  group_by(팀) %>% 
  summarise(avg = mean(경기, na.rm = T))

# 팀별로 경기와 타수의 평균을 구하기
d1 %>% 
  group_by(팀) %>% 
  summarise_each(funs(mean), 경기, 타수)

d1 %>% 
  group_by(팀) %>% 
  summarise_each(funs(mean, n()), 경기, 타수)
