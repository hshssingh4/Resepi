//
//  ResepiClient.swift
//  Resepi
//
//  Created by Harpreet Singh on 11/9/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

import UIKit

class ResepiClient: NSObject {
    
    static func getRecepies(searchTerm: String, _ success: @escaping ([NSDictionary]) -> (), failure: @escaping (Error) -> ()) {
        let path = "https://api.edamam.com/search"
        let appId = "7e2bbab1"
        let appKey = "454d90ed492f48f024b58bdd7d16b60b"
        let from_value = 0
        let to_value = 20
        // Replace spaces in search term to '+'
        let newSearchTerm = searchTerm.replacingOccurrences(of: " ", with: "+")
        let url = URL(string:"\(path)?q=\(newSearchTerm)&app_id=\(appId)&app_key=\(appKey)&from=\(from_value)&to=\(to_value)")
        let request = URLRequest(url: url!)
        
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        let task : URLSessionDataTask = session.dataTask(with: request, completionHandler: {data, response, error in
            if data != nil {
                
                if let responseDictionary = try! JSONSerialization.jsonObject(with: data!, options:[]) as? NSDictionary {
                    success(responseDictionary["hits"] as! [NSDictionary])
                }
            }
            else {
                failure(error!)
            }
        });
        
        task.resume()
    }
    
    
    
    
    
    
    
    

}
