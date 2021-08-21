setwd("d:/2021_march_micro_yerimseo/R/r_data")

# plot() : 분포도나 꺾은선 그래프
# plot(y축데이터, 옵션)
# plot(x축데이터, y축데이터, 옵션)

v1 = c(2, 2, 2)
plot(v1)
x = 1:3
y = 3:1
plot(x, y, xlim = c(1, 10), ylim = c(1, 5), xlab = "x축값", ylab = "y축값", main = "PLOT") # main : 그래프의 메인 제목
plot.new()
dev.new()

v1 = c(100, 130, 120, 160, 150)
plot(v1, type = 'o', col = 'red', ylim = c(0, 200), axes = F, ann = F) # axex : 외곽선 지우기, ann : 축 제목 지우기

axis(1, at = 1:5, labels = c("MON", "TUE", "WED", "THU", "FRI")) # x축값 생성
axis(2, ylim = c(0, 200)) # y축값 생성

title(main = "FRUIT", col.main = 'red', font.main = 4)
title(xlab = 'DAY', col.lab = 'black')
title(ylab = 'PRICE', col.lab = 'blue')

par(mfrow = c(1, 3)) # 그래프를 그려지는 행렬 개수 지정할 수 있음
pie(v1)
plot(v1, type = 'o')
barplot(v1)
par(mfrow = c(1, 1))
a = c(1, 2, 3)
plot(a, xlab = 'aaa')
# mgp = c(제목위치, 지표값위치, 지표선위치)
par(mgp = c(3, 2, 1))
plot(a, xlab = 'aaa')

# oma(outside margine) : 그래프 전체의 여백 조정
# oma(bottom, left, top, right)
par(oma = c(0, 2, 0, 0))
plot(a, xlab = 'aaa')

# 여러개의 그래프를 중첩 그리기 : par(new = T), add = T
v1 = c(1, 2, 3, 4, 5)
v2 = c(5, 4, 3, 2, 1)
v3 = c(3, 4, 5, 6, 7)
plot(v1, type = 's', col = 'red', ylim = c(1, 5))
par(new = T)
plot(v2, type = 'o', col = 'blue', ylim = c(1, 5))
par(new = T)
plot(v3, type = 'l', col = 'green')

plot.new()
plot(v1, type = 's', col = 'red', ylim = c(1, 10))
lines(v2, type = 'o', col = 'blue', ylim = c(1,5))
lines(v3, type = 'l', col = 'green')

# 범례 추가 : legend(x축위치, y축위치, cex = 글자크기, col = 색상, pch = 크기, lty = 선모양)
legend(4, 9, c("v1", "v2", "v3"), cex = 0.9, col = c('red', 'blue', 'green'), lty = 1)

# barplot() : 막대그래프
x = c(1, 2, 3, 4, 5)
barplot(x)

# 가로출력 : horiz = T
barplot(x, horiz = T)

# 그룹으로 묶어서 출력 : beside = T
x = matrix(c(5, 4, 3, 2), 2, 2)
barplot(x, beside = T, names = c(5, 3), col = c('green', 'yellow'))
x

# 하나의 믹대그래프로 표현
barplot(x, names = c(5, 3), col = c('green', 'yellow'), ylim = c(0, 12))

# 그룹으로 묶어서 가로 출력
barplot(x, beside = T, horiz = T, names = c(5, 3), col = c('green', 'yellow'))
barplot(x, horiz = T, names = c(5, 3), col = c('green', 'yellow'), xlim = c(0, 12))

# 여러 막대그래프를 그룹으로 묶어서 한꺼번에 출력
v1 = c(100, 120, 140, 160, 180)
v2 = c(120, 130, 150, 140, 170)
v3 = c(140, 170, 120, 110, 160)

qty = data.frame(BANANA = v1, CHERRY = v2, ORANGE = v3)
qty

barplot(as.matrix(qty), main = "FRUITS QTY", beside = T, col = rainbow(nrow(qty)), ylim = c(0, 400))
legend(14, 400, c("MON", "TUE", "WED", "THU", "FRI"), cex = 0.8, fill = rainbow(nrow(qty)))


qty
t(qty) # 전치행렬
barplot(t(qty), main = "FRUITS QTY", col = rainbow(length(qty)), ylim = c(0, 900), names.arg = c("MON", "TUE", "WED", "THU", "FRI"))
legend(0.2, 800, names(qty), cex = 0.8, fill = rainbow(length(qty)))


peach = c(180, 200, 250, 198, 170)
colors = c()
for (i in 1:length(peach)) {
  if (peach[i] >= 200) {
    colors = c(colors, 'red')
  } else if (peach[i] >= 180) {
    colors = c(colors, 'yellow')
  } else {
    colors = c(colors, 'green')
  }
}

barplot(peach, main = "PEACH QTY", names.arg = c("MON", "TUE", "WED", "THU", "FRI"), col = colors)


# 매개변수 있는 함수처리

f1 = function(fruits) {
  pcolor = NULL
  for (i in 1:length(fruits)) {
    if (fruits[i] >= 200) {
      pcolor[i] = 'pink'
    } else if (fruits[i] >= 180) {
      pcolor[i] = 'yellow'
    } else {
      pcolor[i] = 'cyan'
    }
  }
  return(pcolor)
}

f1(peach)
barplot(peach, main = "PEACH QTY", names.arg = c("MON", "TUE", "WED", "THU", "FRI"), col = f1(peach))


# 히스토그램(특정 데이터의 빈도수를 막대로 나타낸 것) : hist()
h = c(182, 175, 167, 172, 163, 178, 181, 166, 159, 155)
hist(h, main = "HIST")


# 파이(pie) : 전체의 합이 100이 되어야하는 경우 서로를 비교할 때 좋다
p1 = c(10, 20, 30, 40)
pie(p1, radius = 1)
pie(p1, radius = 1, init.angle = 90)

pie(p1, radius = 1, init.angle = 90, col = rainbow(length(p1)), labels = c("w1", "w2", "w3", "w4"))

pct = round(p1/sum(p1)*100, 2)
lab = paste(pct, "%")
pie(p1, radius = 1, init.angle = 90, col = rainbow(length(p1)), labels = lab)
legend(1, 1.1, c("w1", "w2", "w3", "w4"), cex = 0.5, fill = rainbow(length(p1)))


pct = round(p1/sum(p1)*100, 2)

lab1 = c("w1", "w2", "w3", "w4")
lab2 = paste(lab1, "\n", pct, "%")

pie(p1, radius = 1, init.angle = 90, col = rainbow(length(p1)), labels = lab2)

install.packages("plotrix")
library(plotrix)
pie3D(p1, radius = 1, init.angle = 90, col = rainbow(length(p1)), labels = lab2, explode = 0.05)

# 상자차트(최대, 최소, 중앙값 등을 한눈에 보인다) : boxplot()
v1 = c(10, 12, 15, 11, 20)
v2 = c(5, 7, 15, 8, 9)
v3 = c(11, 20, 15, 18, 13)
boxplot(v1, v2, v3, col = c('blue', 'yellow', 'pink'), name = c('BLUE', 'YELLOW', 'PINK'), horizontal = T)


# 데이터 정제
# 빠진 데이터 찾기 : 결측치 정제
# 결측치
# - 누락되어 있는 값, 비어있는 값
# - 함수 적용 불가, 분석 결고 왜곡
# - 제거 후 분석

df = data.frame(gender = c('M', 'F', NA, 'M', 'F'), score = c(5, 4, 3, 4, NA))
df
is.na(df)
table(is.na(df))

table(is.na(df$gender))
mean(df$score)

# 결측치 제거
library(dplyr)
df %>% filter(is.na(score))
df1 = df %>% filter(!is.na(score))
df1
mean(df1$score)
sum(df1$score)

df1 = df %>% filter(!is.na(score) & !is.na(gender))
df1

mean(df$score, na.rm = T)
sum(df$score, na.rm = T)

ex = read.csv("csv_exam.csv")
ex[c(3, 8, 5), 'math'] = NA
ex
ex %>% summarise(mean_math = mean(math))
ex %>% summarise(mean_math = mean(math, na.rm = T))


# 결측치 대체하기
# 결측치 많을 경우 모두 제외하면 데이터 손실이 큼
# 대안 : 다른 값을 채워넣기
# 결측치 대체법
# - 대표값(평균, 최빈값 등)으로 일괄대체
# - 통계분석기법 적용, 예측값 추정해서 대체
# 
# 평균값 대체
mean(ex$math, na.rm = T)
ex$math = ifelse(is.na(ex$math), 55, ex$math)
ex
table(is.na(ex$math))

library(ggplot2)
mpg
mpg1 = as.data.frame(mpg)
mpg1


mpg1[c(65, 124, 153, 212), 'hwy'] = NA
mpg1
View(mpg1)

# 결측치가 들어있는 mpg 데이터를 활용해서 문제를 해결해보세요.
# Q1. drv(구동방식)별로 hwy(고속도로 연비) 평균이 어떻게 다른지 알아보려고 합니다. 분석을 하기전에 우선 두 변수에 결측치가 있는지 확인해야 합니다. drv 변수와 hwy 변수에 결측치가 몇 개 있는지 알아보세요.

table(is.na(mpg1$drv))
table(is.na(mpg1$hwy))

# Q2. filter()를 이용해 hwy 변수의 결측치를 제외하고, 어떤 구동방식의 hwy 평균이 높은지 알아보세요. 하나의 dplyr 구문으로 만들어야 합니다.

mpg1 %>% filter(!is.na(hwy)) %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy))


# 이상치 : 정상범주에서 크게 벗어난 값
# - 이상치 포함시 분석결과 왜곡
# - 결측처리 후 제외하고 분석
# 
# 이상치 종류
# 1. 존재할 수 없는 값 : 결측처리
# - 논리적으로 존재할 수 없으므로 결측처리 후 분석
# 2. 극단적인 값 : 정상범위 기준을 정해서 결측처리

# 1. 존재할 수 없는 값
out = data.frame(gender = c(1, 2, 1, 3, 2, 1),
                 score = c(5, 4, 3, 4, 2, 6))
out
table(out$gender)
table(out$score)

# 결측처리
out$gender = ifelse(out$gender == 3, NA, out$gender)
out

out$score = ifelse(out$score > 5, NA, out$score)
out

# 결측 제외하고 분석
out %>%
  filter(!is.na(gender) & !is.na(score)) %>%
  group_by(gender) %>%
  summarise(mean_score = mean(score))


# 2. 극단적인 값
mpg1 = as.data.frame(mpg)
boxplot(mpg1$hwy)
boxplot(mpg1$hwy)$stats # 통계치 출력 3이 중앙값 1이 극단치 경계 12 ~ 37 까지 정상치

mpg1$hwy = ifelse(mpg1$hwy < 12 | mpg1$hwy > 37, NA, mpg1$hwy)
table(is.na(mpg1$hwy))

# 결측 제외하고 분석
mpg1 %>%
  filter(!is.na(hwy)) %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy, na.rm = T))


mpg1 = as.data.frame(mpg)
mpg1[c(10, 14, 58, 93), 'drv'] = 'k'
mpg1[c(29, 43, 129, 203), 'cty'] = c(3, 4, 39, 42)

# 이상치가 들어있는 mpg 데이터를 활용해서 문제를 해결해보세요.
# 구동방식별로 도시 연비가 다른지 알아보려고 합니다. 분석을 하려면 우선 두 변수에 이상치가 있는지 확인하려고 합니다.
# Q1. drv에 이상치가 있는지 확인하세요. 이상치를 결측 처리한 다음 이상치가 사라졌는지 확인하세요. 결측 처리할 때는 %in% 기호를 활용하세요.

table(mpg1$drv)
mpg1$drv = ifelse(mpg1$drv %in% c('4', 'f', 'r'), mpg1$drv, NA)
mpg1$drv = ifelse(mpg1$drv == 'k', NA, mpg1$drv)
table(mpg1$drv)

# Q2. 상자 그림을 이용해서 cty에 이상치가 있는지 확인하세요. 상자 그림의 통계치를 이용해 정상 범위를 벗어난 값을 결측 처리한 후 다시 상자 그림을 만들어 이상치가 사라졌는지 확인하세요.

boxplot(mpg1$cty)$stats
mpg1$cty = ifelse(mpg1$cty < 9 | mpg1$cty > 26, NA, mpg1$cty)
boxplot(mpg1$cty)

# Q3. 두 변수의 이상치를 결측처리 했으니 이제 분석할 차례입니다. 이상치를 제외한 다음 drv별로 cty 평균이 어떻게 다른지 알아보세요. 하나의 dplyr 구문으로 만들어야 합니다.

mpg1 %>%
  filter(!is.na(drv) & !is.na(cty)) %>%
  group_by(drv) %>%
  summarise_each(funs(mean), cty)


# 관계도 : 서로 연관있는 데이터들을 연결해서 표현해주는 그래프
install.packages("igraph")
library(igraph)

g1 = graph(c(1,2, 2,3, 2,4, 1,4, 5,5, 3,6), directed = T)
plot(g1)
g1


name = c("홍길동대표", "일지매부장", "김유신과장", "손흥민대리", "노홍철대리", "이순신부장", "유관순과장", "신사임당대리", "강감찬부장", "광개토과장", "정몽주대리")
pemp = c("홍길동대표", "홍길동대표", "일지매부장", "김유신과장", "김유신과장", "홍길동대표", "이순신부장", "유관순과장", "홍길동대표", "강감찬부장", "광개토과장")

emp = data.frame(이름 = name, 상사이름 = pemp)
emp

g = graph.data.frame(emp, directed = F)
dev.new()
plot(g, layout = layout.fruchterman.reingold, vertex.size = 8, edge.arrow.size = 0.5, vertex.label = NA)
savePlot("network_1.jpg", type = "jpg") # dev.new를 사용해야 저장가능
g


install.packages("devtools")
library(devtools)
install_github("christophergandrud/d3Network")
install.packages("RCurl")
library(RCurl)
library(d3Network)

d3SimpleNetwork(emp, width = 600, height = 600, file = "d:/2021_march_micro_yerimseo/R/r_data/d3.html")
