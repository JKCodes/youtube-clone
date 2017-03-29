//
//  SettingsController.swift
//  Youtube Clone
//
//  Created by Joseph Kim on 3/29/17.
//  Copyright © 2017 Joseph Kim. All rights reserved.
//

import UIKit

class SettingsController: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"
    private let settingCellSize: CGFloat = 50
    
    let blackView = UIView()
    
    let settings: [Setting] = {
        let settingsSetting = Setting(name: .Settings, imageName: "settings")
        
        let cancelSetting = Setting(name: .Cancel, imageName: "cancel")
        return [settingsSetting, Setting(name: .TermsPrivacy, imageName: "privacy"), Setting(name: .SendFeedback, imageName: "feedback"), Setting(name: .Help, imageName: "help"), Setting(name: .SwitchAccount, imageName: "switch_account"), cancelSetting]
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    
    
    override init() {
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func showSettings() {
        
        if let window = UIApplication.shared.keyWindow {
            let height: CGFloat = CGFloat(settings.count) * settingCellSize
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
        
        cell.setting = settings[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: settingCellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
