#문제2-1
par(mfrow=c(1,1))
week <- c("SUN","MON","TUE","WED","THU","FRI","SAT")
murder<-c(53,42,51,45,36,37,65)
murderbar <- barplot(murder,names.arg=week,col=terrain.colors(7),main="Murder cases by week",xlab="Date",ylab="Cases",ylim=c(0,100))
text(x=murderbar, y=murder, labels=murder, pos=3)

#문제2-2 적합도 검증 (모든 요일에 살인사건이 벌어질 확률이 같다)
p0 <-rep(1/7, 7)
p<-c(murder/sum(murder))

chisq.test(murder,p=p0)
#귀무가설 기각 --> 요일에 따라 살인사건 발생 횟수는 달라질 수 있다. 토요일이 제일 살인사건 발생수가 높음
