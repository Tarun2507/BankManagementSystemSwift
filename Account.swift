//
//  Account.swift
//  BankManagementSystem
//
//  Created by Tarun Reddy on 2020-11-01.
//

import Foundation
//defining the class Account
class Account {
    var account_number : Int;
    var amount : Double;
    var balance : Double;
    var account_type :String;
    var client : Client; // stroing client details in Account class as Client class type
    init(account_number:Int,amount:Double,account_type:String,client:Client) {
        self.account_number = account_number;
        self.amount = amount;
        self.balance = amount;
        self.account_type = account_type;
        self.client = client;
    }
    func printAccountDetails(){
        
    }
    func fileFormat() ->String
        {
        let line = String(self.client.client_id)+","+self.client.client_name+","+self.client.client_address+","+self.client.client_phone+","+String(self.account_number)+","+String(self.amount)+","+String(self.balance)+","+self.account_type+"\n"
          return line
        }
    func deposit() {
        
    }
}
