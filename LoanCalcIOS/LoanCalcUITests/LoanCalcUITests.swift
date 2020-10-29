//
//  LoanCalcUITests.swift
//  LoanCalcUITests
//
//  Created by Bill Meyer on 7/24/18.
//  Copyright © 2018 Bill Meyer. All rights reserved.
//

import XCTest

class LoanCalcUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        
        // Force the Region to an expected setting
//        app.launchArguments += ["-AppleLanguages", "(en-US)"]
//        app.launchArguments += ["-AppleLocale", "en_US"]
        app.launch()
        sleep(1)

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        app.terminate()
    }
    
    func testLoanCalc1() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        dumpDate()
//        print(app.debugDescription)
        
        let tfLoanAmount = app.textFields["Loan Amount"]
        tfLoanAmount.tap()
        tfLoanAmount.typeText("25000")
        
        let tfInterest = app.textFields["Interest"]
        tfInterest.tap()
        tfInterest.typeText("3.42")

        let tfSalesTax = app.textFields["Sales Tax"]
        tfSalesTax.tap()
        tfSalesTax.typeText("8")

        let tfTerm = app.textFields["Term"]
        tfTerm.tap()
        tfTerm.typeText("60")

        let tfDownPayment = app.textFields["Down Payment"]
        tfDownPayment.tap()
        tfDownPayment.typeText("500")

        let tfTradeIn = app.textFields["Trade In"]
        tfTradeIn.tap()
        tfTradeIn.typeText("7500")
        
        let tfFees = app.textFields["Fees"]
        tfFees.tap()
        tfFees.typeText("300")
        
        let screenshot = app.windows.firstMatch.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.lifetime = .keepAlways
        add(attachment)
        
        let currencyFormatter = getCurrencyFormatter()
        
        let lblMonthlyPayment = app.staticTexts["lblMonthlyPayment"]
        print("Monthly Payment: " + lblMonthlyPayment.label)
        XCTAssertEqual(currencyFormatter.string(from: 339.52), lblMonthlyPayment.label)
        
        let lblTotalPayments = app.staticTexts["lblTotalPayments"]
        print("Total Payments: " + lblTotalPayments.label)
        XCTAssertEqual(currencyFormatter.string(from: 20370.97), lblTotalPayments.label)
        
        let lblTotalInterest = app.staticTexts["lblTotalInterest"]
        print("Total Interest: " + lblTotalInterest.label)
        XCTAssertEqual(currencyFormatter.string(from: 1670.97), lblTotalInterest.label)
        
        let lblTotalCost = app.staticTexts["lblTotalCost"]
        print("Total Cost: " + lblTotalCost.label)
        XCTAssertEqual(currencyFormatter.string(from: 28370.97), lblTotalCost.label)
    }

    func testLoanCalc2() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let tfLoanAmount = app.textFields["Loan Amount"]
        tfLoanAmount.tap()
        tfLoanAmount.typeText("75000")
        
        let tfInterest = app.textFields["Interest"]
        tfInterest.tap()
        tfInterest.typeText("4.08")
        
        let tfSalesTax = app.textFields["Sales Tax"]
        tfSalesTax.tap()
        tfSalesTax.typeText("7.75")
        
        let tfTerm = app.textFields["Term"]
        tfTerm.tap()
        tfTerm.typeText("84")
        
        let tfDownPayment = app.textFields["Down Payment"]
        tfDownPayment.tap()
        tfDownPayment.typeText("5000")
        
        let tfTradeIn = app.textFields["Trade In"]
        tfTradeIn.tap()
        tfTradeIn.typeText("0")
        
        let tfFees = app.textFields["Fees"]
        tfFees.tap()
        tfFees.typeText("500")
        
        let currencyFormatter = getCurrencyFormatter()
        
        let lblMonthlyPayment = app.staticTexts["lblMonthlyPayment"]
        print("Monthly Payment: " + lblMonthlyPayment.label)
        XCTAssertEqual(currencyFormatter.string(from: 1045.91), lblMonthlyPayment.label)
        
        let lblTotalPayments = app.staticTexts["lblTotalPayments"]
        print("Total Payments: " + lblTotalPayments.label)
        XCTAssertEqual(currencyFormatter.string(from: 87856.72), lblTotalPayments.label)
        
        let lblTotalInterest = app.staticTexts["lblTotalInterest"]
        print("Total Interest: " + lblTotalInterest.label)
        XCTAssertEqual(currencyFormatter.string(from: 11544.22), lblTotalInterest.label)
        
        let lblTotalCost = app.staticTexts["lblTotalCost"]
        print("Total Cost: " + lblTotalCost.label)
        XCTAssertEqual(currencyFormatter.string(from: 92856.72), lblTotalCost.label)
    }

    func dumpDate()
    {
        let formatter = DateFormatter()
        
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: Date())
        
        // convert your string to date
//        let yourDate = formatter.string(from: myString)
        print("**** Runtime Date: " + myString)
        
//        //then again set the date format whhich type of output you need
//        formatter.dateFormat = "dd-MMM-yyyy"
//
//        // again convert your date to string
//        let myStringafd = formatter.string(from: yourDate!)
//
//        print(myStringafd)
    }
    
    func getCurrencyFormatter() -> NumberFormatter {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        // localize to your grouping and decimal separator
        currencyFormatter.locale = Locale.current
        
        return currencyFormatter
    }
}
