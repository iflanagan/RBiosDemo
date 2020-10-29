#!/bin/bash

xcodebuild -scheme LoanCalc -destination 'platform=iOS Simulator,name=iPhone X,OS=12.1' test-without-building $*
