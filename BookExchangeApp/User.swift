//
//  user.swift
//  BookExchangeApp
//
//  Created by Adler Faulkner on 2/24/15.
//  Copyright (c) 2015 Adler Faulkner. All rights reserved.
//

import Foundation

class User: NSObject, Printable {
    var id: Int
    var fname: String
    var lname: String
    var email: String
    var apiKey: String
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.fname = json["first_name"].stringValue
        self.lname = json["last_name"].stringValue
        self.email = json["email"].stringValue
        self.apiKey = json["api_key"].stringValue
    }
    
}





