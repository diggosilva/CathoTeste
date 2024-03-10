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
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createSectionLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FeedTipsCell.self, forCellWithReuseIdentifier: FeedTipsCell.identifier)
        collectionView.alwaysBounceHorizontal = false
        collectionView.alwaysBounceVertical = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private var cellsItemHeight: NSCollectionLayoutDimension = .absolute(200)
    private var padding: CGFloat = 20
    private lazy var contentInsets = NSDirectionalEdgeInsets(top: 0, leading: padding, bottom: 0, trailing: padding)
    
    var tipsList: [Tips] = []
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func createSectionLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: cellsItemHeight)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: cellsItemHeight)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = contentInsets
        section.orthogonalScrollingBehavior = .groupPaging
        return UICollectionViewCompositionalLayout(section: section)
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
