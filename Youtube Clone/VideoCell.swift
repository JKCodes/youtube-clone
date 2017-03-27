//
//  VideoCell.swift
//  Youtube Clone
//
//  Created by Joseph Kim on 3/27/17.
//  Copyright © 2017 Joseph Kim. All rights reserved.
//

import UIKit

class VideoCell: BaseCell {
    
    private let contentOffset: CGFloat = 16
    private let separatorLineHeight: CGFloat = 1
    private let profileImageLength: CGFloat = 44
    private let titleLabelHeight: CGFloat = 20
    private let subtitleLabelHeight: CGFloat = 20
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "taylor_swift_blank_space")
        return imageView
    }()
    
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        return textView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    override func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        addSubview(separatorView)
        
        thumbnailImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: contentOffset, leftConstant: contentOffset, bottomConstant: 0, rightConstant: contentOffset, widthConstant: 0, heightConstant: 0)
        userProfileImageView.anchor(top: thumbnailImageView.bottomAnchor, left: leftAnchor, bottom: separatorView.topAnchor, right: nil, topConstant: contentOffset / 2, leftConstant: contentOffset, bottomConstant: contentOffset, rightConstant: 0, widthConstant: profileImageLength, heightConstant: profileImageLength)
        titleLabel.anchor(top: thumbnailImageView.bottomAnchor, left: userProfileImageView.rightAnchor, bottom: nil, right: rightAnchor, topConstant: contentOffset / 2, leftConstant: contentOffset / 2, bottomConstant: 0, rightConstant: contentOffset, widthConstant: 0, heightConstant: titleLabelHeight)
        subtitleTextView.anchor(top: titleLabel.bottomAnchor, left: titleLabel.leftAnchor, bottom: nil, right: titleLabel.rightAnchor, topConstant: contentOffset / 2, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: subtitleLabelHeight)
        separatorView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: contentOffset, bottomConstant: 0, rightConstant: contentOffset, widthConstant: 0, heightConstant: separatorLineHeight)

    }
}
