//
//  BasicCodeViewController.swift
//  CollectionViewExample
//
//  Created by giftbot on 2020/01/24.
//  Copyright © 2020 giftbot. All rights reserved.
//

import UIKit

final class CustomCellViewController: UIViewController {
    
    let layout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(
        frame: view.frame, collectionViewLayout: layout
    )
    var trueFalse = false
    let itemCount = 120
    let parkImage = ParkManager.imageNames(of: .nationalPark)
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavigationItem()
        setupFlowLayout()
    }
    
    // MARK: Setup Views
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.identifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    private func setupFlowLayout() {
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        if trueFalse{
            layout.itemSize = CGSize(width: 60, height: 60)
        } else {
            layout.itemSize = CGSize(width: 120, height: 120)
        }
    }
    
    private func setupNavigationItem() {
        let changeItem = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: self,
            action: #selector(changeCollectionViewItems(_:))
        )
        let changeDirection = UIBarButtonItem(
            barButtonSystemItem: .reply,
            target: self,
            action: #selector(changeCollectionViewDirection(_:))
        )
        navigationItem.rightBarButtonItems = [changeItem, changeDirection]
    }
    
    // MARK: Action
    
    @objc private func changeCollectionViewItems(_ sender: Any) {
        trueFalse.toggle()
        setupFlowLayout()
        collectionView.reloadData()
        
    }
    
    @objc private func changeCollectionViewDirection(_ sender: Any) {
        let direction = layout.scrollDirection
        layout.scrollDirection = direction == .horizontal ? .vertical : .horizontal
    }
    
}

// MARK: - UICollectionViewDataSource

extension CustomCellViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if trueFalse {
            return itemCount * 3
        } else {
            return parkImage.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if trueFalse {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.backgroundColor = getColor(indexPath)
            cell.layer.cornerRadius = cell.frame.width / 2
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell else { return UICollectionViewCell()}
            cell.configure(parkImage[indexPath.item])
            cell.layer.cornerRadius = 20
            cell.backgroundColor = .brown
            return cell
        }
    }
    func getColor(_ indexPath: IndexPath) -> UIColor?{
        let item = CGFloat(indexPath.item)
        let factor = item / CGFloat(itemCount * 3)
        return .init(hue: 1-factor, saturation: 1-factor, brightness: 1, alpha: 1)
    }
}


extension CustomCellViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        cell.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,options: .curveEaseInOut,
                       animations: {
                        cell.alpha = 1
                        cell.transform = .identity
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard trueFalse else { return layout.itemSize }
        if indexPath.item % 5 == 2 {
            return layout.itemSize.applying(.init(scaleX: 2, y: 2))
        } else {
            return layout.itemSize
        }
    }
}
