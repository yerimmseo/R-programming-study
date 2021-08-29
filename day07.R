library(dplyr)
# library(plyr)
library(googleVis)
library(devtools)
library(lubridate)
library(stringr)
library(ggplot2)
library(RColorBrewer)
library(wordcloud)

Sys.setenv(JAVA_HOME="C:\Program Files\Java\jdk1.8.0_271")
library(rJava)
setwd("d:/2021_march_micro_yerimseo/R/r_data")

install.packages("multilinguer")
library(multilinguer)
install.packages(c('stringr', 'hash','tau','Sejong','RSQLite','devtools'), type = 'binary')

install.packages('remotes')
remotes::install_github("haven-jeon/KoNLP", upgrade = 'never', INSTALL_opts=c("--no-multiarch"), force=TRUE)
library(KoNLP)

useSejongDic()


# 워그클라우드
# 1. 데이터에서 단어만 추출
# 2. 단어 집합 생성
# 3. 단어 필터링
# 4. 단어 핸들링
# 5. txt파일로 저장하고 table로 읽어오면서 공백제거
# 6. 단어 빈도수 저장
# 7. wordcloud로 출력
# 8. 자바로딩 안될 때
#    Sys.setenv(JAVA_HOME="C:\Program Files\Java\jdk1.8.0_271")


# 1. 데이터에서 단어만 추출
d1 = readLines("BTS유엔연설_국문.txt")
d1
d2 = sapply(d1, extractNoun, USE.NAMES = F)
d2

# 2. 단어 집합 생성
d3 = unlist(d2)
d3

# 3. 단어 필터링
d3 = Filter(function(x) {
  nchar(x) <= 10
}, d3)
head(unlist(d3), 20)

# 4. 단어 핸들링
d3 = gsub("\\d+", "", d3) # 모든 숫자 없애기기
d3 = gsub("님", "", d3)
d3 = gsub("것", "", d3)
d3 = gsub("들", "", d3)
d3 = gsub("저", "", d3)
d3 = gsub("월", "", d3)
d3 = gsub("이", "", d3)
d3 = gsub("나", "자신", d3)
d3 = gsub("내", "자신", d3)
d3 = gsub("네", "너", d3)
d3 = gsub("나", "자신", d3)
d3 = gsub(" ", "", d3)
d3 = gsub("\\'", "", d3)
d3 = gsub("\\.", "", d3)
d3 = gsub("름", "", d3)
d3 = gsub("한", "", d3)
d3 = gsub("아", "", d3)
d3 = gsub("돌", "", d3)

# 5. txt파일로 저장하고 table로 읽어오면서 공백제거
write(unlist(d3), "BTS.txt")
d4 = read.table("BTS.txt")
d4

# 6. 단어 빈도수 저장
wc = table(d4)
wc
head(sort(wc, decreasing = T), 20)

# 7. wordcloud로 출력
pal = brewer.pal(9, "Set3")
wordcloud(names(wc), freq = wc, scal = c(5, 1), rot.per = 0.25, min.freq = 2, random.order = F, random.color = T, colors = pal)
legend(0.3, 1, "BTS 유엔연설문", cex = 0.8, fill = NA, border = NA, bg = 'white', text.col = 'red', text.font = 2, box.col = 'red')


d1 = readLines("remake.txt")
d1
d2 = sapply(d1, extractNoun, USE.NAMES = F)
d2

d3 = unlist(d2)
d3

d3 = Filter(function(x) {
  nchar(x) <= 10
}, d3)

d3 = gsub("\\d+", "", d3)
d3 = gsub("\\'", "", d3)
d3 = gsub("\\.", "", d3)
d3 = gsub('\\"', "", d3)
d3 = gsub("수", "", d3)
d3 = gsub("쌍수", "쌍꺼풀", d3)
d3 = gsub("쌍커풀", "쌍꺼풀", d3)
d3 = gsub("메부리코", "매부리코", d3)
d3

write(unlist(d3), "remake2.txt")
d4 = read.table("remake2.txt")
d4

nrow(d4)

wc = table(d4)
wc
head(sort(wc, decreasing = T), 20)

t1 = readLines("성형gsub.txt")
t1

i = 1
for (i in i:length(t1)) {
  d3 = gsub((t1[i]), "", d3)
}
d3

d3 = Filter(function(x) {
  nchar(x) <= 5
}, d3)
write(unlist(d3), "remake3.txt")
write(unlist(d3), "remake3.txt")
d4 = read.table("remake3.txt")
d4

pal = brewer.pal(9, "Set3")
wordcloud(names(wc), freq = wc, scale = c(5, 1), rot.per = 0.25, min.freq = 2, random.order = F, random.color = T, colors = pal)


library(stringr)

buildDictionary(user_dic = data.frame(readLines("제주도여행지.txt"), "ncn"))


t1 = readLines("jeju.txt")
p1 = sapply(t1, extractNoun, USE.NAMES = F)
p1
c1 = unlist(p1)
p1 = str_replace_all(c1, "[^[:alpha:]]", "")
p1 = gsub(" ", "", p1)
t2 = readLines("제주도여행코스gsub.txt")

i = 1
for (i in 1:length(t2)) {
  p1 = gsub((t2[i]), "", p1)
}
p1

p1 = Filter(function(x) {
  nchar(x) >= 2
}, p1)
p1
write(unlist(p1), "jeju2.txt")
p2 = read.table("jeju2.txt")
nrow(p2)
wc = table(p2)
wc

pal = brewer.pal(9, "Set3")
wordcloud(names(wc), freq = wc, scale = c(5, 1), rot.per = 0.25, min.freq = 2, random.order = F, random.color = T, colors = pal)



# 실습) 서울 명소 추천
# 원본 파일: seoul_go.txt
# gsub파일 : 서울명소gsub.txt
# merge파일 : 서울명소merge.txt


# 1. 데이터에서 단어만 추출

# 2. 단어 집합 생성

# 3. 단어 필터링

# 4. 단어 핸들링

# 5. txt파일로 저장하고 table로 읽어오면서 공백제거

# 6. 단어 빈도수 저장

# 7. wordcloud로 출력

buildDictionary(user_dic = data.frame(readLines("서울명소merge.txt"), 'ncn'))
user_dic

txt = readLines("seoul_go.txt")
p1 = sapply(txt, extractNoun, USE.NAMES = F)
p1

p2 = unlink(p1)
p3 = str_replace_all(p2, "[^[:alpha:]]", "")
p3 = gsub(" ", "", p3)

t1 = readLines("서울명소gsub.txt")
for (i in 1:length(t1)) {
  p3 = gsub((t1[i]), "", p3)
}
p3

p4 = Filter(function(x) {
  nchar(x) >= 2
}, p3)

p4

write(p4, "seoul2.txt")

p5 = read.table("seoul2.txt")
wc = table(p5)
wc

pal = brewer.pal(8, "set2")
wordcloud(names(wc), freq = wc, scale = c(5, 1), rot.per = 0.25, min.freq = 2, random.order = F, random.color = T, colors = pal)

install.packages("tm")
library(tm)

# 데이터 불러오기
d1 = readLines("steve.txt")
d1
class(d1)

# 말뭉치 변환
c1 = VCorpus(VectorSource(d1))
c1

# 말뭉치 안의 내용 보기
inspect(c1)

# term-document형식의 matrix로 변환
tdm = TermDocumentMatrix(c1)
tdm

# 사람이 볼 수 있는 matrix로 변환
m = as.matrix(tdm)
m

# 단어 핸들링
# 여러개의 공백을 하나로
c2 = tm_map(c1, stripWhitespace)

# 대문자를 소문자로
c2 = tm_map(c2, tolower)

# 숫자 제거
c2 = tm_map(c2, removeNumbers)

# 마침표, 콤마, 콜론, 세미콜론 등 문자제거
c2 = tm_map(c2, removePunctuation)

# 일반 문서로 변환
c2 = tm_map(c2,PlainTextDocument)

# 불용어(전치사, 접속사 ..) 제거 및 단어 추가
sw2 = c(stopwords('en'), 'and', 'but', 'not')
c2 = tm_map(c2, removeWords, sw2)

# 불용어 제거 후 재 생성
c3 = TermDocumentMatrix(c2)
c3
tdm2 = c3

m2 = as.matrix(tdm2)
m2
class(m2)

# 컬럼명 변경
colnames(m2) = c(1:59)
m2

# 단어별로 집계
f1 = sort(rowSums(m2), decreasing = T)
f1
head(f1, 20)

# 컬럼별로 집계
f2 = sort(colSums(m2), decreasing = T)
f2
head(f2, 20)

# 특정 횟수 이상의 언급 단어 찾기
findFreqTerms(tdm2, 2)

# 특정 단어와 상관관계인 언어
findAssocs(tdm2, 'apple', 0.5)
findAssocs(tdm2, 'iphone', 0.5)

# 워드클라우드
pal = brewer.pal(8, "Set2")
wordcloud(names(f1), freq = wc, scale = c(5, 1), rot.per = 0.25, min.freq = 2, random.order = F, random.color = T, colors = pal)

f3 = head(sort(f1, decreasing = T), 20)
barplot(f3, las = 2, ylim = c(0, 20))

d1 = readLines("jeju.txt")
d1
class(d1)


c1 = VCorpus(VectorSource(d1))

inspect(c1)
tdm = TermDocumentMatrix(c1)
tdm

m = as.matrix(tdm)
m

c2 = tm_map(c1, stripWhitespace)
c2 = tm_map(c2, tolower)
c2 = tm_map(c2, removeNumbers)
c2 = tm_map(c2, removePunctuation)
c2 = tm_map(c2, PlainTextDocument)
sw2 = c(stopwords('en'), "좋습니다", "곳이에요", "제주도", "하고", "온", "것", "있습니다")

c2 = tm_map(c2, removeWords, sw2)

c3 = TermDocumentMatrix(c2, control = list(wordLengths = c(1, 8)))
c3
tdm2 = c3

m2 = as.matrix(tdm2)
m2

colnames(m2) = c(1:1007)
dim(m2)
m2

f1 = sort(rowSums(m2), decreasing = T)
f1
head(f1, 20)

findAssocs(tdm2, '한라산', 0.5)
findAssocs(tdm2, "바람", 0.5)

pal = brewer.pal(8, "Set2")
wordcloud(names(f1), freq = wc, scale = c(5, 1), rot.per = 0.25, min.freq = 2, random.order = F, random.color = T, colors = pal)


# 비정형 데이터를 다양한 차트로 표현
buildDictionary(user_dic = data.frame(readLines("제주도여행지.txt"), "ncn"))


t1 = readLines("jeju.txt")
p1 = sapply(t1, extractNoun, USE.NAMES = F)
p1
c1 = unlist(p1)
p1 = str_replace_all(c1, "[^[:alpha:]]", "")
p1 = gsub(" ", "", p1)
t2 = readLines("제주도여행코스gsub.txt")

i = 1
for (i in 1:length(t2)) {
  p1 = gsub((t2[i]), "", p1)
}
p1

p1 = Filter(function(x) {
  nchar(x) >= 2
}, p1)
p1
p1 = gsub("까지", "", p1)

write(unlist(p1), "jeju2.txt")
p2 = read.table("jeju2.txt")
nrow(p2)
wc = table(p2)
wc

pal = brewer.pal(9, "Set3")
wordcloud(names(wc), freq = wc, scale = c(5, 1), rot.per = 0.25, min.freq = 2, random.order = F, random.color = T, colors = pal)

top10 = head(sort(wc, decreasing = T), 10)
top10

pct = round(top10/sum(top10)*100, 1)
lab = paste(names(top10), "\n", pct, "%")

pie(top10, main = "제주도 여행 코스 10", col = rainbow(10), cex = 0.8, labels = lab)

install.packages("plotrix")
library(plotrix)

pie3D(top10, main = "제주도 여행 코스 10", col = rainbow(10), cex = 0.8, labels = lab, explode = 0.05)

bp = barplot(top10, main = "제주도여행코스 톱10", col = rainbow(10), cex.names = 0.7, las = 1, ylim = c(0, 25))
text(x = bp, y = top10 * 0.95, labels = paste("(", pct, ")"), col = "black", cex = 0.7)
text(x = bp, y = top10 * 1.05, labels = paste(top10, "건"), col = "black", cex = 0.7)

top10_2 = rev(top10)
pct = round(top10_2/sum(top10_2)*100, 1)

# 막대 오름차순
bp = barplot(top10_2, main = "제주도여행코스 톱10", col = rainbow(10), cex.names = 0.7, las = 1, ylim = c(0, 25))
text(x = bp, y = top10_2 * 0.95, labels = paste("(", pct, ")"), col = "black", cex = 0.7)
text(x = bp, y = top10_2 * 1.05, labels = paste(top10, "건"), col = "black", cex = 0.7)

# 가로막대
bp = barplot(top10, main = "제주도여행코스 톱10", col = rainbow(10), cex.names = 0.7, las = 1, xlim = c(0, 25), horiz = T)
pct = round(top10/sum(top10)*100, 1)
text(y = bp, x = top10 * 0.95, labels = paste("(", pct, ")"), col = "black", cex = 0.7)
text(y = bp, x = top10 * 1.05, labels = paste(top10, "건"), col = "black", cex = 0.7)

# 가로막대 내림차순
top10_2 = rev(top10)
pct = round(top10_2/sum(top10_2)*100, 1)

bp = barplot(top10_2, main = "제주도여행코스 톱10", col = rainbow(10), cex.names = 0.7, las = 1, xlim = c(0, 25), horiz = T)

text(y = bp, x = top10_2 * 0.95, labels = paste("(", pct, "%", ")"), col = "black", cex = 0.7)

text(y = bp, x = top10_2 * 1.05, labels = paste(top10_2, "건"), col = "black", cex = 0.7)
