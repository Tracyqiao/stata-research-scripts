
use "final_employee_monthly_metrics_v2.dta", clear
describe 员工ID_x month
destring 员工ID_x, gen(empid) force
save "month_metrics_clean.dta", replace
import excel "绩效数据_with_engagement.xlsx", firstrow clear
describe 员工ID_x month
destring 员工ID_x, replace force
rename 员工id_x 员工ID_x
rename interaction_f~y interaction_frequency
rename interaction_d~h interaction_depth
rename avg_user_sent~e avg_user_sentiment_score
rename sentiment_var~e sentiment_variance
rename ai_engagement AI_Engagement
describe 员工ID_x month interaction_frequency interaction_depth AI_Engagement avg_user_sentiment_score
isid 员工ID_x month
save "perf.dta", replace
use "month_metrics_clean.dta", clear
describe 员工ID_x month
merge 1:1 员工ID_x month using "perf.dta"
tab _merge
keep if _merge==3
drop _merge
save "merged_panel.dta", replace
tab _merge
use "merged_panel.dta", clear
describe
describe 员工ID_x month sale log_sale ai_entropy ai_breadth is_new_employee is_high_perfor interaction_frequency interaction_depth AI_Engagement avg_user_sentiment_score city job_title
gen log_sale = ln(sale + 1)
sum sale log_sale
ttest ai_breadth, by(is_high_perfor)
ttest interaction_frequency, by(is_high_perfor)
ttest interaction_depth, by(is_high_perfor)
reg ai_breadth is_high_perfor male age edu tenure manager ind_experience i.city i.job_title, vce(cluster 员工ID_x)
reg interaction_frequency is_high_perfor male age edu tenure manager ind_experience i.city i.job_title, vce(cluster 员工ID_x)
reg interaction_depth is_high_perfor male age edu tenure manager ind_experience i.city i.job_title, vce(cluster 员工ID_x)
encode city, gen(city_id)
encode job_title, gen(job_id)
describe city city_id job_title job_id
reg ai_breadth is_high_perfor male age edu tenure manager ind_experience ///
    i.city_id i.job_id, vce(cluster 员工ID_x)
reg ai_breadth is_high_perfor male age edu tenure manager ind_experience i.city_id i.job_id, vce(cluster 员工ID_x)
reg interaction_frequency is_high_perfor male age edu tenure manager ind_experience ///
    i.city_id i.job_id, vce(cluster 员工ID_x)
reg interaction_depth is_high_perfor male age edu tenure manager ind_experience ///
    i.city_id i.job_id, vce(cluster 员工ID_x)
reg interaction_frequency is_high_perfor male age edu tenure manager ind_experience i.city_id i.job_id, vce(cluster 员工ID_x)
reg interaction_depth is_high_perfor male age edu tenure manager ind_experience i.city_id i.job_id, vce(cluster 员工ID_x)
gen log_sale = ln(sale + 1)
sum sale log_sale
describe avg_user_sentiment_score is_new_employee
mean avg_user_sentiment_score, over(is_new_employee)
ttest avg_user_sentiment_score, by(is_new_employee)
reg log_sale avg_user_sentiment_score male age edu tenure manager ind_experience i.city_id i.job_id, vce(cluster 员工ID_x)
reg log_sale c.avg_user_sentiment_score##i.is_new_employee ///
    male age edu tenure manager ind_experience ///
    i.city_id i.job_id, vce(cluster 员工ID_x)
reg log_sale c.avg_user_sentiment_score##i.is_new_employee male age edu tenure manager ind_experience i.city_id i.job_id, vce(cluster 员工ID_x)
gen log_sale = log(sale + 1)
reg log_sale ai_entropy ///
    male age edu tenure manager ind_experience ///
    i.city_id i.job_id, ///
    vce(cluster 员工ID_x)
reg log_sale ai_entropy ///
    male age edu tenure manager ind_experience ///
    i.city_id i.job_id, ///
    vce(cluster 员工ID_x)
reg log_sale ai_entropy male age edu tenure manager ind_experience i.city_id i.job_id, vce(cluster 员工ID_x)
reg ai_engagement ai_entropy male age edu tenure manager ind_experience i.city_id i.job_id, vce(cluster 员工ID_x)
‘
reg ai_engagement ai_entropy male age edu tenure manager ind_experience i.city_id i.job_id, vce(cluster 员工ID_x)
ds *engage*
describe
reg log_sale ai_entropy male age edu tenure manager ind_experience i.city_id i.job_id, vce(cluster 员工ID_x)
reg AI_Engagement ai_entropy male age edu tenure manager ind_experience i.city_id i.job_id, vce(cluster 员工ID_x)
reg log_sale ai_entropy AI_Engagement male age edu tenure manager ind_experience i.city_id i.job_id, vce(cluster 员工ID_x)
reg ai_breadth ///
    is_high_perfor ///
    male age edu tenure manager ind_experience ///
    i.city i.job_title, ///
    vce(cluster 员工ID_x)
reg ai_breadth is_high_perfor male age edu tenure manager ind_experience i.city i.job_title, vce(cluster 员工ID_x)
city: string variables may not be used as factor variables
r(109);
encode city, gen(city_id)
encode job_title, gen(job_id)
reg ai_breadth is_high_perfor male age edu tenure manager ind_experience i.city_id i.job_id, vce(cluster 员工ID_x)
margins is_new_employee, dydx(avg_user_sentiment_score)
margins is_new_employee, dydx(c.avg_user_sentiment_score)
reg log_sale c.AVGNAME##i.is_new_employee male age edu tenure manager ind_experience i.city_id i.job_id, vce(cluster 员工ID_x)
ds avg_user_sent*
rename avg_user_sent* avg_sent
reg log_sale c.avg_sent##i.is_new_employee male age edu tenure manager ind_experience i.city_id i.job_id, vce(cluster 员工ID_x)
bootstrap, reps(1000):
describe ai_entropy AI_Engagement log_sale
reg log_sale c.avg_sent##i.is_new_employee male age edu tenure manager ind_experience i.city_id i.job_id, vce(cluster 员工ID_x)
margins is_new_employee, dydx(avg_sent)
margins is_new_employee, dydx(avg_sent)
marginsplot
graph save "Graph" "/Users/tracyqiao/Documents/Graph.gph"
marginsplot, yline(0)
graph use "/Users/tracyqiao/Documents/Graph.gph"
reg AI_Engagement ai_entropy male age edu tenure manager ind_experience
    i.city_id i.job_id,
reg AI_Engagement ai_entropy male age edu tenure manager ind_experience
    i.city_id i.job_id, vce(cluster 员工ID_x)
reg AI_Engagement ai_entropy male age edu tenure manager ind_experience ///
    i.city_id i.job_id, vce(cluster 员工ID_x)
reg AI_Engagement ai_entropy male age edu tenure manager ind_experience i.city_id i.job_id, vce(cluster 员工ID_x)
scalar sobel_z = (a_s*b_s)/sqrt((b_s^2)*(sa_s^2) + (a_s^2)*(sb_s^2))
display sobel_z
display 2*(1-normal(abs(sobel_z)))
reg log_sale ai_entropy controls i.city i.job, vce(cluster 员工ID_x)
reg log_sale ai_entropy AI_Engagement controls i.city i.job, vce(cluster 员工ID_x)
reg log_sale ai_entropy male age edu tenure manager ind_experience i.city_id i.job_id, vce(cluster 员工ID_x)
export excel using "mydata.xlsx", replace firstrow(variables)
reg log_sale ai_entropy AI_Engagement male age edu tenure manager ind_experience i.city_id i.job_id, vce(cluster 员工ID_x)
estimates store m3
esttab m1 m2 m3 using "Table3.rtf", replace se star(* 0.1 ** 0.05 *** 0.01)
gen sample_reg = e(sample)
keep if sample_reg == 1
export excel using "Table3_sample.xlsx", replace firstrow(variables)
summarize interaction_frequency, detail
reg interaction_frequency is_high_perfor male age edu tenure manager ind_experience i.city_id i.job_id, vce(cluster 员工ID_x)
gen log_interaction_freq = log(interaction_frequency + 1)
reg log_interaction_freq is_high_perfor male age edu tenure manager ind_experience i.city_id i.job_id, vce(cluster 员工ID_x)
margins is_new_employee, dydx(avg_sent)
marginsplot, yline(0)
lincom avg_sent
reg log_sale c.avg_sent##i.is_new_employee ///
    male age edu tenure manager ind_experience ///
    i.city_id i.job_id, vce(cluster 员工ID_x)
reg log_sale c.avg_sent##i.is_new_employee male age edu tenure manager ind_experience i.city_id i.job_id, vce(cluster 员工ID_x)
lincom _b[avg_sent] + _b[1.is_new_employee#c.avg_sent]
save "merged_panel.dta", replace

