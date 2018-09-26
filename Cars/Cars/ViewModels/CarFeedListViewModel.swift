//
//  CarFeedListViewModel.swift
//  Cars
//
//  Created by Thiha Aung on 1/30/18.
//  Copyright © 2018 Thiha Aung. All rights reserved.
//

import UIKit

// Delegate
public protocol CarFeedViewModelDelegate: class {
    func dataSourceIsReady(dataSource: [CarFeed])
    func dataSourceDidNotLoaded(message: String)
}

class CarFeedListViewModel: NSObject, APIAccessManagerDelegate {
    
    weak var delegate: CarFeedViewModelDelegate?
    
    override init() {
        
        super.init()
    
        APIAccessManager.shared.delegate = self
    }
    
    func loadCarFeedList(connection: Bool) {
        
        // load from LocalDB
        allArticlesHasBeenSynced()
        
        // load from Server
        if connection {
            APIAccessManager.shared.syncAllArticles()
        }
    }
    
    // Delegate methods
    func allArticlesHasBeenSynced() {
        
        // Load data from LocalDB
        if let jsonWithImage = LocalDB.shared.loadAllArticles() {
            // Inflate to DataSource
            let inflatedDataSource = CarFeed().inflateToCarFeedListWith(json: jsonWithImage)
            
            self.delegate?.dataSourceIsReady(dataSource: inflatedDataSource)
        }
    }
    
    func dataSyncDidFail(errorMessage: String) {
        // failed sync
        self.delegate?.dataSourceDidNotLoaded(message: errorMessage)
    }
}
