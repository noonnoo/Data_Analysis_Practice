#문제1-1
coffee <- matrix(c(31,23,21,10,18,23,52,32,12,29), nrow=2, byrow=TRUE)
rownames(coffee)=c("20s","30s")
colnames(coffee)=c("A","B","C","D","E")

par(mfrow=c(1,2))
age <- barplot(coffee, col=c("pink","skyblue")
        , main = "Prefered coffee brand by age1"
        , legend=rownames(coffee), ylim=c(0,90))
a = apply(coffee,2,sum)
text(x=age,y=a,labels=coffee[2,],pos=1)
text(x=age,y=coffee[1,],labels=coffee[1,],pos=1)

brand <-barplot(t(coffee),col=c("aquamarine2","bisque3","blueviolet","cadetblue1","coral")
        , main="Prefered coffee brand by age2",xlab="Age",ylab="Response"
        , ylim = c(0,180))
legend("topleft",c("A","B","C","D","E"),fill=c("aquamarine2","bisque3","blueviolet","cadetblue1","coral"))
b = apply(coffee,1,sum)
text(x=brand,y=b,labels=b,pos=3)

#문제1-2
lab20 = paste(colnames(coffee), ":", coffee[1,])
lab30 = paste(colnames(coffee), ":", a-coffee[1,])
pie(coffee[1,], labels=lab20, main="20s prefered coffee brand")
pie(coffee[2,], labels=lab30, main="30s prefered coffee brand")


prop20 <- round(coffee[1,]/sum(coffee[1,]) * 100, digit = 2)
prop30 <- round(coffee[2,]/sum(coffee[2,]) * 100, digit = 2)
lab20_p <- paste(colnames(coffee), ":", prop20,"%")
lab30_p <- paste(colnames(coffee), ":", prop30,"%")
pie(prop20, labels=lab20_p, main="20s prefered coffee brand")
pie(prop20, labels=lab30_p, main="30s prefered coffee brand")


#문제1-3
#귀무가설: age와 brand는 독립변수이다.

age2 <- rep(rownames(coffee),each=5)
brand2 <- rep(colnames(coffee),2)
preference <- c(31,23,21,10,18,23,52,32,12,29)
age_brand<-data.frame(brand2,age2,preference)
age_brand
qq <- xtabs(preference~age2+brand2, age_brand)
summary(qq)

#귀무가설 기각 --> 두 변수는 종속적이다
#나이와 브랜드 선호도 사이에는 관련성이 있다.
