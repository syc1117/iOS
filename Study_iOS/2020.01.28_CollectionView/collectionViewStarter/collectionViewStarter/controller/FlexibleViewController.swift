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
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        //여기에 구현하는 이유: layout.scrollDirection = .horizontal 일경우 safeAreaInsets를 사용해아하기 때문에
        //참고: safeAreaInsets은 viewSafeAreaInsetsDidChange(viewWillApear 다음) 시점에 생성됨
        setupFlowLayout()
    }
}
extension FlexibleViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return parkImages.count * 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        let item = indexPath.item % parkImages.count
        cell.configure(img: UIImage(named: parkImages[item]), title: parkImages[item])
        cell.backgroundColor = .lightGray
        return cell
    }
}

extension FlexibleViewController {
    func setupCollectionView(){
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    func setupFlowLayout(){
        layout.minimumInteritemSpacing = UI.itemSpacing
        layout.minimumLineSpacing = UI.lineSpacing
        layout.sectionInset = UI.edgeInsets
        
        //collectionView의 가로(세로) 길이 - 총 여백 / 원하는 cell 갯수 => cell 너비
        let totalItemSpacing = UI.itemSpacing * (UI.itemsInLine - 1)
        let horizontalInset = UI.edgeInsets.right + UI.edgeInsets.left
        //세로 길이의 경우 safeAreaInsets을 추가로 빼야하는 이유: collectionView의 크기를 view.frame으로 설정해놓았기 때문임. 가로의 경우에는 safeAreaInsets가 0이지만 세로는 0이 아님.
        let verticalInset = UI.edgeInsets.top + UI.edgeInsets.bottom + view.safeAreaInsets.top + view.safeAreaInsets.bottom
        
        if layout.scrollDirection == .vertical {
            let width = (collectionView.frame.width - totalItemSpacing - horizontalInset) / UI.itemsInLine
            let roundedWidth = width.rounded(.down) //소수점 버리는 기능. 소수점을 살려주면 나중에 이미지하나가 안나오는 경우가 생기므로 반드시 버려줘야 함.
            layout.itemSize = CGSize(width: roundedWidth, height: roundedWidth)
        } else {
            let height = (collectionView.frame.height - totalItemSpacing - verticalInset) / UI.itemsInLine
            let roundedHeight = height.rounded(.down)
            layout.itemSize = CGSize(width: roundedHeight, height: roundedHeight)
        }
    }
    
    func setupNavigationItem(){
        let changeDirection = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(changeCollectionViewDirection))
        navigationItem.rightBarButtonItem = changeDirection
    }
    @objc func changeCollectionViewDirection(){
        let current = layout.scrollDirection
        layout.scrollDirection = (current == .horizontal) ? .vertical : .horizontal
        setupFlowLayout()
    }
}

