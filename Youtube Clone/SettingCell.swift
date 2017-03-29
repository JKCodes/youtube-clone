//
//  SettingCell.swift
//  Youtube Clone
//
//  Created by Joseph Kim on 3/29/17.
//  Copyright © 2017 Joseph Kim. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    
    private let contentOffset: CGFloat = 8
    private let iconImageLength: CGFloat = 30
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .darkGray : .white
            
            nameLabel.textColor = isHighlighted ? .white : .black
            
            iconImageView.tintColor = isHighlighted ? .white : .darkGray
        }
    }
    
    var setting: Setting? {
        didSet {
            nameLabel.text = setting?.name.rawValue
            
            if let imageName = setting?.imageName {
                iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                iconImageView.tintColor = .darkGray
            }
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Setting"
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "settings")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        iconImageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: contentOffset, bottomConstant: 0, rightConstant: 0, widthConstant: iconImageLength, heightConstant: iconImageLength)
        iconImageView.anchorCenterYToSuperview()
        nameLabel.anchor(top: topAnchor, left: iconImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: contentOffset, bottomConstant: 0, rightConstant: contentOffset, widthConstant: 0, heightConstant: 0)
    }
}
