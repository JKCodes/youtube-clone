//
//  UIImageView + loadImageUsingURLString.swift
//  Youtube Clone
//
//  Created by Joseph Kim on 3/29/17.
//  Copyright © 2017 Joseph Kim. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImageUsingUrlString(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            
            guard let data = data else { return }
            
            if error != nil {
                print("\(error)")
                return
            }
            
            DispatchQueue.main.async {
                self?.image = UIImage(data: data)
            }
        }).resume()
    }
}

