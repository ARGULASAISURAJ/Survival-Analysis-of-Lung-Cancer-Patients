#' Survival Analysis000
#' LungCancer.txt # 137 patients with advanced, inoperable lung cancer were treated with chemotherapy (standard)
# Veteran's Administration Lung Cancer Trial 
# or chemotherapy combined with a new drug (test). 
# Source: Kalbfleisch and Prentice (pp. 223-224)
# Variables:
# Treatment 1=standard, 2=test 
# Cell type 1=squamous, 2=small cell, 3=adeno, 4=large 
# Survival in days 
# Status 1=dead, 0=censored 
# Karnofsky score (measure of general performance, 100=best) 
# Months from Diagnosis 
# Age in years 
# Prior chemotherapy 0=no, 10=yes 
#' Objective: To model the time to Survival rate and Hazard rate for Lung Cancer Patients

#' Y: Time(Survival_in_days), Event(Status) (Number of days till death)  
#' X: Treatment,Cell_type,Karnofsky_Score,Months_from_Diagnosis,Age,Prior_chemotherapy

setwd("D:/USF CourseWork/ISM 6137 SDM/Class 8")
d <- read.table("LungCancer.txt")
colnames(d) <- c("Treatment","Cell_type","Survival_in_days","Status","Karnofsky_score"
                  ,"Months_from_Diagnosis","Age","Prior_chemotherapy")
str(d)
#View(d)
attach(d)


# Descriptive statistics
length(unique(Survival_in_days))                 # Count of unique values in the Time Column
unique(Survival_in_days)                         # 20 unique times in the sample: 1-28 
summary(Survival_in_days)
table(d$Status)
hist(d$Karnofsky_score)
hist(d$Age)
hist(d$Months_from_Diagnosis)
hist(log(d$Months_from_Diagnosis))
d$Treatment<-as.factor(d$Treatment)
d$Treatment<-relevel(d$Treatment,ref="1")
table(d$Treatment)
str(d$Treatment)
d$Cell_type<-as.factor(d$Cell_type)
d$Cell_type<-relevel(d$Cell_type,ref="1")
table(d$Cell_type)

d$Prior_chemotherapy<-as.factor(d$Prior_chemotherapy)
d$Prior_chemotherapy<-relevel(d$Prior_chemotherapy,ref="0")
table(d$Prior_chemotherapy)

# Kaplan-Meier non-parametric analysis
# Group data based on Time and estimate KM survival function based on Event
#install.packages("survival")
library(survival)
library(ggplot2)
library(survminer)
library(ranger)
library(dplyr)
library(ggfortify)

km1 <- survfit(Surv(Survival_in_days, Status) ~ 1)      
summary(km1)
ggsurvplot(km1, data = d, pval = TRUE)
plot(km1, xlab="Time", ylab="Survival Probability")

#From the Plot we can see Survial probability decreases as the days passesfor a Cancer Patient

#1. We would like to see Kaplan-Meier survival graphs for patients with the test vs standard treatment.
#Use this data to assess:

#a. What is the probability that the patient will survive for 1 year (365 days) 
#and 6 months (183 days) on the standard treatment vs the test treatment?

# Kaplan-Meier non-parametric analysis by group
km2 <- survfit(Surv(Survival_in_days, Status) ~ Treatment)
summary(km2)
#ggsurvplot(km2, data = d, pval = TRUE)
ggsurvplot(km2, data = d)
#plot(km2, xlab="Time", ylab="Survival Probability")

#From the above graph we can see that with test treatment the survival probability is more in a long run, 
#which means the test is giving positive results on  lung cancer patients only after a certain period of time.

#After 1 year(365 days), the survival probabilty of patient with standard treatment is approximately ~0.6 
#whereas the survival probabilty of patients with Test drug is 0.10 which shows positive effects of Drug under test after a year.

#After 6 months(183 days), the survival probabilty of patient with standard treatment is approximately ~0.20
#and the survival probabilty of patients with Test drug is 0.21 approximately equal,
#which shows Drug under test has no significant effects on patients in 6 months(short term).

#b. What is the mean number of days where a patient can be expected 
#to survive if they are on the standard vs the test treatment.

#At Survival probabilty 0.50, i.e, patient under standard treatment are expected 
#to survive for 100 days, and patients under test tratment are expected to be about 52 days.

# Nelson-Aalen non-parametric analysis
na <- survfit(coxph(Surv(Survival_in_days, Status) ~ Treatment), type="aalen")
summary(na)
plot(na, xlab="Time", ylab="Survival Probability")

#2. Create three semi-parametric and parametric models to estimate the 
#marginal effects of relevant predictors on survival outcomes. Interpret
#the coefficients of these models to explain the precise effects of age 
#and months of diagnosis on survival probabilities of patients with 
#standard and test treatments.

# Cox proportional hazard model - coefficients and hazard rates
cox <- coxph(Surv(Survival_in_days, Status) ~ as.factor(Treatment) + Age + as.factor(Cell_type) + Karnofsky_score + Months_from_Diagnosis + as.factor(Prior_chemotherapy), method="breslow")
summary(cox)

#Patients with test treatment will more likely die soon. People with test treatment increases hazard rate by 33% 
#Patients with Cell_Type "3" are more likely to die soon,with an increase in hazard rate by 228% compared to call_type "1".
#followed by cell_Type 2, Cell_Type 4, with an increase in hazard rate by 135% and 49% respectively.
#Patients with more months of Diagnosis has approximately no effect on death.
#Increase in Age has approximately no effect on death 
#Patients with increasing karnofsky_score are likely to live more and with hazard rate decrease by 4%.  
#Patients with Prior Chemotherepy has approximately no effect on death.


# Exponential, Weibull, and log-logistic parametric model coefficients
exp <- survreg(Surv(Survival_in_days, Status) ~ as.factor(Treatment) + Age + as.factor(Cell_type) + Karnofsky_score + Months_from_Diagnosis + as.factor(Prior_chemotherapy), dist="exponential")
summary(exp)

weibull <- survreg(Surv(Survival_in_days, Status) ~ as.factor(Treatment) + Age + as.factor(Cell_type) + Karnofsky_score + Months_from_Diagnosis + as.factor(Prior_chemotherapy), dist="weibull")
summary(weibull)

loglogistic <- survreg(Surv(Survival_in_days, Status) ~ as.factor(Treatment) + Age + as.factor(Cell_type) + Karnofsky_score + Months_from_Diagnosis + as.factor(Prior_chemotherapy), dist="loglogistic")
summary(loglogistic)

library(stargazer)
stargazer(cox, exp, weibull, loglogistic, type="text")

# Comparision of models
# 