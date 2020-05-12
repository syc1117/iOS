//
//  CustumCell.swift
//  collectionViewStarter
//
//  Created by 신용철 on 2020/01/21.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit

class CustomCell: UICollectionViewCell {
    static let identifier = "CustomCell"
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemeted")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    func setupViews(){
        //imageView
        clipsToBounds = true //img 삐져나온것 절단
        layer.cornerRadius = 20
        imageView.contentMode = .scaleToFill
        contentView.addSubview(imageView)
        
        //label
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        contentView.addSubview(titleLabel)
    }
    
    func setupConstraints(){
        [imageView, titleLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        //isActive 매번하기 귀찮으면
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 50)
        ])
        
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical) //최소한 자신의 텍스트의 크기 만큼은 유지 되도록 하는 명령어
    }
    
 // MARK: Configure Cell
    
    //위에서 imageView, titleLabel을 private으로 설정해놓았기 때문에 접근이 안됨.
    //따라서 위의 객체들에 접근을 하기 위해서는 아래 함수를 통하는 방법밖에 없음.
    //아래와 같이 쓰는 이유: 위에 프로퍼티가 엄청 많은 경우에 건드리지 말아야할 것을 건드릴 수도 있기 때문에 원천 봉쇄. 또한 private으로 안해놓으면 폰트값 등 설정값을 다 건드릴 수 있기 때문에 바꾸지 못하게 하기 위해서 아래와 같이 구현해놓는 것이 안전함.
    func configure(img: UIImage?, title: String) {
        imageView.image = img
        titleLabel.text = title
    }
}
