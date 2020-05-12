//
//  BasicViewController.swift
//  CollectionViewExercises
//
//  Created by Giftbot on 2020/01/28.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit

final class BasicViewController: UIViewController {
  let layout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
  let dataSource = cards
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupLayout()
  }
  
}

// MARK: - UICollectionViewDataSource

extension BasicViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dataSource.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    cell.backgroundColor = dataSource[indexPath.item].color
    return cell
  }
}

extension BasicViewController {
    
    func setupLayout(){
        view.addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let numberOfCell: CGFloat = 4
        let totalHorizontalSpacing = layout.sectionInset.left + layout.sectionInset.right + layout.minimumInteritemSpacing * (numberOfCell - 1)
        let width = (collectionView.frame.width - totalHorizontalSpacing) / numberOfCell
        let finalWidth = width.rounded(.down)
        layout.itemSize = CGSize(width: finalWidth, height: finalWidth * 2)
    }
}
