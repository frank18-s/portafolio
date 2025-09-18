rename DIM_GEO_CODE CountryCode
rename DIM_TIME_YEAR year

keep if IND_NAME == "Suicide mortality rate (per 100 000 population)" ///
     | IND_NAME == "Life expectancy at birth (years)"| IND_CODE == "MDG_0000000007"

keep if DIM_1_CODE == "SEX_BTSX"| DIM_1_CODE == "NA"
drop DIM_1_CODE

drop VALUE_COMMENTS

drop VALUE_STRING
rename VALUE_NUMERIC var1

drop IND_NAME
drop DIM_GEO_NAME

reshape wide var1, i(year CountryCode) j(IND_CODE) string

rename var1WHOSIS_0001 life_expectancy_birth
rename var1SDGSUICIDE Suicide_mortality

//////////////////////////////////////////////////////////////////
// DATA CLEANING AND TRANSFORMATION - WHO INDICATORS
//////////////////////////////////////////////////////////////////

// Rename variables to standard names for consistency
rename DIM_GEO_CODE CountryCode         // Rename geographic code to CountryCode
rename DIM_TIME_YEAR year               // Rename time variable to year

// Keep only relevant health indicators:
// - Suicide mortality rate
// - Life expectancy at birth
// - Physicians density (MDG_0000000007)
keep if IND_NAME == "Suicide mortality rate (per 100 000 population)" ///
     | IND_NAME == "Life expectancy at birth (years)" ///
     | IND_CODE == "MDG_0000000007"

// Filter to include only data for both sexes or where sex is not specified
keep if DIM_1_CODE == "SEX_BTSX" | DIM_1_CODE == "NA"

// Drop the sex classification code since it's no longer needed
drop DIM_1_CODE

// Drop comment and string value columns not needed for analysis
drop VALUE_COMMENTS
drop VALUE_STRING

// Rename numeric value column before reshaping
rename VALUE_NUMERIC var1

// Drop descriptive indicator and country name fields
drop IND_NAME
drop DIM_GEO_NAME

// Reshape dataset from long to wide format by indicator code
reshape wide var1, i(year CountryCode) j(IND_CODE) string

// Rename reshaped variables to intuitive, readable names
rename var1WHOSIS_0001       life_expectancy_birth
rename var1SDGSUICIDE        Suicide_mortality

