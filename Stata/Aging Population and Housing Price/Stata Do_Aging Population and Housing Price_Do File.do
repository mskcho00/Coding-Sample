* Summary Statistics Ready
summarize country_id year house_ind oad_r avg_salary core_cpi lt_ir net_save real_gdp unemp_rate
outreg2 using "EC406 Summary Statistics.doc", sum(log) replace
* Scatterplot
collapse (mean) house_ind oad_r, by(year)
twoway scatter house_ind oad_r, mlabel(year) mlabposition(3) title("OAD Ratio vs Real House Price Index") ytitle("Real House Price Index") xtitle("Old Age Dependency Ratio")
restore
* Create Pre/Post COVID Dummy for Table 3
gen period = 0 if year < 2020
 replace period = 1 if year >= 2020
 estpost ttest house_ind avg_salary oad_r core_cpi lt_ir net_save real_gdp unemp_rate, by(period) unequal
esttab using EC406_Table3_2.rtf, cells("mu_1(label(Pre-COVID (Mean)) fmt(2)) mu_2(label(Post-COVID (Mean)) fmt(2)) b(label(Difference) fmt(2)) p(label(p-value) fmt(3))")
* Regression (OLS)
reg house_ind oad_r, robust
outreg2 using "EC406 Reg.doc", replace ctitle("OLS")
reg house_ind oad_r avg_salary core_cpi lt_ir net_save real_gdp unemp_rate, robust
outreg2 using "EC406 Reg.doc", append ctitle("OLS")
* xtset
xtset country_id year
*Random Effects
xtreg house_ind oad_r avg_salary core_cpi lt_ir net_save real_gdp unemp_rate, re vce(cluster country_id)
outreg2 using "EC406 Reg.doc", append ctitle("RE") addtext(Entity FE, No, Year FE, No)
xtreg house_ind oad_r avg_salary core_cpi lt_ir net_save real_gdp unemp_rate i.year, re vce(cluster country_id)
outreg2 using "EC406 Reg.doc", append ctitle("RE") addtext(Entity FE, No, Year FE, Yes)
* Wald Test
xtreg house_ind oad_r avg_salary core_cpi lt_ir net_save real_gdp unemp_rate i.year, fe vce(cluster country_id)
xttest3
* Fixed Effects
xtreg house_ind oad_r avg_salary core_cpi lt_ir net_save real_gdp unemp_rate, fe vce(cluster country_id)
outreg2 using "EC406 Reg.doc", append ctitle("FE") addtext(Entity FE, Yes, Year FE, No)
xtreg house_ind oad_r avg_salary core_cpi lt_ir net_save real_gdp unemp_rate i.year, fe vce(cluster country_id)
outreg2 using "EC406 Reg.doc", append ctitle("FE") addtext(Entity FE, Yes, Year FE, Yes)
* Hausman Test
xtreg house_ind oad_r avg_salary core_cpi lt_ir net_save real_gdp unemp_rate i.year, re
estimates store re_model
xtreg house_ind oad_r avg_salary core_cpi lt_ir net_save real_gdp unemp_rate i.year, fe
estimates store fe_model
hausman fe_model re_model, sigmamore
* Additional Regressions
reg house_ind oad_r avg_salary core_cpi lt_ir net_save real_gdp, robust
outreg2 using "EC406 Reg2.doc", replace ctitle("OLS")
xtreg house_ind oad_r avg_salary lt_ir net_save real_gdp unemp_rate i.year, fe vce(cluster country_id)
outreg2 using "EC406 Reg2.doc", append ctitle("FE") addtext(Entity FE, Yes, Year FE, Yes)
xtreg house_ind oad_r avg_salary lt_ir net_save unemp_rate i.year, fe vce(cluster country_id)
outreg2 using "EC406 Reg2.doc", append ctitle("FE") addtext(Entity FE, Yes, Year FE, Yes)
