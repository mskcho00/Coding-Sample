reg ln_fert employtopop if Time==2009, r
/*
Linear regression                               Number of obs     =        187
                                                F(1, 185)         =       3.29
                                                Prob > F          =     0.0712
                                                R-squared         =     0.0219
                                                Root MSE          =     .48733

------------------------------------------------------------------------------
             |               Robust
     ln_fert | Coefficient  std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
 employtopop |   .0063754   .0035132     1.81   0.071    -.0005557    .0133065
       _cons |   .6175411   .2000462     3.09   0.002     .2228759    1.012206
------------------------------------------------------------------------------
*/

. predict ln_fert_hat
*(option xb assumed; fitted values)
*(541 missing values generated)

. gen e_ln_fert_hat=exp(ln_fert_hat)
*(541 missing values generated)

. predict uhat, residuals
*(727 missing values generated)

. gen e_uhat = exp(uhat)
*(727 missing values generated)

. egen alpha=mean(e_uhat)

. gen adjusted_fertilityhat = e_ln_fert_hat * alpha

. corr adjusted_fertilityhat fertrate
/*
             | adjust~t fertrate
-------------+------------------
adjusted_f~t |   1.0000
    fertrate |   0.1355   1.0000
*/
. di 0.1355*0.1355
*.01836025

. reg ln_fert employtopop if Time==2009, r

. *ln(y) on x WINS!