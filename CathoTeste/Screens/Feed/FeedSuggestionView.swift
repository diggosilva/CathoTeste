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
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createSectionLayout())
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
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.addTarget(self, action: #selector(tappedPageControl), for: .valueChanged)
        return pageControl
    }()
    
    var suggestionList: [Suggestion] = []
    
    private var cellsItemHeight: NSCollectionLayoutDimension = .absolute(200)
    private var padding: CGFloat = 20
    private lazy var contentInsets = NSDirectionalEdgeInsets(top: 0, leading: padding, bottom: 0, trailing: padding)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        suggestionCollectionView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tappedPageControl(_ sender: UIPageControl) {
        UIView.animate(withDuration: 0.3) {
            self.suggestionCollectionView.scrollToItem(at: IndexPath(item: sender.currentPage, section: 0), at: .centeredHorizontally, animated: false)
        }
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
        
        section.visibleItemsInvalidationHandler = { [weak self] visibleItems, point, environment in
                self!.pageControl.currentPage = Int(floorf(Float(point.x) / Float((visibleItems.first?.frame.size.width)!)))
              }
        
        return UICollectionViewCompositionalLayout(section: section)
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

extension FeedSuggestionView: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
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
