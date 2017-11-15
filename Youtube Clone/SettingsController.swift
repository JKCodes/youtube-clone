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
    
    weak var delegate: SettingsDelegate?
    
    let blackView = UIView()
    
    let settings: [Setting] = {
        let settingsSetting = Setting(name: .settings, imageName: "settings")
        let termsPrivacySetting = Setting(name: .termsPrivacy, imageName: "privacy")
        let sendFeedbackSetting = Setting(name: .sendFeedback, imageName: "feedback")
        let helpSetting = Setting(name: .help, imageName: "help")
        let switchAccountSetting = Setting(name: .switchAccount, imageName: "switch_account")
        let cancelSetting = Setting(name: .cancel, imageName: "cancel")
        return [settingsSetting, termsPrivacySetting, sendFeedbackSetting, helpSetting, switchAccountSetting, cancelSetting]
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
    
    @objc func handleDismiss(setting: Setting) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { [weak self] in
            guard let this = self else { return }
            this.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                this.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: this.collectionView.frame.width, height: this.collectionView.frame.height)
            }
        }) { [weak self] (completed) in
            
            if setting.name != .cancel {
                self?.delegate?.showControllerForSetting(setting: setting)
            }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let setting = self.settings[indexPath.item]
        handleDismiss(setting: setting)
    }
}
