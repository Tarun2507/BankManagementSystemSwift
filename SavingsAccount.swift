//
//  SavingsAccount.swift
//  BankManagementSystem
//
//  Created by Tarun Reddy on 2020-11-06.
//

import Foundation

class SavingsAccount : Account {
    var interest : Double
    init(account_number: Int,amount: Double,account_type:String,client:Client,interest:Double) {
        self.interest = interest;
        super.init(account_number: account_number, amount: amount, account_type: account_type, client: client)
    }
    override func deposit(amount:Double) {
        super.deposit(amount: amount)
    }
    override func withdraw(amount:Double) {
        super.withdraw(amount: amount)
    }
    override func payUtilityBills(amount:Double) {
        super.payUtilityBills(amount: amount)
    }
}
