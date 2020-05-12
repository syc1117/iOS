//
//  SectionViewController.swift
//  collectionViewStarter
//
//  Created by 신용철 on 2020/01/21.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit

class SectionViewController: UIViewController {
    
    let layout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
    let states = ParkManager.imageNames(of: .state)
    let parkList = ParkManager.list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
}

extension SectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return states.count
    }
    //section 디자인
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //header와 footer는 kind로 구분함.
        if kind == UICollectionView.elementKindSectionHeader {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! SectionHeaderView
        
        let state = states[indexPath.section]
        header.configure(image: UIImage(named: state), title: state)
        return header
        } else {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath) as! SectionFooterView
            let count = parkList.filter{
                $0.location.rawValue == states[indexPath.section]
            }.count * 2
            let title = "총 \(count)개 이미지"
            footer.configure(title: title)
            return footer
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return parkList.filter { $0.location.rawValue == states[section] }.count * 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SectionCell", for: indexPath) as! SectionCell
        
        let parks = parkList
            .filter {$0.location.rawValue == states[indexPath.section]}
        
        let parkName = parks[indexPath.item % parks.count].name
        cell.configure(img: UIImage(named: parkName), title: parkName)
        return cell
    }
}

extension SectionViewController {
    func setupCollectionView(){
        
           layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
           layout.minimumLineSpacing = 10
           layout.minimumInteritemSpacing = 10
           layout.itemSize = CGSize(width: 170, height: 170)
           layout.headerReferenceSize = CGSize(width: 60, height: 60)
           layout.footerReferenceSize = CGSize(width: 50, height: 50)//이값의//이값의 기본값은 0 이기 때문에 안해주면 section안나타남. 또한 현재 .horizontal 정령방식이기때문에 width 값은 아무런 의미가 없음.
           layout.sectionHeadersPinToVisibleBounds = true
           //section이 안의 contents들이 다 지나갈때까지 위에서 머무는 효과
           
           collectionView.backgroundColor = .white
           collectionView.dataSource = self
           
           collectionView.register(SectionCell.self, forCellWithReuseIdentifier: "SectionCell")
           collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
           collectionView.register(SectionFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")
           
           view.addSubview(collectionView)
       }
}
