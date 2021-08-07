setwd("d:/2021_march_micro_yerimseo/R/r_data")
getwd()

# 화면에 결과를 출력
print(1+2)
1+2

a = 1
print(a)

a = '1'
print(a)

print(pi)
print(pi, digits = 3)

print(3, 4)
print('a', 'b')

cat(1, ":", 'a', '\n', 2, ":", 'b')

1;2;3
1+2; 2*3; 4/2


# R에서 가용하는 자료형
# 숫자형
# +, -, *
# / : 실수표현 가능
# %/% : 정수 나누기
# %% : 나머지 구하기
# ^, ** : 승수

4/2
4%/%2
4%%2

5/2
5%/%2
5%%2

1+2*3
(1+2)*3

10000
100000
1000000
3e2
3e-2

1+2
'1' + '2'
as.numeric('1') + as.numeric('2')

# 문자형
'first'
first = 1
first = 'a'

class(first)


# 진리값(TRUE / FALSE)
3 & 0
0 & -2
3 & 8
-5 & 9

3 | -1
3 | 0
!0
!8

# NA형 / NULL형
# NA : 잘못된 값이 들어올 경우(Not Applicable, Not Available)
# NULL : 값이 없을 경우

cat(1, NA, 2)
cat(1, NULL, 2)
sum(1, NA, 2)
sum(1, NULL, 2)

sum(1, NA, 2, na.rm = T)

# Factor형 : 여러번 중복되어 나오는 데이터들을 각 값으로 모아서 대표값을 출력
setwd("d:/2021_march_micro_yerimseo/R/r_data")
t1 = read.csv("factor_test.txt")
t1

f1 = factor(t1$blood)
f1
summary(f1)

# t1에서 남여 성별을 요약
s1 = factor(t1$sex)
summary(s1)


# 날짜와 시간
# 1. 기존 함수사용
Sys.Date()
Sys.time()
date()

'2021-08-07'
as.Date('2021-08-07')
class(as.Date('2021-08-07'))

as.Date("2021/08/07")
as.Date("08-07-2021")

as.Date("08-07-2021", format = "%m-%d-%Y")
as.Date("2021년 08월 07일", format = "%Y년 %m월 %d일")
as.Date("080721", format = "%m%d%y")
as.Date(100, origin = '2021-08-07')
as.Date(-100, origin = '2021-08-07')

'2021-11-15' - '2021-08-07'
as.Date('2021-11-15') - as.Date('2021-08-07')
as.Date('2021-08-07') + 100

# R에서는 날짜를 표현할 때 POSIXlt와 POSIXct 두가지 클래스를 사용한다.
# POSIXlt는 날짜를 년, 월, 일로 표시하는 리스트형 클래스
# POSIXct는 날짜를 연속적인 데이터로 인식해서 1970년을 기준으로 초단위로 계산

as.Date('2021-11-15 20:00:00') - as.Date('2021-08-07 11:25:00')
as.POSIXct('2021-11-15 20:00:00') - as.POSIXct('2021-08-07 11:25:00')

# lubridate 패키지로 날짜와 시간 제어
install.packages("lubridate")
library(lubridate)

d = now()
d
year(d)
month(d, label = T)
day(d)
wday(d, label = T)

d1 = d - days(2)
d1

d + years(1)

# 오늘 날짜에서 1년 2개월 3일 4시간 5분 6초를 더해라.
d + years(1) + months(2) + days(3) + hours(4) + minutes(5) + seconds(6)

d2 = hm("22:30")
d2

d3 = hms("22:30:15")
d3

seq(as.Date("2021-01-01"), as.Date("2021-12-31"), 'day') # 1 또는 'day'
seq(as.Date("2021-01-01"), as.Date("2021-12-31"), 'month')
seq(as.Date("2021-01-01"), as.Date("2121-12-31"), 'year')

# 변수 : 데이터를 담는 그릇
v1 = '1'
v1 = 1
class(v1)

v1 = now()
class(v1)

v2 = c(1, 2, 3)
v2

v3 = c('a', 'b', 'c')
v3
v3[2]

v3[1]

v4 <- v5 <- 100
v6 = v7 = 1000
v4
10000 -> v8 -> v9 # 사용은 가능하지만 가용성이 떨어져서 좋지않은 방법
v9

str1 = 'Very easy R'
str1

c1 = c(1, 2, 3, 4, '5')
c1
class(c1)

# 변수 선언시 주의 사항
# 1. 대소문자 구분
# 2. 영어, 숫자 모두 사용가능. 단, 시작은 반드시 문자
# 3. 예약어는 변수로 사용x
#    ex) if, for, while, else, break, TRUE, FALSE, NA, NULL, repeate, function ...

n1 = 1
n2 = 2
n1 + n2
n3 = '3'
n1 + n3

s1 = 1:5
s1
s2 = 'a' : 'f'

objects()
objects(all.names = T)
rm(strl)
rm(v9)

rm(list = ls())

x = c(9, 15, 20, 6)
lab = c("영업1", "영업2", "영업3", "영업4")
pie(x, labels = lab, main = "부서별 영업실적")

barplot(x, names.arg = lab, main = "부서별 영업실적", col = 
          rainbow(length(x)), xlab = "부서", ylab = "실적(억원)")

install.packages("animation")
library(animation)

ani.options(interval = 1)
for (i in 10:0) {
  plot.new()
  rect(0, 0, 1, 1, col = 'yellow')
  text(0.5, 0.5, i, cex = 5, col = rgb(.2, .2, .2, .8))
  ani.pause()
}


install.packages("wordcloud")
install.packages("RColorBrewer")
library(wordcloud)
library(RColorBrewer)

pal = brewer.pal(8, 'Set2')
x = c("금메달", "올림픽", "폐막", "배구4강", "코로나")
y = c(5, 4, 10, 15, 20)
wordcloud(x, y, colors = pal)


# 데이터 처리 객체
# - 동일 데이터 타입
# 1. 스칼라 : 단일 데이터 처리
# 2. 벡터 : 1차원 배열(스칼라를 여러개 합친 것)
# 3. matrix : 2차원 배열(벡터를 여러개 합친 것)
# 4. array : 3차원 배열(matrix를 여러개 쌓아 올린 것)
# 
# - 다른 데이터 타입
# 1. list : 벡터와 비슷((키, 값)형태로 저장)
# 2. 데이터 프레임 : 엑셀의 표나 DB의 테이블과 같음(DB의 컬럼처럼 라벨이 있음)


# 벡터 : 1차원 배열
# 1. c()함수로 작성
# 2. 인덱스는 1부터 시작
# 3. 하나의 자료형만 사용
# 4. 결측값은 'NA' 사용
# 5. NULL은 어떤 형식도 취하지 않는 특별한 객체

c(1, 2, 3, 4, 5)
c(1, 2, 2, 3, 4, '5')
v1 = c(1, 2, 3, 4, 5)
v1

# 특정위치값 제어
v1[3]
v1[-3]
v1[1:4]
v1[1:(length(v1) - 2)]
v1[-1:-3]
v1[2] = 6
v1
v1 = c(v1, 7)
v1
v1[9] = 9
v1

append(v1, 10, after = 3)
append(v1, c(11, 12), after = 2) # after 뒤는 값이 아닌 위치를 얘기
v1

v1 = append(v1, c(11, 12), after = 2)
v1

v1 = append(v1, 13, after = 0)
v1

# 벡터로 연산
c(1, 2, 3) + c(4, 5, 6)

c(1, 2, 3) + 1
v1 = c(1, 2, 3)
v2 = c(4, 5, 6)
v1 + v2
v3 = c('3', 4, 5)
v1 + v3
union(v1, v3)

# 두 벡터의 길이가 다르면 순환원리가 적용
v4 = c(1, 2, 3, 4, 5)
v1
v1 + v4

v1 = c(1, 2, 3)
v2 = c(3, 4, 5)
v1 - v2
setdiff(v1, v2) # 차집합
intersect(v1, v2) # 교집합

# 벡터의 컬럼명 지정
f = c(10, 20, 30)
f
names(f) = c('apple', 'banana', 'cherry')
f

# 벡터의 연속적인 데이터 할당 : seq(), rep()
v5 = seq(1, 5)
v5

v6 = seq(-2, 2)
v6

v7 = seq(1, 10, 2)
v7

v8 = rep(1:3, 2)
v8

v9 = rep(1:3, each = 2)
v9

# 벡터의 길이
length(v1)
NROW(v1)

v7

# 벡터에 특정 문자 포함 여부
3 %in% v7
4 %in% v7
