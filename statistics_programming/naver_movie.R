library(rvest)
library('dplyr')

#네이버 영화 현재 상영영화 홈페이지 크롤
url <- "https://movie.naver.com/movie/running/current.nhn?order=reserve"
content <- read_html(url, encoding="UTF-8")
mv_list <- html_node(content, ".lst_wrap")

#영화 제목, 평점, 예매율, 장르 가져오기기
title <- html_nodes(mv_list, "dt.tit a") %>% html_text
star_rate <- html_nodes(mv_list, ".info_star .star_t1 .num") %>% html_text
reservation_rate <- html_nodes(mv_list, ".star") %>% html_node(".info_exp .star_t1 .num") %>% html_text
genre <- html_nodes(mv_list, ".info_txt1") %>% html_node(".link_txt") %>% html_node("a") %>% html_text

#숫자형으로 바꾸기
star_rate <- as.numeric(star_rate)
reservation_rate <- as.numeric(reservation_rate)

#데이터 프레임 생성
mv_df <- data.frame(title, star_rate, reservation_rate, genre)

#장르 넘버와 머지
genre_num <- read.table("genre_num.txt", encoding = "UTF-8")
colnames(genre_num) <- c("genre", "genre_num")
mv_df <- merge(mv_df, genre_num, by="genre")

str(mv_df)
#######################################################################################

#통계분석- 평점의 평균과 분산, 기술통계
mean(mv_df$star_rate)     #평균: 8.027062
var(mv_df$star_rate)      #분산: 2.67318
quantile(mv_df$star_rate) 

#평점의 히스토 그램
hist(mv_df$star_rate, main="현재 상영 영화 평점", xlab="영화 평점")   #히스토그램


#전체 영화 평점의 상자그림
boxplot(mv_df$star_rate,
        main="현재 상영 영화 평점",
        xlab="영화 평점 빈도",
        ylab="영화 평점",
        horizontal=TRUE)

#장르별 영화 상자그림
boxplot(star_rate~genre_num,
        data=mv_df,
        main="영화 장르별 평점",
        xlab="영화 장르",
        ylab="영화 평점",
        col = topo.colors(17),
        names=genre_num$genre)
abline(h = median(mv_df$star_rate), col = "red", lty=5, lwd=3)  #중간값 선 그어주기기

#장르 워드클라우드
library(wordcloud) 
library(RColorBrewer)
pal<-brewer.pal(8,'Accent')     ## 팔레트 색 지정

genre_num$count <- table(mv_df$genre_num)
wordcloud(words= genre_num$genre,
          freq = genre_num$count,
          scale=c(6, 2),  
          random.order=F,
          min.freq = 1,
          max.words = 17,
          colors=pal)

#영화 예매율 워드 클라우드
pal2<-brewer.pal(5,'Dark2')    ## 팔레트 색 지정
mv_df[is.na(mv_df)] <- 0    #결측값 0으로 대체

wordcloud(words= mv_df$title,
          freq = mv_df$reservation_rate,
          scale=c(8, 1.5),  
          random.order=F,
          min.freq = 0,
          max.words = 20,
          colors=pal2)      #20위 안의 영화를 워드클라우드로 확인




