//
//  Client.swift
//  BankManagementSystem
//
//  Created by Tarun Reddy on 2020-11-01.
//

import Foundation
//defining the class
class Client {
    var client_id : Int
    var client_name : String
    var client_address : String
    var client_phone : String
    init(client_id:Int,client_name:String,client_address:String,client_phone:String) {
        self.client_id = client_id;
        self.client_address = client_address;
        self.client_name = client_name;
        self.client_phone = client_phone;
    }
}
