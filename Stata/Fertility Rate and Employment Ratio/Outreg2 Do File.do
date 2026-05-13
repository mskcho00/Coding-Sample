reg fertrate employtopop if Time==2009, r
outreg2 using "outreg2_final.doc", replace title("Regression Results") adjr2 addtext(Country FE, NO, Year FE, NO)
*shellout using `"outreg2_final.doc"'
reg fertrate employtopop grosssav GDPpercap_in_thousand realintrate urban_in_tenthousand ctrlcorrupt if Time==2009, r
outreg2 using "outreg2_final.doc", adjr2 addtext(Country FE, NO, Year FE, NO)
reg fertrate employtopop GDPpercap_in_thousand employment_gdp if Time==2009, r
outreg2 using "outreg2_final.doc", adjr2 addtext(Country FE, NO, Year FE, NO)
reg fertrate employtopop employment_sqr GDPpercap_in_thousand urban_in_tenthousand ctrlcorrupt employment_gdp if Time==2009, r
outreg2 using "outreg2_final.doc", adjr2 addtext(Country FE, NO, Year FE, NO)
xtreg fertrate employtopop GDPpercap_in_thousand employment_gdp urban_in_tenthousand ctrlcorrupt, r fe
outreg2 using "outreg2_final.doc", adjr2 addtext(Country FE, YES, Year FE, NO)
*shellout using `"outreg2_final.doc"'
xtreg fertrate employtopop GDPpercap_in_thousand employment_gdp i.Time, r fe
outreg2 using "outreg2_final.doc", title("Regression Results") adjr2 keep(employtopop  GDPpercap_in_thousand employment_gdp 2009.Time) addtext(Country FE, YES, Year FE, YES)
*shellout using `"outreg2_final.doc"'