//
//  FeedCell.swift
//  Youtube Clone
//
//  Created by Joseph Kim on 3/29/17.
//  Copyright © 2017 Joseph Kim. All rights reserved.
//

import UIKit

class FeedCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"
    private var cellHeight: CGFloat = 0
    private let contentOffset: CGFloat = 16
    
    var videos: [Video]?
    
    lazy var collectionView: UICollectionView = { [weak self] in
        guard let this = self else { return UICollectionView() }
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = this
        cv.delegate = this
        return cv
    }()
    
    override func setupViews() {
        super.setupViews()
        
        fetchVideos()
    
        addSubview(collectionView)
        collectionView.fillSuperview()
        
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func fetchVideos() {
        ApiService.shared.fetchVideos { [weak self] (videos) in
            self?.videos = videos
            self?.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VideoCell
        
        cell.video = videos?[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        cellHeight = (frame.width - contentOffset * 2) * 9 / 16
        
        return CGSize(width: frame.width, height: cellHeight + VideoCell.cellHeightMinusThumbnail)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}
