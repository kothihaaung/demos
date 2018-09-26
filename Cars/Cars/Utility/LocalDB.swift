//
//  LocalDB.swift
//  Cars
//
//  Created by Thiha Aung on 1/30/18.
//  Copyright © 2018 Thiha Aung. All rights reserved.
//

import UIKit

class LocalDB: NSObject {

    let allArticlesKey = "allArticles"
    
    static let shared = LocalDB()
    override init() {
    
    }
    
    func saveAllArticles(articleList: [[String: Any]]) {
        
        var allArticlesWithImage = [[String: Any]]()
        
        for article in articleList {
            
            var articleWithImage = article
            let imageUrlString   = article["image"]
            let imageUrl:URL     = URL(string: imageUrlString as! String)!
            let imageData:NSData = NSData(contentsOf: imageUrl)!
            
            articleWithImage["imageData"] = imageData as Data
            
            allArticlesWithImage.append(articleWithImage)
        }
        
        UserDefaults.standard.set(allArticlesWithImage, forKey: allArticlesKey)
    }
    
    func loadAllArticles() -> [[String: Any]]? {
        let allArticles = UserDefaults.standard.object(forKey: allArticlesKey) as? [[String: Any]]
        return allArticles
    }
}
