setwd("d:/2021_march_micro_yerimseo/R/r_data")

library(igraph)

g = read.csv("군집분석.csv", header = T)
g1 = data.frame(학생 = g$학생, 교수 = g$교수)
g2 = graph.data.frame(g1, directed = T)
plot(g2, layout = layout.fruchterman.reingold, vertex.size = 2, edge.arrow.size = 0.5, vertex.color = 'green', vertex.label = NA)
plot(g2, layout = layout.kamada.kawai, vertex.size = 2, edge.arrow.size = 0.5, vertex.color = 'green', vertex.label = NA)

# 학생과 교수의 색상과 크기를 구분
g1
library(stringr)
g1 = data.frame(학생 = g$학생, 교수 = g$교수)
g2 = graph.data.frame(g1, directed = T)
V(g2)$name
gubun1 = V(g2)$name
gubun1
gubun = str_sub(gubun1, start = 1, end = 1)
gubun

# 학생은 red, 교수는 green
colors = c()
for (i in 1:length(gubun)) {
  if (gubun[i] == 'S') {
    colors = c(colors, 'red')
  } else {
    colors = c(colors, 'green')
  }
}

plot(g2, layout = layout.kamada.kawai, vertex.size = 2, edge.arrow.size = 0.1, vertex.color = colors, vertex.label = NA)

# 학생은 점의 크기를 2로, 교수는 6.
# 학생의 점의 모양은 circle로, 교수는 square.
sizes = c()
shapes = c()
for (i in 1:length(gubun)) {
  if (gubun[i] == 'S') {
    sizes = c(sizes, 2)
    shapes = c(shapes, 'circle')
  } else {
    sizes = c(sizes, 6)
    shapes = c(shapes, 'square')
  }
}

plot(g2, layout = layout.kamada.kawai, vertex.size = sizes, edge.arrow.size = 0.1, vertex.color = colors, vertex.label = NA, vertex.shape = shapes)

install.packages("treemap")
library(treemap)
tot = read.csv("학생시험결과_전체점수.csv", header = T)
tot
treemap(tot, vSize = "점수", index = c("점수", "이름"))
treemap(tot, vSize = "점수", index = c("조", "이름"))
treemap(tot, vSize = "점수", index = c("조", "점수", "이름"))

# stars()
tot = read.table("학생별전체성적_new.txt", header = T, sep = ",")
tot

row.names(tot) = tot$이름 # 행번호를 알아야 학생정보를 알 수 있기 때문에 쉽게 처리를 하기위해 행이름을 학생이름으로 변경한다
tot

tot = tot[, 2:7] # 행번호에 이름이 들어와있는 상태
tot

stars(tot, flip.labels = F, draw.segments = T, frame.plot = T, full = T, key.loc = c(0.2, 6.5), main = "학생별 과목 성적")


# radarchart()
# 1. 샘플데이터 만든다
# 2. 최대값과 최소값 지정
# 3. radarchart()함수 사용

install.packages("fmsb")
library(fmsb)
layout = data.frame(
  분석력 = c(5, 1),
  창의력 = c(15, 3),
  판단력 = c(3, 0),
  리더쉽 = c(5, 1),
  사교성 = c(5, 1))

set.seed(123)
data1 = data.frame(
  분석력 = runif(3, 1, 5),
  창의력 = rnorm(3, 10, 2),
  판단력 = c(0.5, NA, 3),
  리더쉽 = runif(3, 1, 5),
  사교성 = c(5, 2.5, 4)
)

data2 = rbind(layout, data1)
op = par(mar = c(1, 0.5, 3, 1), mfrow = c(2, 2)) # mar : 여백 조정 mfrow : 몇행 몇열
radarchart(data2, axistype = 1, seg = 5, plty = 1, title = "1st")
radarchart(data2, axistype = 2, pcol = topo.colors(3), plty = 1, title = "2nd")
radarchart(data2, axistype = 3, pty = 32, plty = 1, axislabcol = 'grey', na.itp = F, title = "3rd")
radarchart(data2, axistype = 0, plwd = 1:5, pcol = 1, title = "4th")

# 저수준 작도
# points()
# lines(), segments(), abline()
# grid()
# arrows()
# rect()
# text(), mtext(), title()
# box(), axis()
# legend()
# polygon()
plot(1:15)
abline(h = 8)
rect(1, 6, 3, 8)
arrows(1, 1, 5, 5)
text(8, 9, "TEXT")
title("THIS IS TITLE", "SUB")

# ggplot2() : plot()의 확장 버전
install.packages("ggplot2")
library(ggplot2)
kor = read.table("학생별국어성적_new.txt", header = T, sep = ",")
kor

ggplot(kor, aes(x = 이름, y = 점수)) + geom_point()
# ggplot(dataframe, aes(x = x축데이터, y = y축데이터)) + geom_함수
# geom부분에 설정 값
# - stat : 주어진 데이터에서 geom에 필요한 데이터를 생성
# - stat_bin  : 아래와 같은 데이터를 갖는 데이터프레임 출력
#   1. count  : 각 항목의 빈도수
#   2. denity : 각 항목의 밀도수
#   3. ncount : count와 같으나 값의 범위가 (0, 1)로 스케일링 됨
#   4. ndensity : density와 같으나 값의 범위가 (0, 1)로 스케일링 됨
#   - 위 설정값을 지정하지 않으면 기본값은 count

# geom_bar()
gg = ggplot(kor, aes(x = 이름, y = 점수)) + geom_bar(stat = 'identity', fill = 'green', color = 'red') # stat = 'identity' : x축과 y축이 모두 존재한다
gg + theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1, color = 'blue', size = 8))

kem = read.csv("학생별과목별성적_국영수_new.csv", header = T)
kem

s1 = arrange(kem, 이름, 과목)
s1

s2 = ddply(s1, "이름", transform, 누적합계 = cumsum(점수))
s2

s3 = ddply(s2, "이름", transform, 누적합계 = cumsum(점수), label = cumsum(점수)-0.5*점수)
s3

# 글자와 그림이 찍히는 순서가 다르기 때문에 reverse가 먹히지 않았음
# position = position_stack() 사용
ggplot(s3, aes(x = 이름, y = 점수, fill = 과목)) + geom_bar(stat = 'identity', position = position_stack(reverse = T)) + geom_text(aes(y = label, label = paste(점수, "점")), color = 'black', size = 4) + guides(fill = guide_legend(reverse = T)) + theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1, colour = 'black', size = 8))


# geom_segment()
sc = read.table("학생별전체성적_new.txt", header = T, sep = ",")
sc
sc[, c("이름", "영어")]

gg = ggplot(sc, aes(x = 영어, y = reorder(이름, 영어)))
gg + geom_point(size = 6) + theme_bw() + theme(panel.grid.major.x = element_blank(), panel.grid.minor.x = element_blank(), panel.grid.major.y = element_line(color = 'red', linetype = 'dashed'))

gg + geom_segment(aes(yend = 이름), xend = 0, color = 'blue') + geom_point(size = 6, color = 'green') + theme_bw() + theme(panel.grid.major.y = element_blank())

# geom_point()
install.packages("gridExtra")
library(gridExtra)
mt = mtcars
View(mt)

g1 = ggplot(mt, aes(x = hp, y = mpg))
g1 + geom_point()

g2 = g1 + geom_point(color = 'blue')
g2

g3 = g2 + geom_point(aes(color = factor(am)))
g3

g4 = g3 + geom_point(size = 7)
g4

g5 = g1 + geom_point(aes(size = wt))
g5

g6 = g1 + geom_point(aes(shape = factor(am), size = wt, color = factor(am))) + scale_color_manual(values = c('red', 'green'))
g6

g7 = g6 + geom_line()
g7

g8 = g7 + labs(x = "마력", y = "연비")
g8

# geom_line()
th = read.csv("학생별과목별성적_3기_3명.csv", header = T)
th

s1 = arrange(th, 이름, 과목)
s1

ggplot(s1, aes(x = 과목, y = 점수, color = 이름, group = 이름)) + geom_line() + geom_point()
ggplot(s1, aes(x = 과목, y = 점수, color = 이름, group = 이름)) + geom_line() + geom_point(size = 5, shape = 21) # shape = 0 ~ 25

# geom_area()
dis = read.csv("1군전염병발병현황_년도별.csv")
dis

ggplot(dis, aes(x = 년도별, y = 장티푸스, group = 1)) + geom_line() # group 의 값에 의미가 없음..
ggplot(dis, aes(x = 년도별, y = 장티푸스, group = 1)) + geom_area()
ggplot(dis, aes(x = 년도별, y = 장티푸스, group = 1)) + geom_area(color = 'red', fill = 'cyan', alpha = 0.3)



data(mpg)
head(mpg)

# 1. ggplot2 : 배경설정 / 축 범위(x = displ, y = hwy) / 색, 표식 등 추가
ggplot(mpg, aes(x = displ, y = hwy))

# 2. x축 y축 데이터를 입력 / geom_point 형태로 구현
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point()

# 3. x축 3 ~ 6까지 / y축은 10 ~ 30까지만 출력
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() + xlim(3, 6) + ylim(10, 30)

# 4. 상자 수염 그림
ggplot(mpg, aes(x = displ, y = hwy)) + geom_boxplot()


# [데이터 분석]
# 1. 패키지 준비
# 2. 데이터 준비
# 3. 데이터 검토
# 4. 변수명 바꾸기
# 5. 데이터 분석 절차
#   5.1 변수 검토 및 전처리
#   5.2 변수간 관계 분석
# 6. 시각화

# 1. 패키지 준비
install.packages("foreign")
library(foreign)
library(dplyr)
library(ggplot2)
library(readxl)

# 2. 데이터 준비
wel1 = read.spss(file = "Koweps_hpc10_2015_beta1.sav", to.data.frame = T)
wel1
View(wel1)
wel2 = wel1

# 3. 데이터 검토
View(wel2)
dim(wel2) # 행과 열 조회
str(wel2) # 구조 보기
summary(wel2) # 요약

# 4. 변수명 바꾸기
wel2 = dplyr::rename(wel2,
              gender = h10_g3,
              birth = h10_g4,
              married = h10_g10,
              religion = h10_g11,
              income = p1002_8aq1,
              code_job = h10_eco9,
              code_region = h10_reg7)
View(wel2)

# 5. 데이터 분석 절차
#   5.1 변수 검토 및 전처리
# [gender에 대한 전처리]
class(wel2$gender) # 타입 조회

# 이상치 확인
table(wel2$gender) # gender의 빈도수 조회

# 변수별로 결측치 확인
table(is.na(wel2$gender))

# 이상치 결측 처리(현재 파일은 결측이 처리된 파일)
wel2$gender = ifelse(wel2$gender == 9, NA, wel2$gender)
table(is.na(wel2$gender))

# 성별 항목이름
wel2$gender = ifelse(wel2$gender == 1, "남성", "여성")
table(wel2$gender)
qplot(wel2$gender)


class(wel2$income)
hist(wel2$income)
summary(wel2$income)
qplot(wel2$income) + xlim(0, 1000)

wel2$income = ifelse(wel2$income %in% c(0, 9999), NA, wel2$income)
table(is.na(wel2$income))

#   5.2 변수간 관계 분석
gen_in = wel2 %>%
  filter(!is.na(income)) %>%
  group_by(gender) %>%
  summarise(mean_income = mean(income))

gen_in = wel2 %>%
  filter(!is.na(income)) %>%
  group_by(gender) %>%
  summarise_each(funs(mean), income) # 값이 하나로 나온 경우 이 방법 사용!

gen_in

# 6. 시각화
ggplot(gen_in, aes(x = gender, y = income)) + geom_col()


# 성별 월급 차이를 연령대별로 분석
class(wel2$birth)
summary(wel2$birth)
wel2$age = 2015 - wel2$birth + 1
summary(wel2$age)
qplot(wel2$age)


age_in = wel2 %>%
  filter(!is.na(income)) %>%
  group_by(age) %>%
  summarise_each(funs(mean), income)
age_in

ggplot(age_in, aes(x = age, y = income)) + geom_line()

wel3 = wel2 %>%
  mutate(ageg = ifelse(age < 30, 'young', ifelse(age < 59, 'middle', 'old')))
table(wel3$ageg)

ageg_in = wel3 %>%
  filter(!is.na(income)) %>%
  group_by(ageg) %>%
  summarise_each(funs(mean), income)
ageg_in


gender_in = wel3 %>%
  filter(!is.na(income)) %>%
  group_by(ageg, gender) %>%
  summarise_each(funs(mean), income)
gender_in


ggplot(gender_in, aes(x = ageg, y = income, fill = gender)) + geom_col(position = 'dodge') + scale_x_discrete(limits = c('young', 'middle', 'old'))

gender_age = wel3 %>%
  filter(!is.na(income)) %>%
  group_by(age, gender) %>%
  summarise_each(funs(mean), income)

ggplot(gender_age, aes(x = age, y = income, col = gender)) + geom_line()
