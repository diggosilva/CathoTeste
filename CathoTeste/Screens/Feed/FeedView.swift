//
//  FeedView.swift
//  CathoTeste
//
//  Created by Diggo Silva on 29/02/24.
//

import UIKit

class FeedView: UIView {
    
    lazy var scroll: UIScrollView = {
        let x = UIScrollView()
        x.translatesAutoresizingMaskIntoConstraints = false
        return x
    }()
    
    lazy var contentView: UIView = {
        let x = UIView()
        x.translatesAutoresizingMaskIntoConstraints = false
        return x
    }()
    
    //MARK: - APP PROFILE
    lazy var imageView: UIImageView = {
        Components.buildImage()
    }()
    
    lazy var nameLabel: UILabel = {
        Components.buildLabel(text: "Olá, Nome", textColor: .white, font: .systemFont(ofSize: 20, weight: .regular))
    }()
    
    //MARK: - HEADERVIEW PROFILEIMAGE & NAME
    private lazy var feedHeaderView = FeedHeaderView()
    
    //MARK: - COLLECTIONVIEW SUGGESTIONS
    private lazy var feedSuggestionView = FeedSuggestionView()
    
    //MARK: - COLLECTIONVIEW TIPS
    private lazy var feedTipsView = FeedTipsView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(candidate: UserInfo, suggestionList: [Suggestion], tipsList: [Tips]) {
        feedSuggestionView.configure(suggestionList: suggestionList)
        feedTipsView.configure(tipsList: tipsList)
        feedHeaderView.configure(candidate: candidate)
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        backgroundColor = .azulCatho
        
        feedHeaderView.translatesAutoresizingMaskIntoConstraints = false
        feedSuggestionView.translatesAutoresizingMaskIntoConstraints = false
        feedTipsView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(scroll)
        scroll.addSubview(contentView)
        contentView.addSubviews([feedHeaderView, feedSuggestionView, feedTipsView])
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scroll.leadingAnchor.constraint(equalTo: leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scroll.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scroll.widthAnchor),
        ])
        
        NSLayoutConstraint.activate([
            feedHeaderView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            feedHeaderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            feedHeaderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            feedHeaderView.heightAnchor.constraint(equalToConstant: 80),
            
            feedSuggestionView.topAnchor.constraint(equalTo: feedHeaderView.bottomAnchor, constant: 40),
            feedSuggestionView.leadingAnchor.constraint(equalTo: feedHeaderView.leadingAnchor),
            feedSuggestionView.trailingAnchor.constraint(equalTo: feedHeaderView.trailingAnchor),
            
            feedTipsView.topAnchor.constraint(equalTo: feedSuggestionView.bottomAnchor, constant: 40),
            feedTipsView.leadingAnchor.constraint(equalTo: feedSuggestionView.leadingAnchor),
            feedTipsView.trailingAnchor.constraint(equalTo: feedSuggestionView.trailingAnchor),
            
            feedTipsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
