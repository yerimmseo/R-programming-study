# [벡터형 연습문제]
setwd("d:/2021_march_micro_yerimseo/R/r_data")
# Q1. seq()함수를 사용하여 date4라는 변수에 2015년 1월 1일부터 2015년 1월 31일까지
#     1일씩 증가하는 31개의 날짜를 입력하는 방법을 쓰세요.
d4 = seq(as.Date('2015-01-01'), as.Date('2015-01-31'), 'day')
d4

# Q2. 다음과 같이 vec1을 생성하여 3번째 요소인 '감'을 제외하고 vec1의 값을 출력하세요.
vec1 <- c('사과', '배', '감', '버섯', '고구마')
vec1
vec1[-3]

vec1 <- c('봄', '여름', '가을', '겨울')
vec2 <- c('봄', '가을', '늦여름', '초가을')

union(vec1, vec2)
setdiff(vec1, vec2)
intersect(vec1, vec2)

# Q1. a ~ f 값을 갖는 벡터 생성
vec3 <- c('a', 'b', 'c', 'd', 'e', 'f')
vec3[3] <- 'C'
vec3[5] <- 'E'

# Q1-1) 3, 5번째 데이터를 대문자로 변경
vec3[c(3, 5)] = c('C', 'E')

vec3[c(2, 4)] = toupper(vec3[c(2, 4)])
vec3

# Q1-2) 4번째 데이터 삭제
vec3 <- vec3[-4]
vec3

# Q1-3) 위의 벡터를 factor 타입으로 변경
vec3 = factor(vec3) # as.factor(vec3)
class(vec3)
vec3

# Q2. 2021년 전체 날짜를 갖는 벡터 생성
d5 = seq(as.Date('2021-01-01'), as.Date('2021-12-31'), 'day')
d5

# Q2-1) 위의 벡터를 년도를 제외한 월/일 형식으로만 출력하여 d6 생성
d6 = as.character(d5, "%m/%d")
d6

# Q2-2) d5에서 2021년 2월 28일 뒤에 2월 29일 날짜 삽입
# %j : 몇번째 날짜인지 확인
as.character(as.Date("2021/02/28"), "%j")
append(as.character(d5), "2021-02-29", after = 59)

# Q2-3) 2021년 2월 28일의 위치 확인
# 각 컬럼에 번호를 부여, names 함수를 이용해서 위치를 찾아올 수 있음
names(d5) = 1:length(d5)
names(d5[d5 == "2021-02-28"])
d5

# matrix : 행렬(2차원 배열)
# 1. 벡터를 여러개 합친 형태
# 2. 모든 컬럼과 행은 데이터형이 동일
# 3. 기본적으로 열로 생성된다.
# 4. 다른 데이터 타입의 데이터를 저장할 경우 데이터 프레임을 사용

# 기본적으로 값이 세로로 추가
m1 = matrix(c(1, 2, 3, 4))
m1

m2 = matrix(c(1, 2, 3, 4), nrow = 2)
m2

# byrow : 행에 의해서 출력해달라는 의미(값이 가로로 출력)
m3 = matrix(c(1, 2, 3, 4), nrow = 2, byrow = T)
m3

m3[ , 1] # 모든 행의 1열을 조회
m3[2, ] # 2행의 모든 열을 조회
m3[1, 1]

# 새로운 행과 열을 추가 : rbind(), cbind()
m4 = matrix(c(1, 2, 3,
              4, 5, 6,
              7, 8, 9), 3, by = T) # 3 : nrow = 3, nrow 생략 가능
m4

m4 = rbind(m4, c(11, 12, 13))
m4

# 행의 사이즈보다 긴 값들 입력은 가능. 워닝 메세지 뜨지만 넘어가는 곳 값 손실 발생
m4 = rbind(m4, c(14, 15, 16, 17))
m4

m4 = cbind(m4, c(21, 22, 23, 24, 25))
m4

# 사이즈 보다 작은 값들 입력 가능. 워닝 메세지는 뜨나 순환 발생
m4 = cbind(m4, c(31, 32, 33))
m4

colnames(m4) = c("1st", "2nd", "3rd", "4th", "5th")
m4
rownames(m4) = c(1, 2, 3, 4, 5)
m4

# [matrix형 연습문제]
seasons = matrix(c('봄', '여름', '가을', '겨울'), nrow = 2)
seasons

seasons = matrix(c('봄', '여름', '가을', '겨울'), nrow = 2, by = T)
seasons

seasons[ , 2]

seasons = rbind(seasons, c('초봄', '초가을'))
seasons

seasons = cbind(seasons, c('초여름', '초겨울', '한겨울'))

# matrix형 데이터 생성
no = c(1, 2, 3, 4)
name = c('apple', 'banana', 'peach', 'berry')
price = c(500, 200, 200, 50)
qty = c(5, 2, 7, 9)

m1 = cbind(no, name, price, qty)
m1

# Q1-1) peach의 가격 출력
m1[m1[, 'name'] == 'peach', 'price']

# Q1-2) apple과 peach의 데이터만 출력
m1[m1[, 'name'] == 'apple' | m1[, 'name'] == 'peach', ]

# Q1-3) sales라는 컬럼 생성(단, sales = price * qty)
sales = as.numeric(m1[, 'price']) * as.numeric(m1[, 'qty'])
sales
cbind(m1, sales)

# Q1-4) 첫번째 컬럼 제거 후 각 행번호 설정
rownames(m1) = m1[, 1]
m1 = m1[, -1]
m1

# Q1-5) qty가 5이상인 과일 이름 출력력
m1[m1[, 'qty'] >= 5, 'name']

# Q1-6) 5번째 과일 추가(mango, 100원, 10개개)
v1 = c('mango', '100', '10')
m1 = rbind(m1, v1)
m1
rownames(m1)[5] = '5'
m1


# array : 3차원 배열 (가로, 세로, 높이)
# matrix를 쌓아놓은 형태
arr1 = array(c(1:12), dim = c(4, 3))
arr1

arr2 = array(c(1:12), dim = c(2, 2, 3))
arr2

arr2[1, 1, 3] # 3층의 1행 1열 조회


# 서로 다른 데이터 타입 처리
# list : 벡터와 비슷하다((키, 값)형태로 저장)
l1 = list(name = "홍길동",
          addr = "서울 강남",
          tel = "010-1111-1111",
          pay = 500)
l1

l1$name
l1[1:2] # 1번 인덱스 ~ 2번 인덱스까지의 값 조회

# 새로운 요소 추가/삭제
l1$birth = "2021-08-08"
l1
l1$birth

l1$name = '고길동' # 기존에 들어있는 값 변경
l1

l1$name = c('고길동', '홍길동') # 하나의 키에 여러개 값 넣는 것 가능
l1

# 기존에 들어있는 값을 유지하면서 값을 추가
l1$name[length(l1$name) + 1] = '둘리'
l1

# list의 키삭제
l1$birth = NULL
l1

# 리스트의 값삭제
# NULL이 들어갈 수 없음(인덱스의 이동을 막기 때문에 NA 사용)
# -> 나중에 결측처리
l1$name[length(l1$name) - 1] = NA
l1


# 데이터 프레임
# 1. 벡터로부터 데이터프레임  생성하기 : 각 컬럼(라벨)별로 먼저 생성한 후
#    data.frame명령어로 모든 컬럼을 합친다.
no = c(1, 2, 3, 4)
name = c('Apple', 'Peach', 'Banana', 'Grape')
price = c(500, 200, 100, 50)
qty = c(5, 2, 4, 7)
sales = data.frame(NO = no, NAME = name, GAGYUK = price, QTY = qty)
sales

# 2. 행렬로 데이터프레임 생성
sales2 = matrix(c(1, 'Apple', 500, 5,
                2, 'Peach', 200, 2,
                3, 'Banana', 100, 4,
                4, 'Grape', 50, 7), nrow = 4, by = T)
sales2

df1 = data.frame(sales2)
df1

names(df1) = c('NO', 'NAME', 'GAGYUK', 'QTY')
df1

# 특정 데이터 조회
sales
sales$NAME
sales[1, 3]
sales[1, ]
sales[, 3]
sales[c(1, 2), ] # 1행과 2행의 모든 열
sales[, c(1, 3)] # 모든 행의 1열과 3열
sales[, c(1:3)] # 모든 행의 1열부터 3열

# 원하는 조건 조회
subset(sales, qty >= 5)
subset(sales, price == 200)
subset(sales, name == 'Apple')

class(sales)
str(sales) # data.frame의 구조 조회
sales2
str(sales2)
df1
str(df1)

# 데이터프레임 합치기 : rbind(), cbind(), merge()
no = c(1, 2, 3)
name = c('apple', 'banana', 'peach')
price = c(100, 200, 300)
df1 = data.frame(NO = no, NAME = name, PRICE = price)
df1

no = c(10, 20, 30)
name = c('car', 'train', 'ship')
price = c(1000, 2000, 3000)
df2 = data.frame(NO = no, NAME = name, PRICE = price)
df2

df3 = cbind(df1, df2)
df3

df4 = rbind(df1, df2) # 컬럼명이 같은 경우 rbind() 가능
df4
# 컬럼명이 다른 경우 rbind() 불가
df5 = data.frame(name = c('apple', 'banana', 'cherry'),
                 price = c(300, 200, 100))
df6 = data.frame(name = c('apple', 'cherry', 'berry'),
                 qty = c(10, 20, 30))
rbind(df5, df6)
merge(df5, df6) # 굳이 합치겠다면 merge() 사용. 두 값중 겹치는 것만 합쳐짐
merge(df5, df6, all = T)

cbind(df5, df6)

# 데이터프레임에 행/열 추가
df1
df5
new = data.frame(name = 'mango', price = 400)
df5 = rbind(df5, new)
df5

df5 = rbind(df5, data.frame(name = 'berry', price = 500))
df5

df5 = cbind(df5, data.frame(qty = c(10, 20, 30, 40, 50)))
df5

# 데이터프레임에서 특정 컬럼들만 골라서 새로운 형태 생성
no = c(1, 2, 3, 4, 5)
name = c('홍길동', '이순신', '강감찬', '유관순', '김유신')
addr = c('서울', '대전', '대구', '부산', '광주')
hobby = c('놀기', '먹기', '자기', '놀고먹기', '먹고자기')
tel = c(1111, 2222, 3333, 4444, 5555)
member = data.frame(NO = no, NAME = name, ADDR = addr, TEL = tel, HOBBY = hobby)
member

m2 = subset(member, select = c(NO, NAME, TEL)) # select = 컬럼명
m2

m3 = subset(member, select = -TEL) # TEL만 빼고 가져오기
m3

colnames(m3) = c('번호', '이름', '주소', '취미')
m3

# 데이터프레임의 내용 및 출력
# ncol() : 열의 개수
# nrow() : 행의 개수
# names() / colnames() : 열이름 출력(col.names() 사용X)
# rownames() / row.names() : 행이름 출력
sales
ncol(sales)
nrow(sales)
names(sales)
rownames(sales)
sales[c(2, 3, 1), ] # 행의 순서를 원하는대로 가져올 수 있다.

# [혼자서 해보기]
# Q1. data.frame()과 c()를 조합해서 표의 내용을 데이터프레임으로 만들어 출력해보세요.
product = c('사과', '딸기', '수박')
price = c(1800, 1500, 3000)
sale = c(24, 38, 13)

p1 = data.frame(제품 = product, 가격 = price, 판매량 = sale)
p1

# Q2. 앞에서 만든 데이터프레임을 이용해서 과일가격 평균, 판매량 평균을 구해보세요.
pavg = sum(subset(p1, select = 가격)) / length(p1$가격)
pavg
savg = sum(subset(p1, select = 판매량)) / length(p1$판매량)
savg

mean(p1$가격)
round(mean(p1$가격), 2)
mean(p1$판매량)

# 변수명 바꾸기
install.packages("dplyr") # 데이터 정제할 때 꼭 필요한 패키지
library(dplyr)

df1 = data.frame(var1 = c(1, 2, 1),
                 var2 = c(2, 3, 2))
df1
df2 = df1
df2

df2 = dplyr::rename(df1, v2 = var2) # var2를 v2로 수정(각 패키지마다 함수이름이 같을 때)
df2 # dplyr::rename -> dplyr의 패키지 안에 있는 rename

df1
df1$var_sum = df1$var1 + df1$var2
df1

df1$var_mean = (df1$var1 + df1$var2) / 2
df1

install.packages("ggplot2")
library(ggplot2)
mpg

View(mpg)

mpg1 = mpg
mpg1

# mpg 데이터의 변수명은 긴 단어를 짧게 줄인 축약어로 되어있습니다. cty 변수는 도시연비,
# hwy 변수는 고속도로 연비를 의미합니다. 변수명을 이해하기 쉬운 단어로 바꾸려고 합니다.
# mpg데이터를 이용해서 문제를 해결해 보세요.
# 
# Q1. ggplot2패키지의 mpg데이터를 사용할 수 있도록 불러온 뒤 복사본을 만드세요.
mpg1 = mpg
mpg1

# Q2. 복사본 데이터를 이용해서 cty는 city로, hwy는 highway로 변수명을 수정하세요.
mpg1 = dplyr::rename(mpg1, city = cty)
mpg1 = dplyr::rename(mpg1, highway = hwy)

# Q3. 데이터 일부를 출력해서 변수명이 바뀌었는지 확인해보세요.
head(mpg1) # 위에서 6개만 출력(정렬X)
tail(mpg1) # 아래에서 6개만 출력(정렬X) 

head(mpg1, 15)
tail(mpg1, 3)
View(mpg1)
class(mpg1)
str(mpg1)
