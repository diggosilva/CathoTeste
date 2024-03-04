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
    
//    func configureUserInfo(model: UserInfo) {
//        nameLabel.text = "Olá, \(model.name)"
//    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        backgroundColor = .azulCatho
        
        feedSuggestionView.translatesAutoresizingMaskIntoConstraints = false
        feedTipsView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(scroll)
        scroll.addSubview(contentView)
        contentView.addSubviews([imageView, nameLabel, feedSuggestionView, feedTipsView])
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
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            nameLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            
            feedSuggestionView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40),
            feedSuggestionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            feedSuggestionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            feedTipsView.topAnchor.constraint(equalTo: feedSuggestionView.bottomAnchor, constant: 40),
            feedTipsView.leadingAnchor.constraint(equalTo: feedSuggestionView.leadingAnchor),
            feedTipsView.trailingAnchor.constraint(equalTo: feedSuggestionView.trailingAnchor),
            
            feedTipsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
