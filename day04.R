setwd("d:/2021_march_micro_yerimseo/R/r_data")

library(googleVis)
library(dplyr)

# 데이터 전처리 : 원하는 형태로 데이터를 가공
# filter()    : 행 추출
# select()    : 열(변수) 추출
# arrange()   : 정렬
# mutate()    : 변수 추가
# summarise() : 통계치 산출
# group_by()  : 집단별 나누기

ex = read.csv("csv_exam.csv")
ex

ex %>% filter(class == 1)
ex %>% filter(class != 1)
ex %>% filter(math >= 50)
ex %>% filter(class == 1 & math >= 50)
ex %>% filter(math >= 90 | english >= 90)
ex %>% filter(class == 1 | class == 2 | class == 3)
ex %>% filter(class %in% c(1, 3, 5))

ex %>% select(math)
ex %>% select(-english)

ex %>% filter(class == 1) %>% select(english) %>% head(3) # head(3) : 3개의 데이터만 추출

ex %>% arrange(math)
ex %>% arrange(desc(math))
ex %>% mutate(total = math + english + science) %>% head(5)
ex %>% mutate(total = math + english + science,
              mean = round((math + english + science)/3, 2))

ex %>% summarise(mean_math = mean(math))
ex %>% group_by(class) %>% summarise(mean_math = mean(math))


# 1. Fruits 데이터셋의 컬럼을 변수로 사용하게 설정하시오.
f = Fruits
attach(f)

# 2. Fruits 데이터셋에서 Expenses 값이 80보다 큰 값을 출력
f %>% filter(Expenses >= 80)
f1 = filter(f, Expenses >= 80)
f1

# 3. Expenses 값이 90보다 크고 Sales 값도 90보다 큰 값을 출력
f %>% filter(Expenses >= 90 & Sales >= 90)

# 4. Expenses 값이 90보다 크거나 또는 Sales 값이 80보다 큰 값을 출력
f %>% filter(Expenses >= 90 | Sales >= 80)

# 5. Expenses 값이 79와 91인 값을 출력
f %>% filter(Expenses %in% c(79, 91))

# 6. 라벨명이 Fruit부터 Sales까지 출력하되 Location은 제외하고 출력
f %>% select(Fruit:Sales, -Location)
f1 = select(f, Fruit:Sales, -Location)
f1

# 7. 과일 이름별로 모아서 판매량의 합계를 구하되 만약, NA값이 있을 경우 자동삭제 옵션을 사용하시오.
f %>% 
  group_by(Fruit) %>% 
  summarise(Sales_sum = sum(Sales, na.rm = T))

# 8. 과일 이름별로 모아서 판매량과 이익의 합계를 구하시오.
f %>% 
  group_by(Fruit) %>% 
  summarise_each(funs(sum), Sales, Profit)


# mpg 데이터를 이용해서 분석 문제를 해결해보세요.
library(ggplot2)
mpg

# Q1. mpg 데이터의 class는 "suv", "compact" 등 자동차를 특징에 따라 일곱 종류로 분류한 변수입니다. 어떤 차중의 연비가 높은지 비교해보려고 합니다. class별 cty평균을 구해보세요.
mpg %>% 
  group_by(class) %>% 
  summarise(mean_cty = mean(cty))

# Q2. 앞 문제의 출력 결과는 class 값 알파벳 순으로 정렬되어 있습니다. 어떤 차종의 도시 연비가 높은지 쉽게 알아볼 수 있도록 cty 평균이 높은 순으로 정렬해 출력하세요.
mpg %>% 
  group_by(class) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  arrange(desc(mean_cty))

# Q3. 어떤 회사 자동차의 hwy(고속도로 연비)가 가장 높은지 알아보려고 합니다. hwy 평균이 가장 높은 회사 세곳을 출력하세요.
mpg %>% 
  group_by(manufacturer) %>% 
  summarise(mean_hwy = mean(hwy)) %>% 
  arrange(desc(mean_hwy)) %>% 
  head(3)

# Q4. 어떤 회사에서 "compact"(경차) 차종을 가장 많이 생산하는지 알아보려고 합니다. 각 회사별 "compact" 차종 수를 내림차순으로 정렬해 출력하세요.
mpg %>% 
  filter(class == "compact") %>% 
  group_by(manufacturer) %>% 
  summarise(count = n()) %>% 
  arrange(desc(count))

# 문제) 회사별로 "suv" 자동차의 도시 및 고속도로 통합 연비 평균을 구해 내림차순으로 정렬하고, 1 ~ 5위까지 출력하시오.  
# 분석절차
# 1. 회사별 분리 : group_by()
# 2. suv추출 : filter()
# 3. 통합연비 변수 생성 : mutate()
# 4. 통합연비 평균 산출 : summarise()
# 5. 내림차순 정렬 : arrange(desc())
# 6. 1 ~ 5위 출력 : head()
mpg %>%
  group_by(manufacturer) %>% 
  filter(class == "suv") %>%
  mutate(tot = (cty + hwy)/2) %>% 
  summarise(mean_tot = mean(tot)) %>% 
  arrange(desc(mean_tot)) %>% 
  head(5)


# reshape2() 패키지 : 옆으로 컬럼이 많은 형태(wide)를 세로로 긴 형태(long)로 변경해주고, 또는 반대로 변경해주는 패키지. melt()와 cast()를 자주 사용
install.packages("reshape2")
library(reshape2)
library(plyr)

f = read.csv("fruits_10.csv")
f

# melt() : wide -> long
melt(f, id = 'year')
melt(f, id = c('year', 'name'))
melt(f, id = c('year', 'name'), variable.name = 'var_name', value.name = 'val_name')

# cast() : long -> wide
mm = melt(f, id = c('year', 'name'), variable.name = 'var_name', value.name = 'val_name')
mm

# melt작업한 것을 dcast로 원상복구
# dcast(data, 기준컬럼~대상컬럼, 적용함수)
dcast(mm, year+name~var_name)

dcast(mm, year~var_name)

dcast(mm, name~var_name, sum)

dcast(mm, name~var_name, sum, subset = .(name=='apple'))

# stringr() : 작업대상 데이터가 문자일 경우 사용
install.packages("stringr")
library(stringr)

# str_detect() : 특정문자 포함여부(true/false)
f1 = c('apple', 'Apple', 'banana', 'pineapple')
str_detect(f1, 'A')
str_detect(f1, '^a')
str_detect(f1, 'e$')
str_detect(f1, '^[aA]')
str_detect(f1, '[aA]')

# 대소문자 무시
str_detect(f1, ignore.case('a')) # 옛날 버전 사용X

p = 'a.b'
s = c('abb', 'a.b')
str_detect(s, p)
str_detect(s, fixed(p))
str_detect(s, coll(p))

str_detect(f1, fixed('a', ignore_case = T))

# str_count() : 특정문자 출현 횟수
f1
str_count(f1, 'a')
str_count(f1, fixed('a', ignore_case = T))

# str_c() : 문자열 합치기
str_c('apple', 'banana')
str_c("Fruits : ", f1)
str_c(f1, " name is ", f1)
str_c(f1, collapse = "") # 공간 없이 합쳐주기
str_c(f1, collapse = "-")

# str_dup() : 반복 출력
str_dup(f1, 3)

# str_length() : 문자열 길이
str_length('apple')
str_length(f1)

# str_locate() : 특정 문자의 위치값(문자열에서 처음 나오는 위치와 마지막 위치)
str_locate('apple', 'a')
str_locate(f1, 'a')

# str_replace() : 문자열 변경
str_replace('apple', 'p', '*')
str_replace_all('apple', 'p', '$')

# str_split() : 주어진 데이터셋을 지정된 기호로 분리
f2 = str_c('apple', '/', 'orange', '/', 'banana')
f2
str_split(f2, '/')

# str_sub() : 지정된 길이만큼 문자를 잘라내는 함수
str_sub(f2, start = 1, end = 3)
str_sub(f2, start = 6, end = 9)
str_sub(f2, start = -5)

# str_trim() : 문자열의 가장 앞과 가장 뒤의 공백 제거
str_trim("            apple banan ornage          ")

# sqldf 패키지 : 대상 데이터가 데이터프레임에 담겨있어야 한다. 만약 아닌 경우 as.data.frame()를 사용해서 변환
View(Fruits)

# sql쿼리
# 1. 조회 : select
#    select 컬럼명 from 테이블명(데이터셋) where 조건;
# 
# 2. 삽입 : insert
#    insert into 테이블명(컬럼1, 컬럼2, ...., 컬럼n) values (값1, 값2, ....., 값n) 
# 
# 3. 갱신(수정) : update
#    update 테이블명 set 컬럼명 = 변경할 값 where 조건;
#    
# 4. 삭제 : delete
#    delete from 테이블명 where 조건;

Fruits
library(sqldf)
# Fruits의 모든 데이터 가져오기
sqldf("select * from Fruits")

# Fruit값이 Apples인 값들의 모든 정보 조회
sqldf("select * from Fruits where Fruit = 'Apples'")
sqldf("select * from Fruits where Fruit = \"Apples\"")

# 출력 행수 제어 : limit
sqldf("select * from Fruits limit 3")

# 정렬 : order by
sqldf("select * from Fruits order by Year")
sqldf("select * from Fruits order by Year desc") # 내림차순 정렬

# 그룹함수 이용
# 합계 판매량
sqldf("select sum(Sales) from Fruits")

# 최대 판매량
sqldf("select max(Sales) from Fruits")

# 평균 판매량
sqldf("select avg(Sales) from Fruits")

# 과일 이름별 판매합계 : group by
sqldf("select Fruit, sum(Sales) from Fruits group by Fruit")
sqldf("select Fruit, avg(Sales) from Fruits group by Fruit")

# 총 수량
sqldf("select count(*) from Fruits")

# 데이터 변경
sqldf(c("update Fruits set Profit = 50 where Fruit = 'Apples' and Year = 2008",
        "select * from Fruits"))

# 데이터 삭제
sqldf(c("delete from Fruits where Fruit = 'Apples' and Year = 2008",
        "select * from Fruits"))

# 조건이 없는 경우
sqldf(c("update Fruits set Profit = 50", "select * from Fruits"))
sqldf(c("delete from Fruits", "select * from Fruits"))

# 조건문
# if 조건
# if (조건식) {
#   조건이 참인 경우 실행
# } else {
#   조건이 거짓인 경우 실행
# }
my1 = function(x) {
  if (x < 0) {
    return(-x)
  } else {
    return(x)
  }
}

my1(-9)

# if (조건식1) {
#   조건1이 참인 경우 실행
# } else if (조건식2) {
#   조건2가 참인 경우 실행
# } else if (조건식n) {
#   조건n이 참인 경우 실행
# } else {
#   조건이 거짓인 경우 실행
# }

# 문제) 입력된 숫자가 0보다 크면 2배의 값을 출력하고 0일 경우 0을 출력하고 0보다 작을 경우 -3배의 값을 출력하는 문장을 만드세요.
my2 = function(x) {
  if (x > 0) {
    x = x * 2
  } else if (x == 0) {
    x = 0
  } else {
    x = x * -3
  }
  return(x)
}

my2(1)
my2(0)
my2(-3)

# ifelse(a, b, c) : a가 참인 경우 b를 출력하고 거짓인 경우 c를 출력
no = scan()

ifelse(no %% 2 == 0, "짝", "홀")

# 문제) 서로 다른 두 개의 숫자를 입력받아서 두 숫자 사이에 존재하는 숫자의 갯수를 구하여라.
no1 = scan()
no2 = scan()

ifelse(no1 > no2, no1 - no2 - 1, no2 - no1 - 1)

no = scan()
ifelse(no[1] > no[2], no[1] - no[2] -1, no[2] - no[1] -1)


# while 반복문
no = 0
while (no < 5) {
  print(no)
  no = no + 1
}

x = 1
while (x < 5) {
  x = x + 1
  if (x == 4) {
    break
  }
  print(x)
}

x = 1
while (x < 5) {
  x = x + 1
  if (x == 4) {
    next
  }
  print(x)
}

my3 = function(x) {
  i = 0
  for (j in 1:x) {
    i = i + j
  }
  print(i)
}
my3(10)

# 특정 변수에 들어가있는 값에 따라 10이상이면 color를 'red', 6 ~ 9면 'yellow', 그 이하는 'green'

colors = c()
for (i in 1:length(my)) {
  if (my[i] >= 10) {
    colors = c(colors, 'red')
  } else if (my[i] >= 6) {
    colors = c(colors, 'yellow')
  } else {
    colors = c(colors, 'green')
  }
}

# 특정 패턴만 골라내기 : grep(pattern, a) 벡터 a에서 특정 패턴을 찾아서 그 위치를 출력
c1 = c('apple', 'Apple', 'APPLE', 'banana', 'grape')
grep('apple', c1)

c2 = c('apple', 'banana')
grep(c2, c1) # 처음 한개의 값만 찾기 때문에 X

# collapse = "|" : 두가지 패턴을 동시에 찾아라
grep(paste(c2, collapse = "|"), c1, value = T) # value = T 위치 말고 값을 그대로 보여줌

grep('pp', c1, value = T)

grep('^A', c1, value = T)
grep('e$', c1, value = T)

c3 = c('grape1', 'apple1', 'apple', 'orange', 'Apple')
grep('ap', c3, value = T)
grep('[1-9]', c3, value = T) # 숫자가 들어있는 단어 찾기
grep('[[:upper:]]', c3, value = T) # 대문자가 있는 단어 찾기

# 길이 : nchar(a)
c1
nchar(c1)
nchar("홍길동") # R에서는 글자(한글) 하나당 1바이트(공백 포함)
nchar("홍 길 동")

# 연결 : paste('a', 'b', 'c')
paste("홍", "길", "동")
paste("홍", "길", "동", sep = "") # 공백을 없이 하기 위해서 sep = "" 사용
paste("홍", "길", "동", sep = "-")
paste("I", "\'m", "hungry")

# 특정 부분만 골라내기 : substr('a', 시작위치, 끝나는 위치)
substr('abc123', 3, 3)
substr('abc123', 3, 5)

# 특정 글자를 기준으로 분리 : strsplit(문자열, split = "기준문자")
strsplit("2021/08/15", split = "/")

# 특정 패턴 찾기 : regexpr("pattern", text)
grep('-', '010-1111-1111')
regexpr('-', '010-1111-1111')
