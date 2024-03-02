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
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.delegate = self
//        collectionView.dataSource = self
        collectionView.register(FeedSuggestionCell.self, forCellWithReuseIdentifier: FeedSuggestionCell.identifier)
        collectionView.alwaysBounceHorizontal = true
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    lazy var pageControl: UIPageControl = {
        Components.buildPageControl()
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
}

//extension FeedSuggestionView: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        <#code#>
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//}
