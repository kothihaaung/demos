//
//  CarFeed.swift
//  Cars
//
//  Created by Thiha Aung on 1/30/18.
//  Copyright © 2018 Thiha Aung. All rights reserved.
//

import UIKit

public class CarFeed: NSObject {
    
    var id            : Int?
    var title         : String?
    var dateTime      : String?
    var image         : Data?
    var subject       : String?
    var carDescription: String?
    var ingress       : String?
    var created       : Int?
    var changed       : Int?
    
    func inflateToCarFeedListWith(json: [[String: Any]]) -> [CarFeed] {
        
        var carFeedList = [CarFeed]()
        for carFeed in json {
            let newCarFeed      = CarFeed()
            newCarFeed.id       = carFeed["id"]        as? Int
            newCarFeed.title    = carFeed["title"]     as? String
            newCarFeed.dateTime = carFeed["dateTime"]  as? String
            newCarFeed.image    = carFeed["imageData"] as? Data
            newCarFeed.ingress  = carFeed["ingress"]   as? String
            newCarFeed.created  = carFeed["created"]   as? Int
            newCarFeed.changed  = carFeed["changed"]   as? Int
            
            let contentArray = carFeed["content"] as? NSArray
            if Double((contentArray?.count)!) > 0 {
                let content = contentArray![0] as? [String: String]
                newCarFeed.subject        = content!["subject"]
                newCarFeed.carDescription = content!["description"]
            }
            
            carFeedList.append(newCarFeed)
        }
        
        return carFeedList
    }
}
