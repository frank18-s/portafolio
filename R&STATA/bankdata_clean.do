

drop in 3193/3194
drop in 3193/3195

reshape long YR, i(CountryCode SeriesName) j(year)

rename YR values

drop if missing(values)

drop if values ==".."

destring values, replace

replace SeriesCode = "GDP_pc" if SeriesCode == "NY.GDP.PCAP.KD"
replace SeriesCode = "Literacy_rate" if SeriesCode == "SE.ADT.LITR.ZS"
replace SeriesCode = "Edu_duration" if SeriesCode == "SE.COM.DURS"
replace SeriesCode = "Edu_exp_primary" if SeriesCode == "SE.XPD.CPRM.ZS"
replace SeriesCode = "Edu_exp_secondary" if SeriesCode == "SE.XPD.CSEC.ZS"
replace SeriesCode = "Edu_exp_total" if SeriesCode == "SE.XPD.CTOT.ZS"
replace SeriesCode = "Hospital_beds" if SeriesCode == "SH.MED.BEDS.ZS"
replace SeriesCode = "Physicians" if SeriesCode == "SH.MED.PHYS.ZS"
replace SeriesCode = "Water_mortality" if SeriesCode == "SH.STA.WASH.P5"
replace SeriesCode = "Health_exp_pc" if SeriesCode == "SH.XPD.CHEX.PC.CD"
replace SeriesCode = "Pop_65plus" if SeriesCode == "SP.POP.65UP.TO.ZS"
replace SeriesCode = "Urban_pop" if SeriesCode == "SP.URB.TOTL.IN.ZS"

drop SeriesName
drop CountryName

reshape wide values, i(year CountryCode) j(SeriesCode) string

rename valuesGDP_pc GDP_pc
rename valuesEdu_duration Edu_duration
rename valuesEdu_exp_primary Edu_exp_primary
rename valuesEdu_exp_secondary Edu_exp_secondary
rename valuesEdu_exp_total Edu_exp_total
rename valuesHospital_beds Hospital_beds
rename valuesHealth_exp_pc Health_exp_pc
rename valuesLiteracy_rate Literacy_rate
rename valuesPhysicians Physicians
rename valuesWater_mortality Water_mortality
rename valuesPop_65plus Pop_65plus
rename valuesUrban_pop Urban_pop



//////////////////
// Drop specific problematic or empty rows (possible duplicates or errors)
drop in 3193/3194
drop in 3193/3195

// Reshape data from wide to long format across years
reshape long YR, i(CountryCode SeriesName) j(year)

// Rename reshaped variable for clarity
rename YR values

// Drop rows with missing or placeholder values
drop if missing(values)
drop if values == ".."

// Convert string values to numeric
destring values, replace

// Recoding SeriesCode to meaningful variable names
replace SeriesCode = "GDP_pc" if SeriesCode == "NY.GDP.PCAP.KD"
replace SeriesCode = "Literacy_rate" if SeriesCode == "SE.ADT.LITR.ZS"
replace SeriesCode = "Edu_duration" if SeriesCode == "SE.COM.DURS"
replace SeriesCode = "Edu_exp_primary" if SeriesCode == "SE.XPD.CPRM.ZS"
replace SeriesCode = "Edu_exp_secondary" if SeriesCode == "SE.XPD.CSEC.ZS"
replace SeriesCode = "Edu_exp_total" if SeriesCode == "SE.XPD.CTOT.ZS"
replace SeriesCode = "Hospital_beds" if SeriesCode == "SH.MED.BEDS.ZS"
replace SeriesCode = "Physicians" if SeriesCode == "SH.MED.PHYS.ZS"
replace SeriesCode = "Water_mortality" if SeriesCode == "SH.STA.WASH.P5"
replace SeriesCode = "Health_exp_pc" if SeriesCode == "SH.XPD.CHEX.PC.CD"
replace SeriesCode = "Pop_65plus" if SeriesCode == "SP.POP.65UP.TO.ZS"
replace SeriesCode = "Urban_pop" if SeriesCode == "SP.URB.TOTL.IN.ZS"

// Drop unused columns
drop SeriesName
drop CountryName

// Reshape data back to wide format by indicator code
reshape wide values, i(year CountryCode) j(SeriesCode) string

// Rename variables for cleaner dataset
rename valuesGDP_pc GDP_pc
rename valuesEdu_duration Edu_duration
rename valuesEdu_exp_primary Edu_exp_primary
rename valuesEdu_exp_secondary Edu_exp_secondary
rename valuesEdu_exp_total Edu_exp_total
rename valuesHospital_beds Hospital_beds
rename valuesHealth_exp_pc Health_exp_pc
rename valuesLiteracy_rate Literacy_rate
rename valuesPhysicians Physicians
rename valuesWater_mortality Water_mortality
rename valuesPop_65plus Pop_65plus
rename valuesUrban_pop Urban_pop

/// banck data 1 ///////////////////////////////////////////////////////

drop in 799/803

// Reshape data from wide to long format across years
reshape long YR, i(CountryCode SeriesName) j(year)

// Rename reshaped variable for clarity
rename YR values

// Drop rows with missing or placeholder values
drop if missing(values)
drop if values == ".."

replace SeriesCode = "Health_exp_GDP" if SeriesCode == "SH.XPD.CHEX.GD.ZS"
replace SeriesCode = "Health_exp_PC_PPP" if SeriesCode == "SH.XPD.CHEX.PP.CD"
replace SeriesCode = "Health_exp_PC" if SeriesCode == "SH.XPD.CHEX.PC.CD"

// Drop unused columns
drop SeriesName
drop CountryName

// Reshape data back to wide format by indicator code
reshape wide values, i(year CountryCode) j(SeriesCode) string


rename valuesHealth_exp_GDP Health_exp_GDP
rename valuesHealth_exp_PC Health_exp_PC
rename valuesHealth_exp_PC_PPP Health_exp_PC_PPP
