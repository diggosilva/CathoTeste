//
//  FeedSuggestionView.swift
//  CathoTeste
//
//  Created by Diggo Silva on 01/03/24.
//

import UIKit

class FeedHeaderView: UIView {
    //MARK: - APP PROFILE
    lazy var imageView: UIImageView = {
        Components.buildImage()
    }()
    
    lazy var nameLabel: UILabel = {
        Components.buildLabel(text: "Olá, Nome", textColor: .white, font: .systemFont(ofSize: 20, weight: .regular))
    }()
    
    var candidate: UserInfo?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(candidate: UserInfo) {
        self.candidate = candidate
        nameLabel.text = "Banana"
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy () {
        backgroundColor = .brown
        addSubviews([imageView, nameLabel])
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nameLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
        ])
    }
}

class FeedSuggestionView: UIView {
    //MARK: - SUGGESTION VIEW
    lazy var suggestionLabel: UILabel = {
        Components.buildLabel(text: "Sugestões de vagas para você", textColor: .white, font: .systemFont(ofSize: 20, weight: .semibold))
    }()
    
    lazy var suggestionCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FeedSuggestionCell.self, forCellWithReuseIdentifier: FeedSuggestionCell.identifier)
        collectionView.alwaysBounceHorizontal = true
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
