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
    let states = ParkManager.imageNames(of: .state) // =>  Location.allCase = ["Alaska", "Arizona", "California", "Colorado", ... ]
    let parkList = ParkManager.list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        setupLayout()
    }
}

extension SectionViewController: UICollectionViewDataSource {
    //셀 갯수, 셀 디자인, 섹션갯수, 색션디자인
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return states.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! SectionHeaderView
            let names = states[indexPath.section]
            header.configure(text: names)
            return header
            
        } else {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath) as! SectionFooterView
            let count = parkList.filter {$0.location.rawValue == states[indexPath.section] }.count
            footer.configure(count: count)
            return footer
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return parkList.filter {$0.location.rawValue == states[section] }.count
    }
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        let item = parkList.filter {$0.location.rawValue == states[indexPath.section]}
        let name = item[indexPath.item].name
        cell.configure(img: UIImage(named: name), text: name)
        return cell
    }
}

extension SectionViewController {
    func setupCollectionView(){
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.register(SectionFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")
        collectionView.backgroundColor = .white
       }
    func setupLayout(){
        //셀크기, 여백
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.headerReferenceSize = CGSize(width: 60, height: 60)
        layout.footerReferenceSize = CGSize(width: 50, height: 50)
        
        //가로 3개, 세로 5개
        let totalHorizontalSpacing = layout.sectionInset.left + layout.sectionInset.right + layout.minimumInteritemSpacing * 2
        let width = (collectionView.frame.width - totalHorizontalSpacing) / 3
        let finalWidth = width.rounded(.down)
        
        let verticalSpacing = view.safeAreaInsets.top + view.safeAreaInsets.bottom + layout.sectionInset.top + layout.sectionInset.bottom + layout.minimumLineSpacing * 4
        let height = (collectionView.frame.height - verticalSpacing) / 5
        
        layout.itemSize = CGSize(width: finalWidth, height: height)
    }
}
