//
//  ApiService.swift
//  Youtube Clone
//
//  Created by Joseph Kim on 3/29/17.
//  Copyright © 2017 Joseph Kim. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
    static let shared = ApiService()
    
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    func fetchVideos(_ completion: @escaping ([Video]) -> ()) {
        fetchFeed(urlString: "\(baseUrl)/home.json", completion: completion)
    }
    
    func fetchTrendingFeed(_ completion: @escaping ([Video]) -> ()) {
        fetchFeed(urlString: "\(baseUrl)/trending.json", completion: completion)
    }
    
    func fetchSubscriptionFeed(_ completion: @escaping ([Video]) -> ()) {
        fetchFeed(urlString: "\(baseUrl)/subscriptions.json", completion: completion)
    }
    
    
    func fetchFeed(urlString: String, completion: @escaping ([Video]) -> ()) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if error != nil {
                print("\(error)")
                return
            }
            
            do {
                if let unwrappedData = data, let jsonDictionaries = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as? [[String: AnyObject]] {
                    
                    DispatchQueue.main.async {
                        completion(jsonDictionaries.map({return Video(dictionary: $0)}))
                    }
                }
                
            } catch let jsonError {
                print("\(jsonError)")
            }
        }) .resume()
        
    }
}
