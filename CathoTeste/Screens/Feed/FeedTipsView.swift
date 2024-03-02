//
//  FeedTipsView.swift
//  CathoTeste
//
//  Created by Diggo Silva on 02/03/24.
//

import UIKit

class FeedTipsView: UIView {
    
    //MARK: - TIPS VIEW
    
    lazy var hintLabel: UILabel = {
        Components.buildLabel(text: "#DicasDosRecrutadores", textColor: .white, font: .systemFont(ofSize: 20, weight: .semibold))
    }()
    
    lazy var tipsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.delegate = self
//        collectionView.dataSource = self
        collectionView.register(FeedTipsCell.self, forCellWithReuseIdentifier: FeedTipsCell.identifier)
        collectionView.alwaysBounceHorizontal = true
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy () {
        backgroundColor = .yellow
        addSubviews([hintLabel, tipsCollectionView])
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            hintLabel.topAnchor.constraint(equalTo: topAnchor),
            hintLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            hintLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            tipsCollectionView.topAnchor.constraint(equalTo: hintLabel.bottomAnchor, constant: 20),
            tipsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tipsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tipsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tipsCollectionView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
}
