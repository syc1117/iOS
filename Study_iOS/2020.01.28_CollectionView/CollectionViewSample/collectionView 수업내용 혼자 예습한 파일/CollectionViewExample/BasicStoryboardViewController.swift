//
//  BasicStoryboardViewController.swift
//  CollectionViewExample
//
//  Created by giftbot on 2020/01/24.
//  Copyright © 2020 giftbot. All rights reserved.
//

import UIKit

final class BasicStoryboardViewController: UIViewController {
    let imgList = ParkManager.imageNames(of: .nationalPark)
  @IBOutlet private weak var collectionView: UICollectionView!

    
}


extension BasicStoryboardViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BasicCell", for: indexPath)
        let imgView = cell.contentView.subviews.first! as! UIImageView
        imgView.image = UIImage(named: imgList[indexPath.item])
        cell.layer.cornerRadius = cell.frame.width / 2
        cell.clipsToBounds = true
        cell.contentMode = .scaleToFill
        
        return cell
    }
    
    
    
}
