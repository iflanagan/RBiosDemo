#!/bin/bash

APPNAME="LoanCalc"
SRCDIR=$(find ~/Library/Developer/Xcode/DerivedData/ -name "${APPNAME}*" -maxdepth 1 -type d)

#$HOME/Library/Developer/Xcode/DerivedData/LoanCalc-exlwvtchhmuvfcdaluekjovwqlmg/Build/Products/Debug-iphoneos/LoanCalc.app
#$HOME/Library/Developer/Xcode/DerivedData/LoanCalc-exlwvtchhmuvfcdaluekjovwqlmg/Build/Products/Debug-iphoneos/LoanCalcUITests-Runner.app

echo $SRCDIR

echo "Bundling app..."
rm ${APPNAME}.ipa
rm -rf Payload 2> /dev/null
rsync -av --delete ${SRCDIR}/Build/Products/Debug-iphoneos/${APPNAME}.app Payload/
zip -r ${APPNAME}.ipa Payload/
rm -rf Payload 2> /dev/null

rm ${APPNAME}.app.zip
rm -rf ${APPNAME}.app 2> /dev/null
rsync -av --delete ${SRCDIR}/Build/Products/Debug-iphoneos/${APPNAME}.app .
zip -r ${APPNAME}.app.zip ${APPNAME}.app
rm -rf ${APPNAME}.app 2> /dev/null

echo "Bundling runner..."
rm ${APPNAME}UITests-Runner.ipa
rm -rf Payload 2> /dev/null
rsync -av --delete ${SRCDIR}/Build/Products/Debug-iphoneos/${APPNAME}UITests-Runner.app Payload/
zip -r ${APPNAME}UITests-Runner.ipa Payload/
rm -rf Payload 2> /dev/null

ls -l LoanCalc.app.zip
ls -l LoanCalc.ipa
ls -l LoanCalcUITests-Runner.ipa
