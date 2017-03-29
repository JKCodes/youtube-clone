//
//  CustomImageView.swift
//  Youtube Clone
//
//  Created by Joseph Kim on 3/29/17.
//  Copyright © 2017 Joseph Kim. All rights reserved.
//

import UIKit

fileprivate let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        imageUrlString = urlString
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            
            guard let data = data else { return }
            
            if error != nil {
                print("\(error)")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                
                guard let imageToCache = UIImage(data: data) else { return }
                
                if self?.imageUrlString == urlString {
                    self?.image = imageToCache
                }
                
                imageCache.setObject(imageToCache, forKey: urlString as NSString)
                
                self?.image = imageToCache
            }
        }).resume()
    }
}

