# Survival-Analysis-of-Lung-Cancer-Patients
In this Project, I have analyzed the A/B testing experiment Lung cancer patient data with Survival models to check the effectiveness of Drug. 
I have used R programming to accomplish this task and the data is from Veteran's Adminstration Lung Cancer Trail.

Below are the observations-
---------------------------

![Observation](https://github.com/ARGULASAISURAJ/Survival-Analysis-of-Lung-Cancer-Patients/blob/main/Images/Survival%20Probability.PNG)

•	 In 1 year (365 days)- the survival probability of patient with standard treatment is approximately ~0.06 whereas the survival probability of patients with Test drug is 0.10 which shows positive effectiveness of Drug under test after a year (over a long period).

•	 In 6 months (183 days), the survival probability of patient with standard treatment is approximately ~0.20 and the survival probability of patients with Test drug is 0.21 approximately equal, which shows Drug under test has no significant effects on patients in 6 months (short term).

![Everyonr in group](https://github.com/ARGULASAISURAJ/Survival-Analysis-of-Lung-Cancer-Patients/blob/main/Images/Kaplan-Meier-Graph-all.PNG)

![By Individuaual treatment group](https://github.com/ARGULASAISURAJ/Survival-Analysis-of-Lung-Cancer-Patients/blob/main/Images/Kaplan-Meier-Graph-by-treatment.PNG)


# Non Parametric Model- Kaplan Meir Graph
•	 At Survival probability 0.50, i.e., patient under standard treatment are expected to survive for 100 days, and patients under test treatment are expected to be about 52 days. Test treatment is ineffective.

#From the above graph we can see that with test treatment the survival probability is more in a long run, which means the test is giving positive results on lung cancer patients only after a certain period of time.



# Semi Parametric Model--- Cox proportional hazard model - coefficients and hazard rates
Interpretation-
•	 Patients with test treatment will more likely die soon and increases hazard rate by 33% 
•	 Patients with Cell Type "3"/ adeno are more likely to die soon, with an increase in hazard rate by 228% followed by cell Type 2/ small cell, Cell Type 4/ large, with an increase in hazard rate by 135% and 49% respectively when compared to cell type "1"/ squamous. Adeno is deadly type of Cell.
•	Patients with more months of Diagnosis has approximately no effect on death.
•	Increase in Age has approximately no effect on death or (little evidence to tell elder people die soon)
•	Patients with increasing karnofsky_score is likely to live more and with hazard rate decrease by 4%.  Healthy people live longer with cancer.
•	Patients with Prior Chemotherapy will die soon and increases hazard rate by 7%.  Doctors/researchers need to check clinically with more experiment’s effects of Chemotherapy on cancer.

# Exponential, Weibull, and log-logistic parametric model coefficients
Interpretation 
From the above Summary, parametric models also suggest that 
•	Treatment 2(test) decreases time to death by a factor of 0.22(Exponential model), 0.23(Weibull model) 0.08 (Loglogistic model) i.e., test treatment is not preferred type of treatment.
•	Age increases time to death by a factor of 0.006(Exponential model), 0.006(Weibull model) 0.009 (Loglogistic model)., i.e. very negligible which suggests that age has no effect on time to death and treatment type.
•	Karnofsky score- with increase of this score by 1 point the time to death increase by a factor of 0.03(Exponential model), 0.03(Weibull model) 0.03 (Loglogistic model). Which suggest healthy people will survive for more days.
•	Months from Diagnosis-   increases time to death by a factor of 0.0003(Exponential model), 0.0005(Weibull model) 0.002 (Loglogistic model)., i.e. very negligible which suggests that months from diagnosis has no effect on time to death and treatment type.
•	Prior Chemotherapy- If a patient is treated early by chemotherapy, time to death is decreased by a factor of 0.05, (Exponential model),0.04 (Weibull model) 0.1 (Loglogistic model). 
•	Cell type - Patients with Cell type(3) decrease time to death by a factor of 1.11, (Exponential model),1.13 (Weibull model) 0.74 (Loglogistic model) followed by cell type(2) 0.82(Exponential model),0.82(Weibull model),0.7(Loglogistic model) cell type 4 0.38(Exponential model),0.40(Weibull model),(-0.017(Loglogistic model)~negligible) compared to cell type 1.
Cell type 3 is more deadly than type 2 followed type 4 and type1. 
