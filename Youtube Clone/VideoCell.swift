//
//  VideoCell.swift
//  Youtube Clone
//
//  Created by Joseph Kim on 3/27/17.
//  Copyright © 2017 Joseph Kim. All rights reserved.
//

import UIKit

class VideoCell: BaseCell {

    // contentOffset + contentOffset / 2 + titleLabelHeight + contentOffset / 4 + subtitleLabelHeight + contentHeight / 2
    // above thumbnal + in between thumb and title + label height + in between title and sub + sub height + bottom buffer
    internal static let cellHeightMinusThumbnail: CGFloat = 16 + 8 + 20 + 4 + 30 + 28
    
    private let contentOffset: CGFloat = 16
    private let separatorLineHeight: CGFloat = 1
    private let profileImageLength: CGFloat = 44
    private static let profileImageRadius: CGFloat = 22
    private let titleLabelHeight: CGFloat = 44
    private let subtitleLabelHeight: CGFloat = 30
    
    private var titleLabelHeightConstraint: NSLayoutConstraint?
    
    var video: Video? {
        didSet {
            titleLabel.text = video?.title
            
            setupThumbnailImage()
            setupProfileImage()
            
            if let channelName = video?.channel?.name, let numberOfViews = video?.numberOfViews {
                
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                if let formattedViews = numberFormatter.string(from: numberOfViews) {
                    let subtitleText = "\(channelName) • \(formattedViews) • 4 years ago"
                    subtitleTextView.text = subtitleText
                }
            }

            if let title = video?.title {
                
                // width offset = between left edge and profile image + image length + gap between image and title label + between right of the title label and right edge
                let size = CGSize(width: frame.width - contentOffset - profileImageLength - contentOffset / 2 - contentOffset, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 16)]
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: attributes, context: nil)
                                
                if estimatedRect.size.height > 20 {
                    titleLabelHeightConstraint?.constant = 44
                } else {
                    titleLabelHeightConstraint?.constant = 20
                }
            }
        
        }
    }
    
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = #imageLiteral(resourceName: "taylor_swift_blank_space")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = #imageLiteral(resourceName: "taylor_swift_profile")
        imageView.layer.cornerRadius = VideoCell.profileImageRadius
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Random Title"
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Ranom Text"
        textView.contentInset = UIEdgeInsetsMake(-8, -4, 0, 0)
        textView.textColor = .lightGray
        textView.isEditable = false
        return textView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(r: 230, g: 230, b: 230)
        return view
    }()
    
    override func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        addSubview(separatorView)
        
        thumbnailImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: contentOffset, leftConstant: contentOffset, bottomConstant: 0, rightConstant: contentOffset, widthConstant: 0, heightConstant: 0)
        userProfileImageView.anchor(top: thumbnailImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: contentOffset / 2, leftConstant: contentOffset, bottomConstant: contentOffset, rightConstant: 0, widthConstant: profileImageLength, heightConstant: profileImageLength)
        titleLabelHeightConstraint = titleLabel.anchorAndReturn(top: thumbnailImageView.bottomAnchor, left: userProfileImageView.rightAnchor, bottom: nil, right: rightAnchor, topConstant: contentOffset / 2, leftConstant: contentOffset / 2, bottomConstant: 0, rightConstant: contentOffset, widthConstant: 0, heightConstant: titleLabelHeight)[3]
        subtitleTextView.anchor(top: titleLabel.bottomAnchor, left: titleLabel.leftAnchor, bottom: nil, right: titleLabel.rightAnchor, topConstant: contentOffset / 4, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: subtitleLabelHeight)
        separatorView.anchor(top: subtitleTextView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: contentOffset / 2, leftConstant: contentOffset, bottomConstant: 0, rightConstant: contentOffset, widthConstant: 0, heightConstant: separatorLineHeight)

    }
    
    func setupThumbnailImage() {
        if let thumbnailImageUrl = video?.thumbnailImageName {
            thumbnailImageView.loadImageUsingUrlString(urlString: thumbnailImageUrl)
        }
    }
    
    func setupProfileImage() {
        if let profileImageUrl = video?.channel?.profileImageName {
            userProfileImageView.loadImageUsingUrlString(urlString: profileImageUrl)
        }
    }
}
