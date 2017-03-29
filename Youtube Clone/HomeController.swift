//
//  HomeController.swift
//  Youtube Clone
//
//  Created by Joseph Kim on 3/27/17.
//  Copyright © 2017 Joseph Kim. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let cellId = "cellId"
    private var cellHeight: CGFloat = 0
    private let contentOffset: CGFloat = 16
    
    var videos: [Video]?
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        
        return mb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchVideos()
        
        navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - contentOffset * 2, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        collectionView?.backgroundColor = .white
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
    
        setupMenuBar()
        setupNavBarButtons()
    }
    
    func fetchVideos() {
        guard let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json") else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            guard let data = data else { return }
            
            if error != nil {
                print("\(error)")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
                self?.videos = [Video]()
                
                for dictionary in json as! [[String: AnyObject]] {
                    
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    
                    let channelDictionary = dictionary["channel"] as! [String: AnyObject]
                    
                    let channel = Channel()
                    channel.name = channelDictionary["name"] as? String
                    channel.profileImageName = channelDictionary["profile_image_name"] as? String
                    
                    video.channel = channel
                    
                    self?.videos?.append(video)
                }
                
                DispatchQueue.main.async {
                    self?.collectionView?.reloadData()
                }
            
            } catch let jsonError {
                print("\(jsonError)")
            }
            
        }.resume()
    }
    
    private func setupNavBarButtons() {
        let searchImage = #imageLiteral(resourceName: "search_icon").withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "nav_more_icon").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreButtonItem, searchBarButtonItem]
    }
    
    func handleMore() {
        
    }
    
    func handleSearch() {
        
    }
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        
        menuBar.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VideoCell
        
        cell.video = videos?[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        cellHeight = (view.frame.width - contentOffset * 2) * 9 / 16
        
        return CGSize(width: view.frame.width, height: cellHeight + VideoCell.cellHeightMinusThumbnail)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

