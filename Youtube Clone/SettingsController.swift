//
//  SettingsController.swift
//  Youtube Clone
//
//  Created by Joseph Kim on 3/29/17.
//  Copyright © 2017 Joseph Kim. All rights reserved.
//

import UIKit

class SettingsController: NSObject {
    
    let blackView = UIView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    override init() {
        super.init()
    }
    
    func showSettings() {
        
        if let window = UIApplication.shared.keyWindow {
            let height: CGFloat = 200
            let y = window.frame.height - height
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            window.addSubview(collectionView)

            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            blackView.frame = window.frame
            blackView.alpha = 0
           
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { [weak self] in
                guard let this = self else { return }
                this.blackView.alpha = 1
                
                this.collectionView.frame = CGRect(x: 0, y: y, width: this.collectionView.frame.width, height: this.collectionView.frame.height)
            }, completion: nil)
        }

    }
    
    func handleDismiss() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { [weak self] in
            guard let this = self else { return }
            this.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                this.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: this.collectionView.frame.width, height: this.collectionView.frame.height)
            }
            
        }) { [weak self] (completed) in
            self?.collectionView.removeFromSuperview()
            self?.blackView.removeFromSuperview()
        }
    }
}
