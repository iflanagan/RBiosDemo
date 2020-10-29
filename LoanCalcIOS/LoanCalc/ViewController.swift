//
//  ViewController.swift
//  LoanCalc
//
//  Created by Bill Meyer on 7/24/18.
//  Copyright © 2018 Bill Meyer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var advancedContainerView: UIScrollView!
    
    // UI outlets
    @IBOutlet weak var tfLoanAmount: UITextField!
    @IBOutlet weak var tfInterest: UITextField!
    @IBOutlet weak var tfSalesTax: UITextField!
    @IBOutlet weak var tfTerm: UITextField!
    @IBOutlet weak var tfDownPayment: UITextField!
    @IBOutlet weak var tfTradeIn: UITextField!
    @IBOutlet weak var tfFees: UITextField!
    
    @IBOutlet weak var lblMonthlyPayment: UILabel!
    @IBOutlet weak var lblTotalPayments: UILabel!
    @IBOutlet weak var lblTotalInterest: UILabel!
    @IBOutlet weak var lblTotalCost: UILabel!
    
    //advanced properties
    var loanAmount: Double = 0.0
    var termInMonths: Int = 0
    var annualInterestAdv: Double = 0.0
    var downPayment: Double = 0.0
    var tradeIn: Double = 0.0
    var salesTaxRate: Double = 0.0
    var fees: Double = 0.0
    
    var formatter: NumberFormatter
    
    required init?(coder aDecoder: NSCoder) {
        formatter = NumberFormatter()
        // localize to your grouping and decimal separator
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Initialize view
        tfLoanAmount.delegate = self
        tfLoanAmount.becomeFirstResponder()
        tfLoanAmount.keyboardType = UIKeyboardType.decimalPad

        tfInterest.delegate = self
        tfInterest.keyboardType = UIKeyboardType.decimalPad
        
        tfSalesTax.delegate = self
        tfSalesTax.keyboardType = UIKeyboardType.decimalPad

        tfTerm.delegate = self
        tfTerm.keyboardType = UIKeyboardType.decimalPad

        tfDownPayment.delegate = self
        tfDownPayment.keyboardType = UIKeyboardType.decimalPad

        tfTradeIn.delegate = self
        tfTradeIn.keyboardType = UIKeyboardType.decimalPad

        tfFees.delegate = self
        tfFees.keyboardType = UIKeyboardType.decimalPad
    }

    func calcLoan()
    {
        let taxableAmount = loanAmount - tradeIn
        let salesTax = taxableAmount * salesTaxRate / 100.0
        let financedAmount = taxableAmount + salesTax + fees - downPayment
        
        let monthlyPayment = calculateMonthlyPayment(financedAmount: financedAmount, termInMonths: termInMonths, annualInterestRate: annualInterestAdv)
        
        let totalLoanPayments = monthlyPayment * Double(termInMonths)
        let totalLoanInterest = totalLoanPayments - financedAmount
        let totalCost = loanAmount + totalLoanInterest + salesTax + fees
        
        lblTotalPayments.text = formatter.string(from: totalLoanPayments as NSNumber)
        lblTotalInterest.text = formatter.string(from: totalLoanInterest as NSNumber)
        lblMonthlyPayment.text = formatter.string(from: monthlyPayment as NSNumber)
        lblTotalCost.text = formatter.string(from: totalCost as NSNumber)

    }
    
    func calculateMonthlyPayment(financedAmount: Double, termInMonths: Int, annualInterestRate: Double) -> Double {
        // Convert tvInterest rate into a decimal. eg. 3.75% ==> 0.0375
        let interestRate = annualInterestRate / 100.0;
        
        // Monthly Interest Rate is the yearly rate divided by 12 months
        let monthlyRate = interestRate / 12.0;
        
        // Calculate the monthly payment
        let a = (financedAmount * monthlyRate)
        let b = (1 - pow(1 + monthlyRate, Double(-termInMonths)))
        let c = a / b
        print (c)
        let monthlyPayment = (financedAmount * monthlyRate) / (1 - pow(1 + monthlyRate, Double(-termInMonths)));
        
        return monthlyPayment;
    }
    
//    func calcPrincipal(loanAmount: Double, tradeIn: Double, payoffAmount: Double, downPayment: Double, salesTaxRate: Double) -> Double {
//
//        if salesTaxRate > 0 {
//            return ((loanAmount - tradeIn)*(1+(salesTaxRate/100))) - downPayment + payoffAmount
//        } else {
//            return loanAmount - tradeIn - downPayment + payoffAmount
//        }
//    }
//
//    func returnMonthlyPayment(principal: Double, annualInterest: Double, months: Double) -> Dictionary<String, Double> {
//        var payment: Double = 0.0
//        var totalLoan: Double = 0.0
//        let monthlyInterest: Double = annualInterest/1200
//        if annualInterest < 0 {
//            print("Interest can not be negative")
//        } else if annualInterest == 0 {
//            if months == 0 {
//                payment = principal
//                totalLoan = principal
//            } else {
//                payment = principal/months
//                totalLoan = payment*months
//            }
//        } else {
//            if months == 0 {
//                payment = principal
//                totalLoan = principal
//            } else {
//                payment =  principal * (monthlyInterest * pow((1 + monthlyInterest), months)) / (pow((1 + monthlyInterest), months) - 1)
//                totalLoan = payment*months
//            }
//
//        }
//
//        return ["payment": payment, "totalLoan": totalLoan]
//    }
    
//    func calcAndUpdate(principal: Double, annualInterest: Double, months: Double) {
////        let calc = returnMonthlyPayment(principal: principal, annualInterest: annualInterest, months: months)
//
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .currency
//
////        lblTotalLoanAmount.text = formatter.string(from: calc["totalLoan"]! as NSNumber)
////        lblMonthlyPayment.text = formatter.string(from: calc["payment"]! as NSNumber)
//    }
    
    // actions
    @IBAction func loanAmountChanged() {
        if let inputVal = Double(tfLoanAmount.text!) {
            loanAmount = inputVal
            calcLoan()
        }
    }
    
    @IBAction func interestChanged() {
        if let inputVal = Double(tfInterest.text!) {
            annualInterestAdv = inputVal
            calcLoan()
        }
    }
    
    @IBAction func salesTaxChanged() {
        if let inputVal = Double(tfSalesTax.text!) {
            salesTaxRate = inputVal
            calcLoan()
        }
    }
    
    @IBAction func termChanged() {
        if let inputVal = Int(tfTerm.text!) {
            termInMonths = inputVal
            calcLoan()
        }
    }
    
    @IBAction func downPaymentChanged() {
        if let inputVal = Double(tfDownPayment.text!) {
            downPayment = inputVal
            calcLoan()
        }
    }
    
    @IBAction func tradeInChanged() {
        if let inputVal = Double(tfTradeIn.text!) {
            tradeIn = inputVal
            calcLoan()
        }
    }
    
    @IBAction func feesChanged() {
        if let inputVal = Double(tfFees.text!) {
            fees = inputVal
            calcLoan()
        }
    }
}
