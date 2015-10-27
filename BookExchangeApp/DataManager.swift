//
//  DataManager.swift
//  BookExchangeApp
//
//  Created by Adler Faulkner on 2/24/15.
//  Copyright (c) 2015 Adler Faulkner. All rights reserved.
//

import Foundation
import Alamofire


class DataManager: NSObject {
    
    class var sharedInstance : DataManager {
        struct Static {
            static var instance: DataManager = DataManager()
        }
        return Static.instance
    }
    
    func alamoTest(completion:(error: NSError?) -> Void) {
        println("\nfunc alamoTest()")
        let parameters = [
            "foo" : "bar"
        ]
        Alamofire
            .request(.GET, "http://httpbin.org/get", parameters: parameters, encoding: .URL)
            .responseJSON { (request : NSURLRequest, response: NSHTTPURLResponse?, data: AnyObject?, error: NSError?) -> Void in
                if let e = error {
                    completion(error: e) // send error to completion closure
                } else {
                    if let swiftyJSON = JSON(rawValue: data!) { // if object can be converted to JSON
                        println(swiftyJSON)
                        
                        println(swiftyJSON["headers"]["Host"])
                    }
                }
        }
    }
    
    func call(end: String, parameters: Dictionary<String,String!>, completion:(error: NSError?, result: JSON?) -> Void) {
        println("func call()\n")
        
        let baseURLString = "http://bookback.herokuapp.com"
        var URL = baseURLString + end
        
        Alamofire.request(.POST, URL, parameters: parameters,  encoding: .URL)
            .responseJSON { (request, response, data, error) -> Void in
                println(data)
                
                if error != nil {
                    completion(error: error!, result: nil)
                } else {
                    if let swiftyJSON = JSON(rawValue: data!){
                        println("Successfully converted to JSON")
                        
                        completion(error: nil, result: swiftyJSON)
                    }
                }
        }
    }
}