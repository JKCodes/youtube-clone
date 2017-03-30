//
//  VideoLauncher.swift
//  Youtube Clone
//
//  Created by Joseph Kim on 3/29/17.
//  Copyright © 2017 Joseph Kim. All rights reserved.
//

import UIKit

class VideoLauncher: NSObject {
    
    var videoPlayerView: VideoPlayerView?
    
    lazy var backButton: UIButton = { [weak self] in
        guard let this = self else { return UIButton() }
        let button = UIButton(type: .system)
        button.setTitle("Back", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .red
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(this, action: #selector(handleBack), for: .touchUpInside)
        return button
    }()
    
    let view: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    func showVideoPlayer() {
        
        if let keyWindow = UIApplication.shared.keyWindow {
            
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            let height = keyWindow.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
            videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            
            if let player = videoPlayerView {
                view.addSubview(player)
            }

            
            let backButtonFrame = CGRect(x: keyWindow.frame.width / 2 - 50, y: height + 16, width: 100, height: 30)
            backButton.frame = backButtonFrame
            view.addSubview(backButton)
            
            keyWindow.addSubview(view)
            
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { [weak self] in
                
                self?.view.frame = keyWindow.frame
                
            }, completion: { (completed) in
                UIApplication.shared.setStatusBarHidden(true, with: .fade)
            })
        }
    }
    
    func handleBack() {
        videoPlayerView?.removeFromSuperview()
        backButton.removeFromSuperview()
        view.removeFromSuperview()
        UIApplication.shared.setStatusBarHidden(false, with: .none)
    }
}
