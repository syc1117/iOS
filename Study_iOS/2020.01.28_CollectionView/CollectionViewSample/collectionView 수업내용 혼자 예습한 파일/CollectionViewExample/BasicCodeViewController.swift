//
//  BasicCodeViewController.swift
//  CollectionViewExample
//
//  Created by Giftbot on 2020/01/28.
//  Copyright © 2020 giftbot. All rights reserved.
//

import UIKit

final class BasicCodeViewController: UIViewController {
    
    let layout = UICollectionViewFlowLayout()
    let itemCount = 300
    var sizeSlider: UISlider!
    lazy var collectionView = UICollectionView(frame: view.frame.offsetBy(dx: 0, dy: 250), collectionViewLayout: layout) //view.frame.offsetBy(dx: 0, dy: 250)는 view.frame을 기준으로 offset 만큼 떨어진 위치에서 collection뷰를 위치시킨다는 것임.
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSliders()
        setupCollectionView()
        setupNavigationItem()
    }
    
    // MARK: Setup Views
    
    func setupSliders() {
        let sizeSlider = UISlider()
        sizeSlider.minimumValue = 10
        sizeSlider.maximumValue = 200
        sizeSlider.value = 50
        sizeSlider.tag = 0
        
        let spacingSlider = UISlider()
        spacingSlider.minimumValue = 0
        spacingSlider.maximumValue = 50
        spacingSlider.value = 10
        spacingSlider.tag = 1
        
        let edgeSlider = UISlider()
        edgeSlider.minimumValue = 0
        edgeSlider.maximumValue = 50
        edgeSlider.value = 10
        edgeSlider.tag = 2
        
        let sliders = [sizeSlider, spacingSlider, edgeSlider]
        sliders.forEach{
            $0.addTarget(self, action: #selector(layoutChange(_ :)), for: .valueChanged)
        }
        
        let stackView = UIStackView(arrangedSubviews: sliders)
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    @objc func layoutChange(_ slider: UISlider){
        let sliderValue = CGFloat(slider.value)
        if slider.tag == 0 {
            layout.itemSize = CGSize(width: sliderValue, height: sliderValue)
        } else if slider.tag == 1 {
            layout.minimumLineSpacing = sliderValue
            layout.minimumInteritemSpacing = sliderValue
        } else {
            layout.sectionInset = UIEdgeInsets(top: sliderValue, left: sliderValue, bottom: sliderValue, right: sliderValue)
        }
        
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: 100, height: 100)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    func setupNavigationItem() {
        let changeDirection = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(changeCollectionViewDirection))
        navigationItem.rightBarButtonItem = changeDirection
    }
    
    
    // MARK: Action
    
    @objc private func changeCollectionViewDirection(_ sender: Any) {
        layout.scrollDirection = (layout.scrollDirection == .horizontal) ? .vertical : .horizontal
        collectionView.reloadData()
    }
}


// MARK: - UICollectionViewDataSource

extension BasicCodeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.layer.cornerRadius = cell.frame.width / 2
        cell.backgroundColor = getColor(indexPath)
        return cell
    }
    
    func getColor(_ index: IndexPath) -> UIColor?{
        let a: CGFloat = CGFloat(index.item)
        let factor: CGFloat = a / 300
        return .init(hue: 1 - factor, saturation: 1 - factor, brightness: 1, alpha: 1)
    }
}
