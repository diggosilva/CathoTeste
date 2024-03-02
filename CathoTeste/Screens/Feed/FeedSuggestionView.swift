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
        Components.buildCollectionView()
    }()
    
    lazy var pageControl: UIPageControl = {
        Components.buildPageControl()
    }()
    
    lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [suggestionLabel, suggestionCollectionView, pageControl])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
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
        
        addSubviews([vStackView])
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
//            vStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
//            vStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
//            vStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            vStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            vStackView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
}
