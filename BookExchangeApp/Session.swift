//
//  Session.swift
//  BookExchangeApp
//
//  Created by Adler Faulkner on 2/26/15.
//  Copyright (c) 2015 Adler Faulkner. All rights reserved.
//

import Foundation
import Alamofire

func makeSession(key: String) {
    let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(key, forKey: "api_key")
    }


func getSession() -> String! {
    let defaults = NSUserDefaults.standardUserDefaults()
    return defaults.stringForKey("api_key")
}

func removeSession() {
    let defaults = NSUserDefaults.standardUserDefaults()
    defaults.removeObjectForKey("api_key")
}

