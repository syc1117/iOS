//
//  ViewController.swift
//  CollectionViewPractice
//
//  Created by Giftbot on 2020/01/28.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  // cat0 ~ cat9에 해당하는 이미지 10개를 2번 생성
  let originalImages = Array(0...9)
    .map { "cat\($0)" }
    .compactMap(UIImage.init(named:))
  
  lazy var dataSource = originalImages
  
  // UICollectionView
  let flowLayout = UICollectionViewFlowLayout()
  
  lazy var collectionView: UICollectionView = {
    let cv = UICollectionView(frame: view.frame, collectionViewLayout: flowLayout)
    cv.dataSource = self
    cv.delegate = self
    cv.backgroundColor = .white
    cv.register(CatSelectionCell.self,
                forCellWithReuseIdentifier: CatSelectionCell.identifier)
    cv.allowsMultipleSelection = true
    view.addSubview(cv)
    return cv
  }()
  
  
  // MARK: LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "CollectionView"
    setupFlowLayout()
  }
  
  func setupFlowLayout()  {
    let itemCount: CGFloat = 2
    let spacing: CGFloat = 10
    let inset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    let cvWidth = collectionView.bounds.width
    let horizontalInset = inset.left + inset.right
    let contentSize = cvWidth - horizontalInset - (spacing * (itemCount - 1))
    let itemSize = contentSize / itemCount
    
    flowLayout.minimumInteritemSpacing = spacing
    flowLayout.minimumLineSpacing = spacing
    flowLayout.sectionInset = inset
    flowLayout.itemSize = CGSize(width: itemSize, height: itemSize)
  }
  
  // MARK: Action
  // indexPathsForSelectedItems로 다중선택된 indexPath 가져다가 데이터 array에서 먼저 지우고 collectionview 에서 deleteItems 로 지우고.
  @IBAction private func deleteItems(_ sender: Any) {
    guard let indexPaths = collectionView.indexPathsForSelectedItems else { return }
    // MARK: reversed 안하면 에러가 나는 이유: 앞에서 부터 지우면 뒤에 인덱스가 하나씩 앞으로 밀려오면서 마지막거 지울때 out of range가 발생하는 것임. 따라서 뒤에서 부터 지워줘야 함.
    indexPaths.sorted().reversed().forEach{
        dataSource.remove(at: $0.item )
    }
    
    //2,4,6
    //[0,1,2,3,4,5,6]
    //[0,1,3,5]
    //[0,1,3,4,5,6]
    //[0,1,3,4,6]
    //[0,1,3,4,6]  
    
//    for indexPath in indexPaths.sorted().reversed()
// {
//      dataSource.remove(at: indexPath.item)
//
//    }
    collectionView.deleteItems(at: indexPaths)
//
//    if dataSource.isEmpty {
//      dataSource = originalImages
//      let insertIndexPaths = dataSource.indices.map {
//        IndexPath(item: $0, section: 0)
//      }
//      collectionView.insertItems(at: insertIndexPaths)
//    }
  }
}


// MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dataSource.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatSelectionCell.identifier, for: indexPath) as! CatSelectionCell
    cell.configure(image: dataSource[indexPath.item])
    return cell
  }
}


// MARK: - UICollectionViewDelegate

extension ViewController: UICollectionViewDelegate {
  /***************************************************
   iOS 13부터 두 손가락으로 터치한 걸 인식시킨 뒤 드래그하면 하나씩 탭하지 않아도 다중 선택 가능
   단, 아래 메서드를 구현하여 true를 반환해야 함 (기본값 false)
   ***************************************************/
  
  func collectionView(_ collectionView: UICollectionView, shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Bool {
    return true
  }
}
