//
//  APIAccessManager.swift
//  Cars
//
//  Created by Thiha Aung on 1/30/18.
//  Copyright © 2018 Thiha Aung. All rights reserved.
//

import UIKit

// Delegate
public protocol APIAccessManagerDelegate: class {
    func allArticlesHasBeenSynced()
    func dataSyncDidFail(errorMessage: String)
}


public class APIAccessManager: NSObject {
    
    private let getAllArticlesURL = "/article/get_articles_list"
    
    weak var delegate: APIAccessManagerDelegate?
    
    static let shared = APIAccessManager()
    private override init() {
        
    }

    // Sync All Articles
    func syncAllArticles() {
        
        NetworkAccess.shared.newPostRequestWithCallback(url: getAllArticlesURL, parm: nil, success: { (json) in

            let status = json["status"] as! String;
            if status == "success" {
                if let articleList = json["content"] as? [[String: Any]] {
                    LocalDB.shared.saveAllArticles(articleList: articleList)
                
                    // invoke delegate
                    self.delegate?.allArticlesHasBeenSynced()
                
                }
            }else {
                // invoke delegate
                self.delegate?.dataSyncDidFail(errorMessage: "Server respond fail!")
            }
            
            
        }) { (errorMessage) in
            // invoke delegate
            self.delegate?.dataSyncDidFail(errorMessage: errorMessage)
            print(errorMessage)
        }
    }
}

