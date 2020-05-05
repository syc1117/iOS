//
//  ViewController.swift
//  collectionViewStarter
//
//  Created by 신용철 on 2020/01/21.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit

class CustomCellViewController: UIViewController {
    var collectionView: UICollectionView!
    let numberArr = Array(1...120)
    let parkImage = ParkManager.imageNames(of: .nationalPark)
    var showImage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupFlowLayout()
        setupNavigationItem()
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "CustomCell")
    }
    func setupCollectionView(){
        let layout = UICollectionViewFlowLayout()
        //collectionView는 반드시 아래 init만 사용할 수 있음.
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
         //깡코딩으로 만들때는 기본값이 검정색임. 스토리보드는 흰색이 기본값.
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        
    }
    
    func setupFlowLayout(){
        //그냥 위의 함수 setupCollectionView에서 layout을 파라미터로 받아도 됨.
        //UICollectionViewFlowLayout는 collectionViewLayout의 자식클래스
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        if showImage {
            layout.itemSize = CGSize(width: 120, height: 120)
            layout.minimumInteritemSpacing = 15 //10이 기본값, 좌우여백(vertical기준)
            layout.minimumLineSpacing = 25// 상하여백(vertical기준)
            layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        } else {
            //itemSize(cell크기)의 기본값은 50, 50 임.
            layout.itemSize = CGSize(width: 60, height: 60)
            layout.minimumInteritemSpacing = 10 //10이 기본값, 좌우여백(vertical기준)
            layout.minimumLineSpacing = 20// 상하여백(vertical기준)
            layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5) //가장 테두리 cell들과 view의 여백
        }
    }
}

extension CustomCellViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return showImage ? parkImage.count * 2 : numberArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell!
        
        if showImage {
           let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
            let item = indexPath.item % parkImage.count
            customCell.configure(img: UIImage(named: parkImage[item]), title: parkImage[item])
            cell = customCell
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.layer.cornerRadius = cell.frame.width / 2
        }
        //collectionView는 무조건 dequeueReusableCell 써야함.(테이블뷰와 다름)
         
        cell.backgroundColor = getColor(at: indexPath)
        
        return cell
    }
    
    func getColor(at indexPath: IndexPath) -> UIColor {
        
        let item = CGFloat(indexPath.item)
        let factor = item / CGFloat(numberArr.count)
        
        if showImage {
            return .init(hue: factor, saturation: 0.7, brightness: 1, alpha: 1)
        } else {
            return .init(hue: factor, saturation: factor, brightness: 1, alpha: 1)
        }
    }
    func setupNavigationItem(){
        let changeItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(changeCollectionViewItems(_:)))
        
        let changeDirection = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(changeCollectionViewDirection(_:)))
        
        navigationItem.rightBarButtonItems = [changeItem, changeDirection]
    }
    
    @objc private func changeCollectionViewItems(_ sender: Any){
        showImage.toggle()
        setupFlowLayout()
        collectionView.reloadData()
    }
    
    @objc private func changeCollectionViewDirection(_ sender: Any){
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let curruntDirection = layout.scrollDirection
        layout.scrollDirection = (curruntDirection == .horizontal) ? .vertical : .horizontal
    }
}

// MARK: UICollectionViewDelegate를 안쓰고 UICollectionViewDelegateFlowLayout 사용해야함.
extension CustomCellViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        let layout = collectionViewLayout as! UICollectionViewFlowLayout
//        //가운데 것 크기 2배 나머지 원래 그대로
//        if showImage {
//            return layout.itemSize
//        } else {
//            if indexPath.item % 5 == 2 {
//                return layout.itemSize.applying(CGAffineTransform(scaleX: 2, y: 2))
//            } else {
//                return layout.itemSize
//            }
//        }
//    }
    //MARK: delegate내의 함수. cell 나타날때 호출되는 함수 - 셀 등장 애니매이션 효과는 여기서 구현
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        cell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: .curveEaseInOut,
                       animations: {
                        cell.alpha = 1
                        cell.transform = .identity
        })
    }
    
}
