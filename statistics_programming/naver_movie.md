0. 자료 준비
 
[네이버의 현재 상영 영화 페이지](https://movie.naver.com/movie/running/current.nhn?order=reserve)의 영화 목록 중 제목, 평점, 예매율, 대표장르1개를 크롤링해와서 mv_df라는 데이터 프레임을 만듦.  
아래는 mv_df의 구조입니다.
``` R
> str(mv_df)
'data.frame':	177 obs. of  5 variables:
  $ genre           : chr  "SF" "가족" "가족" "공연실황" ...
$ title           : chr  "코마" "담쟁이" "철원기행" "미스터트롯: 더 무비" ...
$ star_rate       : num  7.79 8.36 7.87 8.84 9.2 8.51 7.2 6.37 8.91 7.93 ...
$ reservation_rate: num  0.01 0.07 0.01 0.09 0 ...
$ genre_num       : int  0 1 1 2 2 3 3 3 3 3 ...
```  


1. 그래프(히스토그램, 상자그림)  
``` R
#평점의 히스토 그램
hist(mv_df$star_rate, main="현재 상영 영화 평점", xlab="영화 평점")   #히스토그램
```
![image](https://user-images.githubusercontent.com/33820372/100452393-65a2ec00-30fc-11eb-9bed-49f390e94c69.png)  

---

```R
#전체 영화 평점의 상자그림
boxplot(mv_df$star_rate,
        main="현재 상영 영화 평점",
        xlab="영화 평점 빈도",
        ylab="영화 평점",
        horizontal=TRUE)
```  
![image](https://user-images.githubusercontent.com/33820372/100452422-75223500-30fc-11eb-8685-25460968f2ea.png)  

---

```R
#장르별 영화 상자그림
boxplot(star_rate~genre_num,
        data=mv_df,
        main="영화 장르별 평점",
        xlab="영화 장르",
        ylab="영화 평점",
        col = topo.colors(17),
        names=genre_num$genre)
abline(h = median(mv_df$star_rate), col = "red", lty=5, lwd=3)  #중간값 선 그어주기기
```
![image](https://user-images.githubusercontent.com/33820372/100452564-ba466700-30fc-11eb-81cc-5ebd74569743.png)  

---

2. 통계분석 (평균, 분산, 4분위수)
```R
> #통계분석- 평점의 평균과 분산, 기술통계
> mean(mv_df$star_rate)     #평균: 8.027062
[1] 8.056441
> var(mv_df$star_rate)      #분산: 2.67318
[1] 2.3582
> quantile(mv_df$star_rate) 
0%  25%  50%  75% 100% 
0.00 7.60 8.46 8.99 9.76
```  

3. 워드 클라우드 그리기
```R
wordcloud(words= genre_num$genre,
          freq = genre_num$count,
          scale=c(6, 2),  
          random.order=F,
          min.freq = 1,
          max.words = 17,
          colors=pal)
```
![image](https://user-images.githubusercontent.com/33820372/100452662-f11c7d00-30fc-11eb-8897-798a2a6d84c6.png)  

---

```R
wordcloud(words= mv_df$title,
          freq = mv_df$reservation_rate,
          scale=c(8, 1.5),  
          random.order=F,
          min.freq = 0,
          max.words = 20,
          colors=pal2
```  
![image](https://user-images.githubusercontent.com/33820372/100452716-08f40100-30fd-11eb-9cd2-ab8cc3d21844.png)  
