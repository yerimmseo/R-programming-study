library(dplyr)
# library(plyr)
library(googleVis)
library(devtools)
library(lubridate)
library(stringr)
library(ggplot2)
library(RColorBrewer)
library(wordcloud)
library(plotrix)
library(rJava)

setwd("d:/2021_march_micro_yerimseo/R/r_data")
library(KoNLP)
useSejongDic()

# '프로포즈 선물' 검색어 분석 결과를 그래프로 표시하기
# [원본 파일 일부 : propose.txt, gsub파일 : proposesub.txt]
# 프로포즈 선물로 받고 싶은 건수가 50이상이면 'red', 30이상이면 'yellow', 10 이상이면 'blue', 그 외는 'pink'로 차트의 색상을 나타내시오. 

txt = readLines("propose.txt")
pro = sapply(txt, extractNoun, USE.NAMES = F)
pro
c = unlist(pro)

pro2 = gsub("\\.", "", c)
pro2 = gsub("\\n", "", pro2)
pro2 = gsub("\\d+", "", pro2)
pro2 = gsub("\\^ㅎ\\^ㅎ", "", pro2)
txt = readLines("proposegsub.txt")
txt

for (i in 1:length(txt)) {
  pro2 = gsub((txt[i]), "", pro2)
}

pro2 = Filter(function(x) {
  nchar(x) <= 6
}, pro2) # nchar(x) >= 2 와 nchar(x) <= 6 두 번 다 사용

write(unlist(pro2), "pro_3.txt")
rev = read.table("pro_3.txt")
rev

wc = table(rev)
wc
a = head(sort(wc, decreasing = T), 10)
a

par(mfrow = c(2, 2))
colors = c()
for (i in 1:length(a)) {
  if (a[i] >= 50) {
    colors = c(colors, 'red')
  } else if (a[i] >= 30) {
    colors = c(colors, 'yellow')
  } else if (a[i] >= 10) {
    colors = c(colors, 'blue')
  } else {
    colors = c(colors, 'pink')
  }
}

bp = barplot(a, main = "프로포즈 top 10", col = colors, cex.names = 0.7, ylim = c(0, 60))
text(x=bp, y=a*1.05, labels = paste(a, "건"), col = "black", cex = 0.7)

names(a)
pct = round(a/sum(a)*100, 1)

lab = paste(names(a), "\n", pct, "%")
pie(a, main = "프로포즈 top 10", col = colors, cex = 0.8, labels = lab)

pal = brewer.pal(8, "Set2")
wordcloud(names(wc), freq = wc, scale = c(5,1), rot.per = 0.25, random.order = F, random.color = T, colors = pal)

pie3D(a, main = "프로포즈 top 10", col = colors, cex = 0.8, labels = lab)

d1 = read.csv("야구성적.csv", header = T)
d1

bp = barplot(d1$연봉대비출루율, main = paste("야구 선수별 연봉대비출루율", "\n"), col = rainbow(25), cex.names = 0.7, las = 2, names.arg = d1$선수명, ylim = c(0, 50))

title(ylab = "연봉대비출루율", col.lab = 'red')

avr = 0
for (i in 1:length(d1$연봉대비출루율)) {
  avr = avr + d1$연봉대비출루율[i]
}

avr
avr1 = avr/length(d1$연봉대비출루율)
avr1

abline(h = avr1, col = "blue")
text(x = avr1 - 11, y = 14.5, col = 'black', cex = 0.8, labels = paste(avr1, "%", "(평균출루율)"))
text(x = bp*1.01, y = d1$연봉대비출루율*1.05, col = "black", cex = 0.7, labels = paste(d1$연봉대비출루율, "%"))

d2 = read.csv("주요선수별성적-2013년.csv", header = T)
d2
View(d2)

row.names(d2) = d2$선수명

d3 = d2[, c(7, 8, 11, 12, 13, 14, 17, 19)]
d3

stars(d3, flip.labels = F, draw.segments = T, frame.plot = T, full = T, main = "야구선수별 주요 성적", key.loc = c(0.2, 11.5))

d4 = d2[, c(2, 21, 22)]
d4

l1 = d2$연봉대비출루율
l2 = d2$연봉대비타점율

par(mar = c(5, 4, 4, 4) + 0.1)
plot(l1, type = 'o', axes = F, ylab = "", xlab = "", ylim = c(0, 50), lty = 2, col = 'blue', main = "야구선수별 기록 분석", lwd = 2)
axis(1, at = 1:25, lab = d4$선수명, las = 2)
axis(2, las = 1)
par(new = T) # 그래프 겹쳐 그리기
plot(l2, type = 'o', axes = F, ylab = "", xlab = "", ylim = c(0, 50), lty = 2, col = 'red')
axis(4, las = 1)
mtext(side = 4, line = 2.5, "연봉대비타점율")
mtext(side = 2, line = 2.5, "연봉대비출루율")

abline(h = seq(0, 50, 5), v = seq(1, 25, 1), col = 'gray', lty = 2)
legend(18, 50, names(d2[21:22]), cex = 0.8, col = c('red', 'blue'), lty = 1, lwd = 2, bg = 'white')



# 데이터 분석
# 1. 패키지 준비
library(dplyr) # 데이터 전처리 및 가공 가능
library(plyr)
library(lubridate)
library(stringr)
library(ggplot2)

# 2. 데이터 준비
df = read.csv("전국문화축제표준데이터.csv")
View(df)

# 3. 데이터 검토
# 데이터 재구성 : 축제명, 축제시작일자, 축제종료일자, 소재지도로주소명, 경도, 위도
str(df)
df1 = data.frame(df[1], df[3:4], df[12], df[14:15])
df1
View(df1)

# 4. 변수명 바꾸기
cnt = length(df1)
cnt
names(df1)[cnt] = "LAT"
names(df1)[cnt - 1] = "LON"
View(df1)

# 5. 데이터 분석 절차
#    5-1. 변수검토 및 전처리
# 결측치, 이상치 처리
summary(df1)
nrow(df1)
df2 = df1[complete.cases(df1), ]
nrow(df2)
summary(df2)

cnt = 6
head(table(df2[cnt]))
head(df2[order(df2[cnt]),])
length(df2$축제명[df2$축제명] == "")
df2[df2 == ""] = NA
summary(df2)

df2 = df2[complete.cases(df2),]
df2[df2 == "-"] = NA
df2 = df2[complete.cases(df2),]
nrow(df2)

#    5.2. 변수간 관계분석
# 자료분류, 년도, 월별, 지역별
attach(df2)
str(df2)
df2$축제시작일자 = as.Date(df2$축제시작일자)
df2$축제종료일자 = as.Date(df2$축제종료일자)
str(df2)
df2$gigan = df2$축제종료일자 - df2$축제시작일자 + 1
str(df2$gigan)
df2$gigan = as.numeric(df2$gigan)
str(df2$gigan)
table(df2$gigan)

df2 = subset(df2, df2$gigan >= 0)
table(df2$gigan)

bigo = ifelse(df2$gigan >= 365, "1년이상", ifelse(df2$gigan >= 50, "50일이상", ifelse(df2$gigan == 1, "1일", "50일미만")))
df2 = cbind(df2, bigo)
View(df2)

# 패키지를 이용한 년도별, 월별 추출
df2$mm = month(df2$축제시작일자)
df2$mm
table(df2$mm)
hist(df2$mm)

df2$yy = year(df2$축제시작일자)
df2$yy
table(df2$yy)
hist(df2$yy)
df2 = subset(df2, df2$yy <= 2023)
table(df2$yy)
hist(df2$yy)

df2$day_week = wday(df2$축제시작일자, label = T)
df2$day_week
table(df2$day_week)
hist(df2$day_week)
qplot(df2$day_week)

colnames(df2)[4] = "주소"
View(df2)
주소 = str_split_fixed(df2$주소, " ", 2)
head(주소)
df2$주소 = 주소[, 1]
head(df2$주소)
View(df2)
summary(df2$주소)
table(df2$주소)

df2$주소 = as.factor(df2$주소)
table(df2$주소)
write.csv(df2, "축제.csv")
df3 = read.csv("축제.csv")

# 6. 시각화
plot(table(df3$yy))
plot(table(df3$yy), type = 'o')
plot(table(df3$yy), type = 'b', lty = 3, col = 2, pch = 5)

par(mfrow = c(1, 3))
plot(table(df3$yy), type = 'b', lty = 3, col = 2, pch = 5)
plot(table(df3$mm), type = 'o')
plot(table(df3$주소), type = 'h')
