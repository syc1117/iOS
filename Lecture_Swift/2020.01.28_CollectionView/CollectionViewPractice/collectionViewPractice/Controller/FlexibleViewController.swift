//
//  FlexibleViewController.swift
//  collectionViewStarter
//
//  Created by 신용철 on 2020/01/21.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit

class FlexibleViewController: UIViewController {
    private enum UI {
        static let itemsInLine: CGFloat = 3
        static let linesOnScreen: CGFloat = 3
        static let itemSpacing: CGFloat = 10.0
        static let lineSpacing: CGFloat = 10.0
        static let edgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        static let nextOffset: CGFloat = 40
    }
    
    let layout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
    var parkImages = ParkManager.imageNames(of: .nationalPark)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavigationItem()
        setupFlowLayout()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        setupFlowLayout()
    }
}
extension FlexibleViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return parkImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        return UICollectionViewCell()
    }
}

extension FlexibleViewController {
    func setupCollectionView(){
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    func setupFlowLayout(){
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        //3 * 5
        let numberOfItemsInLine: CGFloat = 3
        let numberOfItemsInColum: CGFloat = 5
        let totalHorizontalSpacing = layout.minimumInteritemSpacing * (numberOfItemsInLine - 1) + layout.sectionInset.right + layout.sectionInset.left
        let totalverticalSpacing = view.safeAreaInsets.top + view.safeAreaInsets.bottom + layout.minimumLineSpacing * (numberOfItemsInColum - 1) + layout.sectionInset.top + layout.sectionInset.bottom
        let widthOfItems = (collectionView.frame.width - totalHorizontalSpacing) / numberOfItemsInLine
        let finialWidth = widthOfItems.rounded(.down)
        let heightOfItems = (collectionView.frame.height - totalverticalSpacing) / numberOfItemsInColum
        let finalheight = heightOfItems.rounded(.down)
        
        layout.itemSize = CGSize(width: finialWidth, height: finalheight)
    }
    
    func setupNavigationItem(){
        
    }
    @objc func changeCollectionViewDirection(){
        
    }
}

