
// model data
			
quietly correlate life_expectancy_birth Health_exp_PC_PPP LOGGDP_pc Suicide_mortality Physicians Urban_pop

* Store correlation matrix
matrix C = r(C)

* Create the heatmap with values shown
heatplot C, values(format(%9.3f)) ///
    color(hcl) ///
    legend(off) ///
    aspectratio(1) ///
    title("Correlation Heatmap") ///
    xlab(1 "Life Exp" 2 "Health Exp" 3 "GDP_pc" 4 "Pop 65+") ///
    ylab(1 "Life Exp" 2 "Health Exp" 3 "GDP_pc" 4 "Pop 65+")

* Correlation matrix of selected variables
correlate life_expectancy_birth Health_exp_PC_PPP LOGGDP_pc Suicide_mortality Physicians Urban_pop
quietly correlate life_expectancy_birth Health_exp_PC_PPP LOGGDP_pc Suicide_mortality Physicians Urban_pop

* Store the correlation matrix
matrix C = r(C)

* Create heatmap with proper variable labels
heatplot C, values(format(%9.3f)) ///
    color(hcl) ///
    legend(off) ///
    aspectratio(1) ///
    title("Correlation Heatmap") ///
    xlab(1 "Life Exp" 2 "Health Exp" 3 "GDP_pc" 4 "Suicide" 5 "Physicians" 6 "Urban Pop") ///
    ylab(1 "Life Exp" 2 "Health Exp" 3 "GDP_pc" 4 "Suicide" 5 "Physicians" 6 "Urban Pop")


gen LOGHealth_exp_PC  = log(Health_exp_PC_PPP)
gen LOGGDP_pc = log(GDP_pc)
drop if missing(life_expectancy_birth)
drop in 68
drop if Health_exp_PC_PPP > 10000

ssc install outreg2

label variable life_expectancy_birth "Life Expectancy"
label variable Health_exp_PC_PPP "Health Exp (PPP)"
label variable LOGGDP_pc "Log GDP pc"
label variable Suicide_mortality "Suicide Rate"
label variable Physicians "Physicians/1,000"
label variable Urban_pop "Urban (%)"

outreg2 using x.doc, replace sum(log)

regress life_expectancy_birth Health_exp_PC_PPP LOGGDP_pc Suicide_mortality Physicians Urban_pop, robust
outreg2 using myreg.doc, replace label ctitle(Life_Expectancy) title(Table 1: Linear regression)

predict res_std, rstandard

predict res_std, rstandard
qnorm res_std, rlopts(lcolor(red)) aspect(1)




///////////////////////////////////////////////////////
// DATA PREPARATION AND TRANSFORMATION
///////////////////////////////////////////////////////

// Log-transform health expenditure and GDP per capita
gen LOGHealth_exp_PC = log(Health_exp_PC_PPP)
gen LOGGDP_pc = log(GDP_pc)

// Drop missing and outlier values for key variables
drop if missing(life_expectancy_birth)   // Drop observations with missing outcome
drop in 68                               // Drop known outlier (observation 68)
drop if Health_exp_PC_PPP > 10000        // Drop outliers in health expenditure (PPP-adjusted)

// Install outreg2 package (if not yet installed) for exporting regression tables
ssc install outreg2

// Label variables for clarity in output and tables
label variable life_expectancy_birth "Life Expectancy"
label variable Health_exp_PC_PPP "Health Exp (PPP)"
label variable LOGGDP_pc "Log GDP pc"
label variable Suicide_mortality "Suicide Rate"
label variable Physicians "Physicians/1,000"
label variable Urban_pop "Urban (%)"

///////////////////////////////////////////////////////
// CORRELATION ANALYSIS AND VISUALIZATION
///////////////////////////////////////////////////////

// Compute correlation matrix of key variables
quietly correlate life_expectancy_birth Health_exp_PC_PPP LOGGDP_pc Suicide_mortality Physicians Urban_pop

// Store correlation matrix in an object for plotting
matrix C = r(C)

// Create a correlation heatmap with formatted value labels
heatplot C, values(format(%9.3f)) /// 
    color(hcl) /// 
    legend(off) /// 
    aspectratio(1) /// 
    title("Correlation Heatmap") ///
    xlab(1 "Life Exp" 2 "Health Exp" 3 "GDP_pc" 4 "Suicide" 5 "Physicians" 6 "Urban Pop") ///
    ylab(1 "Life Exp" 2 "Health Exp" 3 "GDP_pc" 4 "Suicide" 5 "Physicians" 6 "Urban Pop")

///////////////////////////////////////////////////////
// DESCRIPTIVE STATISTICS
///////////////////////////////////////////////////////

// Export summary statistics (including log-transformed variables) to Word
outreg2 using x.doc, replace sum(log)

///////////////////////////////////////////////////////
// LINEAR REGRESSION ANALYSIS
///////////////////////////////////////////////////////

// Run OLS regression with robust standard errors
regress life_expectancy_birth Health_exp_PC_PPP LOGGDP_pc Suicide_mortality Physicians Urban_pop

// Export regression table to Word with custom titles
outreg2 using myreg.doc, replace label ctitle(Life_Expectancy) title(Table 1: Linear regression)

///////////////////////////////////////////////////////
// REGRESSION DIAGNOSTICS
///////////////////////////////////////////////////////

// Predict standardized residuals for diagnostics
predict res_std, rstandard

// Test residuals for normality using Shapiro-Wilk test
swilk res_std

// Q-Q plot of standardized residuals to visually assess normality
qnorm res_std, rlopts(lcolor(red)) aspect(1)

///////////////////////////////////////////////////////
// PARTIAL REGRESSION PLOTS (ADDED-VARIABLE PLOTS)
///////////////////////////////////////////////////////

// Generate added-variable plots for each independent variable
avplot Health_exp_PC_PPP
avplot LOGGDP_pc
avplot Suicide_mortality
avplot Physicians
avplot Urban_pop

///////////////////////////////////////////////////////
// RESIDUAL VS. FITTED PLOT FOR HOMOSKEDASTICITY CHECK
///////////////////////////////////////////////////////

// Plot residuals against fitted values with horizontal reference line at zero
rvfplot, yline(0) title("Residual vs. Fitted Values")
