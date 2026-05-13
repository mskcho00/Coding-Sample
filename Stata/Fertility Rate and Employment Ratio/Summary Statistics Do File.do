estpost sum  fertrate employtopop grosssav GDPpercap_in_thousand realintrate urban_in_tenthousand femaleedu ctrlcorrupt
eststo: estpost sum  fertrate employtopop grosssav GDPpercap_in_thousand realintrate urban_in_tenthousand femaleedu ctrlcorrupt
esttab using sumstats_final.doc, main(mean) aux(sd) replace
esttab using sumstats_final.doc, main(mean) aux(sd) replace rtf nonotes addnote("mean coefficient, SD in parenthesis")
outreg2 using sumstats_final.doc, sum(log) keep( fertrate employtopop grosssav GDPpercap_in_thousand realintrate urban_in_tenthousand femaleedu ctrlcorrupt)
shellout using `"sumstats_final.doc"'