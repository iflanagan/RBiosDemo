#!/bin/bash

APPNAME="LoanCalc"
SRCDIR=$(find ~/Library/Developer/Xcode/DerivedData/ -name "${APPNAME}*" -maxdepth 1 -type d)

#$HOME/Library/Developer/Xcode/DerivedData/LoanCalc-exlwvtchhmuvfcdaluekjovwqlmg/Build/Products/Debug-iphoneos/LoanCalc.app
#$HOME/Library/Developer/Xcode/DerivedData/LoanCalc-exlwvtchhmuvfcdaluekjovwqlmg/Build/Products/Debug-iphoneos/LoanCalcUITests-Runner.app

echo $SRCDIR

echo "Bundling app..."
rm ${APPNAME}.sim.ipa
rm -rf Payload 2> /dev/null
rsync -av --delete ${SRCDIR}/Build/Products/Debug-iphonesimulator/${APPNAME}.app Payload/
zip -r ${APPNAME}.sim.ipa Payload/
rm -rf Payload 2> /dev/null

rm ${APPNAME}.sim.app.zip
rm -rf ${APPNAME}.app 2> /dev/null
rsync -av --delete ${SRCDIR}/Build/Products/Debug-iphonesimulator/${APPNAME}.app .
zip -r ${APPNAME}.sim.app.zip ${APPNAME}.app
rm -rf ${APPNAME}.app 2> /dev/null

echo "Bundling runner..."
rm ${APPNAME}UITests-Runner.sim.ipa
rm -rf Payload 2> /dev/null
rsync -av --delete ${SRCDIR}/Build/Products/Debug-iphonesimulator/${APPNAME}UITests-Runner.app Payload/
zip -r ${APPNAME}UITests-Runner.sim.ipa Payload/
rm -rf Payload 2> /dev/null

ls -l LoanCalc.sim.ipa
ls -l LoanCalc.sim.app.zip
ls -l LoanCalcUITests-Runner.sim.ipa
