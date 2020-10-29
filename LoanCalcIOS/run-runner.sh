#!/bin/bash

APPIPA=LoanCalc.ipa
TESTIPA=LoanCalcUITests-Runner.ipa
#DEVICE=iPhone_XS_Max_POC168
#DEVICE=iPhone_6s_Plus_13_real
#DEVICE=iPhone_XS_13_real
#DEVICE=iPhone_6_real

#java -jar runner.jar xcuitest --testname "LoanCalc\ XCUITests" --test ${TESTIPA} --app ${APPIPA} --apikey ${LOANCALC_IOS_APIKEY} --datacenter US --device ${DEVICE} --testsToRun LoanCalcUITests/testLoanCalc1,LoanCalcUITests/testLoanCalc2 $*

#java -jar runner.jar xcuitest \
#  --testname "LoanCalc XCUITests" \
#  --test ${TESTIPA} \
#  --app ${APPIPA} \
#  --apikey ${LOANCALC_IOS_APIKEY} \
#  --datacenter US \
#  --deviceNameQuery "iPhone.*" \
#  --platformVersion "13" \
#  --testsToRun LoanCalcUITests/testLoanCalc1,LoanCalcUITests/testLoanCalc2 $*
#
#java -jar runner.jar xcuitest \
#  --testname "LoanCalc XCUITests" \
#  --test ${TESTIPA} \
#  --app ${APPIPA} \
#  --apikey ${LOANCALC_IOS_APIKEY} \
#  --datacenter US \
#  --deviceNameQuery "iPhone_X_13_real_us" \
#  --platformVersion "13" \
#  --testsToRun LoanCalcUITests/testLoanCalc1,LoanCalcUITests/testLoanCalc2 $*
#
#java -jar runner.jar xcuitest \
#  --testname "LoanCalc XCUITests" \
#  --test ${TESTIPA} \
#  --app ${APPIPA} \
#  --apikey ${LOANCALC_IOS_APIKEY} \
#  --datacenter US \
#  --deviceNameQuery "iPhone_X_13_real_us" \
#  --testsToRun LoanCalcUITests/testLoanCalc1,LoanCalcUITests/testLoanCalc2 $*

java -jar runner.jar xcuitest \
  --testname "LoanCalc XCUITests" \
  --test ${TESTIPA} \
  --app ${APPIPA} \
  --apikey ${LOANCALC_IOS_APIKEY} \
  --datacenter US \
  --device "iPhone_6s_Plus_13_real_us" \
  --testsToRun LoanCalcUITests/testLoanCalc1,LoanCalcUITests/testLoanCalc2 $*
