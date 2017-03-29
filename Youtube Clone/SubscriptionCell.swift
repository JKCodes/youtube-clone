//
//  SubscriptionCell.swift
//  Youtube Clone
//
//  Created by Joseph Kim on 3/29/17.
//  Copyright © 2017 Joseph Kim. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {

    override func fetchVideos() {
        ApiService.shared.fetchFeed(urlString: "https://s3-us-west-2.amazonaws.com/youtubeassets/subscriptions.json") { [weak self] (videos) in
            self?.videos = videos
            self?.collectionView.reloadData()
        }
    }
}
