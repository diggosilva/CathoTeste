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
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FeedTipsCell.self, forCellWithReuseIdentifier: FeedTipsCell.identifier)
        collectionView.alwaysBounceHorizontal = true
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    var tipsList: [Tips] = []
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(tipsList: [Tips]) {
        self.tipsList = tipsList
        tipsCollectionView.reloadData()
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy () {
        backgroundColor = .magenta
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
    func configCollectionCell(cell: FeedTipsCell) {
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 10
    }
}

extension FeedTipsView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tipsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedTipsCell.identifier, for: indexPath) as? FeedTipsCell else { return UICollectionViewCell() }
        cell.configure(model: tipsList[indexPath.row])
        configCollectionCell(cell: cell)
        return cell
    }
}

extension FeedTipsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
