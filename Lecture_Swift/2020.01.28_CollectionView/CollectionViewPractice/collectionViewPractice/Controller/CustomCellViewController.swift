//
//  ViewController.swift
//  collectionViewPractice
//
//  Created by 신용철 on 2020/01/21.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit

class CustomCellViewController: UIViewController {
    let layout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
    
    let numberArr = Array(1...120)
    var truefalse = true
    let parkImage = ParkManager.imageNames(of: .nationalPark)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavigationItem()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        setupFlowLayout()
    }
    
    func setupCollectionView(){
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
//        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "customCell")
    }
    
    func setupFlowLayout(){
        //1. 여백: cell간 여백, 테두리 여백
        //2. cell 크기
        
        //1. 여백 - 테두리 여백설정
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        //2. 여백 - cell 간 여백
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        if truefalse {
            let numberOfItemInLine: CGFloat = 3
            let numberOfItemInColum: CGFloat = 5
            let totalHorizontalSpacing = layout.minimumInteritemSpacing * (numberOfItemInLine - 1) + layout.sectionInset.right + layout.sectionInset.left
            let width = (collectionView.frame.width - totalHorizontalSpacing) / numberOfItemInLine
            let finalWidth = width.rounded(.down)
            // 위 테두리, 아래 테두리, 셀의 세로 간격, 뷰의 크기에 collectionView의 크기를 맞췄기 때문에 노치, 탭바의 높이도 다 고려해야함.
            //노치, 탭바 => safeAreaInsets와 값이 같음.
            let totalVerticalSpacing = view.safeAreaInsets.top + view.safeAreaInsets.bottom + layout.sectionInset.top + layout.sectionInset.bottom + layout.minimumLineSpacing * (numberOfItemInColum - 1)
           
            let heigt = (collectionView.frame.height - totalVerticalSpacing) / numberOfItemInColum
            let finalHeight = heigt.rounded(.down)
                
            layout.itemSize = CGSize(width: finalWidth, height: finalHeight)
            
        } else {        //3. cell 크기
            /* 1) 가로 몇개, 세로 몇개 를 설정*/
            let numberOfItemInLine: CGFloat = 5
            //        let numberOfItemInColum: CGFloat = 5
            //(collectionView의 가로길이 - 총 가로 여백) / 갯수 = 하나의 가로길이
            let totalHorizontalSpacing = layout.minimumInteritemSpacing * (numberOfItemInLine - 1) + layout.sectionInset.right + layout.sectionInset.left
            let width = (collectionView.frame.width - totalHorizontalSpacing) / numberOfItemInLine
            let finalWidth = width.rounded(.down)
            layout.itemSize = CGSize(width: finalWidth, height: finalWidth)
        }
    }
}
//동그랗게 만들기
//애니매이션 효과추가
//중간 것 크게 만들기

extension CustomCellViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if truefalse {
            return parkImage.count
        } else {
        return numberArr.count * 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if truefalse {
            let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! CustomCell
            let item = parkImage[indexPath.item]
            customCell.configure(img: UIImage(named: item), text: item)
            customCell.layer.cornerRadius = 20
            return customCell
        } else {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = getColor(indexPath)
        cell.layer.cornerRadius = cell.frame.width / 2
        return cell
        }
    }
    
    func getColor(_ indexPath: IndexPath) -> UIColor{
        let item: CGFloat = CGFloat(indexPath.item)
        let factor = item / CGFloat(numberArr.count * 3)
        
        return .init(hue: factor, saturation: factor, brightness: 1, alpha: 1)
    }
    
    func setupNavigationItem(){
        let changeView = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(changeCollectionViewItems))
        navigationItem.rightBarButtonItem = changeView
        
        let changeDirection = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(changeCollectionViewDirection))
        navigationItem.leftBarButtonItem = changeDirection
        
    }
    
    @objc private func changeCollectionViewItems(_ sender: Any){
        truefalse.toggle()
        setupFlowLayout()
        collectionView.reloadData()
    }
    
    @objc private func changeCollectionViewDirection(_ sender: Any){
        layout.scrollDirection = (layout.scrollDirection == .vertical) ? .horizontal : .vertical
    }
}

extension CustomCellViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if truefalse{
//            return layout.itemSize
//        } else {
//            if indexPath.item % 5 == 2 {
//                return layout.itemSize.applying(CGAffineTransform(scaleX: 2, y: 2))
//            } else {
//                return layout.itemSize
//            }
//        }
//    }
//
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        cell.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       options: .curveEaseInOut,
                       animations: {
                        cell.alpha = 1
                        cell.transform = .identity
        })
    }
}
