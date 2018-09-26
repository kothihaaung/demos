//
//  NetworkAccess.swift
//  Cars
//
//  Created by Thiha Aung on 1/30/18.
//  Copyright © 2018 Thiha Aung. All rights reserved.
//

import UIKit

public class NetworkAccess: NSObject {
    
    let baseUrl = "https://www.apphusetreach.no/application/119267"
    
    static let shared = NetworkAccess()
    private override init() {
        
    }
    
    // Make a POST request
    func newPostRequestWithCallback(url: String,
                                    parm: [String: Any]?,
                                    success: @escaping ([String: Any]) -> Void,
                                    fail: @escaping (String) -> Void) {
        
        let session = URLSession.shared
        
        var request = URLRequest(url: URL(string: baseUrl + url)!)
        request.httpMethod = "POST"
        
        if parm != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parm!, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

            // Error occur
            guard error == nil else {
                fail((error?.localizedDescription)!)
                return
            }

            // Error occur
            guard let data = data else {
                fail((error?.localizedDescription)!)
                return
            }

            if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    success(json!)
                }else {
                    fail("JSON cannot pase!")
            }
            
        })
        
        task.resume()
    }
}

