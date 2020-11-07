//
//  main.swift
//  BankManagementSystem
//
//  Created by Tarun Reddy on 2020-11-01.
//

import Foundation
let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]

//defining the  accounts file by its name and txt as extension
let fileURL = URL(fileURLWithPath: "account_data", relativeTo: directoryURL).appendingPathExtension("txt")
var accounts = [Account]()
readingFromFile()
func readingFromFile(){
do {
 // Get the saved data
 let savedData = try Data(contentsOf: fileURL)
 // Convert the data back into a string
    if String(data: savedData, encoding: .utf8) != nil {
    //print(savedString)
    let data = String(decoding: savedData, as: UTF8.self)
    let lines = data.split(whereSeparator: \.isNewline)
        var account:Account? = nil;
    for line in lines{
        //split each line into words which are fields
        let fields = line.components(separatedBy: ",")
        let client = Client(client_id: Int(fields[0])!, client_name: fields[1], client_address: fields[2], client_phone: fields[3])
        if fields[6] == "savings" {
            account = SavingsAccount(account_number:Int(fields[4])!,amount:Double(fields[5])!,account_type:fields[6],client:client,interest: 8.5)
        }
        if fields[6] == "current" {
          account =  CurrentAccount(account_number:Int(fields[4])!,amount:Double(fields[5])!,account_type:fields[6],client:client,interest: 7.5)
        }
        accounts.append(account!)
        //print(accounts[0].account_number)
    }
 }
} catch {
 // Catch any errors
 print("Unable to read the file")
}
}
print("Welconme to Camara bank of Canada")
print("Press 1 if you are an admin or press 2 if you are a bank account holder")
let user_choice = Int(readLine()!)!
if user_choice == 1 {
    adminAccess()
}
if user_choice == 2 {
    userAccess()
}
func adminAccess() {
    while(true)
    {
    print("Choose from the following options")
    print("1.Create" + "\n" + "2.Save" + "\n" + "3.View user details" + "\n" + "4.EditDetails" + "\n" + "5.Perform client transactions" + "\n" + "0.Exit the application")
    let choice = Int(readLine()!)!
    if choice == 1 {
        createAccount()
    }
    if choice == 2 {
        saveAccountDetailsIntoFile()
    }
    if choice == 3 {
        viewUserDetails()
    }
    if choice == 4 {
        editDetails()
    }
    if choice == 5 {
        performClientTransactions()
    }
    if choice == 0 {
        break;
    }
}
}
func userAccess() {
print("Enter your id")
let id = Int(readLine()!)!
    //getting choice from the user
    while(true) {
        print("Choose from the following options")
        print("1.Deposit"+"\n"+"2.Withdraw"+"\n"+"3.Transfer between accounts"+"\n"+"4.Pay utility bills" + "\n" + "0.Exit")
        let user_choice = Int(readLine()!)!
        if user_choice == 1 {
            depositMoney(id: id) // deposits money to savings/current
        }
        if user_choice == 2 {
            withDrawMoney(id: id) // withdraw money from savings/current
        }
        if user_choice == 3 {
            transferbwAccounts(id: id) //transfer between accounts
        }
        if user_choice == 4 {
            payUtilityBills(id: id) // paying utility bills
        }
        if user_choice == 5 {
            displayBalance(id:id)
        }
        if user_choice == 0 {
            saveAccountDetailsIntoFile()
            break;
        }
    }
}
func createAccount() {
    // reading the data entered by the user
    var account : Account? = nil;
    while(true) {
        print("Enter 1 to create and 0 to return back to main menu")
        let choice = Int(readLine()!)!
        if choice == 1 {
        print("Enter user id")
        let user_id = Int(readLine()!)!
        print("Enter  name of the client")
        let user_name = readLine()!
        print("Enter phone of the client")
        let client_phone = readLine()!
        print("Enter address of the client")
        let client_address = readLine()!
        print("Enter account type Savings/Current?")
        let account_type = readLine()!
        print("Enter account number")
        let account_number = Int(readLine()!)!
        print("Enter initial deposit")
        let deposit = Double(readLine()!)!
        let c:Client = Client(client_id: user_id, client_name: user_name, client_address: client_address, client_phone: client_phone)
        if account_type == "savings" {
            // creating savings account instance if it is savings
            account = SavingsAccount(account_number:account_number, amount:deposit, account_type: account_type, client: c,interest:8.5)
        }
            if account_type == "current" {
                // creating current account instance if it is current
                account = CurrentAccount(account_number:account_number, amount:deposit, account_type: account_type, client: c,interest:7.5)
            }
            accounts.append(account!);
        }
        if choice == 0 {
            print(accounts[0])
            saveAccountDetailsIntoFile()
            break;
        }
    }
}
func saveAccountDetailsIntoFile() {
    //file saving code
        var myString:String = ""
           for acc in accounts{
               myString += acc.fileFormat()
           }
           let data = myString.data(using: .utf8)
           do {
               //write the data into the file
               try data?.write(to: fileURL)
            print("Data has been successfully saved: \(fileURL.absoluteURL)")
           } catch {
            // Catch any errors
            print(error.localizedDescription)
           }
    
}
func viewUserDetails() {
    //view details based on user id
    print("Enter user id")
    let user_id = Int(readLine()!)!
    for acc in accounts {
        if acc.client.client_id == user_id {
            acc.printAccountDetails()
        }
        }
}
func editDetails() {
    print("Enter user id")
    let user_id = Int(readLine()!)!
    print("Enter the field which you want to edit")
    print("Choose from the following 1.Phone number 2.Address ")
   let user_choice = Int(readLine()!)!
    if user_choice == 1 {
        print("Enter new phone number")
        let phone_no = readLine()!
        for acc in accounts {
            if acc.client.client_id == user_id {
                acc.client.client_phone = phone_no;
            }
            }
    }
    if user_choice == 2 {
        print("Enter new Address")
        let address = readLine()!
        for acc in accounts {
            if acc.client.client_id == user_id {
                acc.client.client_address = address;
            }
            }
    }
}
func performClientTransactions() {
    //performed by user/admin on behalf of client
    print("Enter id of the client")
    let id = Int(readLine()!)!
        //getting choice from the user
        while(true) {
            print("Choose from the following options")
            print("1.Deposit"+"\n"+"2.Withdraw"+"\n"+"3.Transfer between accounts"+"\n"+"4.Pay utility bills" + "\n" + "0.Exit")
            let user_choice = Int(readLine()!)!
            if user_choice == 1 {
                depositMoney(id: id) // deposits money to savings/current
            }
            if user_choice == 2 {
                withDrawMoney(id: id) // withdraw money from savings/current
            }
            if user_choice == 3 {
                transferbwAccounts(id: id) //transfer between accounts
            }
            if user_choice == 4 {
                payUtilityBills(id: id) // paying utility bills
            }
            if user_choice == 5 {
               displayBalance(id: id) // paying utility bills
            }
            if user_choice == 0 {
                saveAccountDetailsIntoFile()
                break;
            }
        }
}
func depositMoney(id:Int) {
    print("Enter the type of account which you want to deposit?")
    let account_type = readLine()!
    print("enter the amount you want to deposit into your account")
    let amount = Double(readLine()!)!
    for acc in accounts {
        if acc.client.client_id == id {
            if acc.account_type == account_type {
            acc.deposit(amount: amount)
        }
        }
    }
}
func withDrawMoney(id:Int) {
    print("Enter the type of account which you want to deposit?")
    let account_type = readLine()!
    print("enter the amount you want to withdraw from your account")
    let amount = Double(readLine()!)!
    for acc in accounts {
        if acc.client.client_id == id {
            if acc.account_type == account_type {
            acc.withdraw(amount: amount)
        }
        }
    }
}
func transferbwAccounts(id:Int) {
    print("Enter the source account from which you want to transfer?")
    let account_type = readLine()!
    var source_account : Account? = nil;
    var destination_account : Account? = nil;
    print("enter the amount you want to transfer")
    let amount = Double(readLine()!)!
    for acc in accounts {
        if acc.client.client_id == id {
            if acc.account_type == account_type {
                source_account = acc;
        }
            else {
                destination_account = acc;
            }
        }
    }
    source_account!.withdraw(amount: amount)
    destination_account!.deposit(amount: amount)
}
func payUtilityBills(id:Int) {
    print("Enter the account from which you want to pay utility bills")
    let account_type = readLine()!
    print("Enter the amount of the bill")
    let amount = Double(readLine()!)!
    for acc in accounts {
        if acc.client.client_id == id {
            if acc.account_type == account_type {
                acc.payUtilityBills(amount: amount)
        }
        }
    }
}
func displayBalance(id:Int) {
    for acc in accounts {
        if acc.client.client_id == id {
            print("The balance for this account is",acc.balance)
        }
        }
    }
