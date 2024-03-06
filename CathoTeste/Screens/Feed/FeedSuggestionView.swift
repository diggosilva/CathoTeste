//
//  FeedSuggestionView.swift
//  CathoTeste
//
//  Created by Diggo Silva on 01/03/24.
//

import UIKit

class FeedSuggestionView: UIView {
    //MARK: - SUGGESTION VIEW
    lazy var suggestionLabel: UILabel = {
        Components.buildLabel(text: "Sugestões de vagas para você", textColor: .white, font: .systemFont(ofSize: 20, weight: .semibold))
    }()
    
    lazy var suggestionCollectionView: UICollectionView = {
        //        let layout = UICollectionViewFlowLayout()
        //        layout.scrollDirection = .horizontal
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FeedSuggestionCell.self, forCellWithReuseIdentifier: FeedSuggestionCell.identifier)
        collectionView.alwaysBounceHorizontal = false
        collectionView.alwaysBounceVertical = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    lazy var pageControl: UIPageControl = {
        Components.buildPageControl()
    }()
    
    var suggestionList: [Suggestion] = []
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
//        var sectionTypes = suggestionList
        return createEpisodeSectionLayout()
    }
    
    public func createEpisodeSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(UIDevice.isiPhone ? 1.0 : 0.2),
                                                                                          heightDimension: .absolute(200)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    func configure(suggestionList: [Suggestion]) {
        self.suggestionList = suggestionList
        pageControl.numberOfPages = suggestionList.count
        suggestionCollectionView.reloadData()
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy () {
        backgroundColor = .red
        addSubviews([suggestionLabel, suggestionCollectionView, pageControl])
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            suggestionLabel.topAnchor.constraint(equalTo: topAnchor),
            suggestionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            suggestionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            suggestionCollectionView.topAnchor.constraint(equalTo: suggestionLabel.bottomAnchor, constant: 20),
            suggestionCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            suggestionCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            suggestionCollectionView.heightAnchor.constraint(equalToConstant: 200),
            
            pageControl.centerXAnchor.constraint(equalTo: suggestionCollectionView.centerXAnchor),
            pageControl.topAnchor.constraint(equalTo: suggestionCollectionView.bottomAnchor, constant: 20),
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func configCollectionCell(cell: FeedSuggestionCell) {
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 10
    }
}

extension FeedSuggestionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return suggestionList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedSuggestionCell.identifier, for: indexPath) as? FeedSuggestionCell else { return UICollectionViewCell() }
        cell.configure(model: suggestionList[indexPath.row])
        configCollectionCell(cell: cell)
        return cell
    }
}

extension FeedSuggestionView: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
