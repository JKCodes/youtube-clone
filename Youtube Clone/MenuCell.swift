//
//  MenuCell.swift
//  Youtube Clone
//
//  Created by Joseph Kim on 3/27/17.
//  Copyright © 2017 Joseph Kim. All rights reserved.
//

import UIKit

class MenuCell: BaseCell {
    
    private let imageViewLength: CGFloat = 28
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "home").withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.rgb(r: 91, g: 14, b: 13)
        return iv
    }()
    
    override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isHighlighted ? .white : UIColor.rgb(r: 91, g: 14, b: 13)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? .white : UIColor.rgb(r: 91, g: 14, b: 13)
        }
    }
    
    override func setupViews() {
        super.setupViews()
        addSubview(imageView)
        
        imageView.anchorCenterXYSuperview()
        imageView.anchor(top: nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: imageViewLength, heightConstant: imageViewLength)
    }
}
