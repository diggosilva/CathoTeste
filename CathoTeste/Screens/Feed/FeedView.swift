//
//  FeedView.swift
//  CathoTeste
//
//  Created by Diggo Silva on 29/02/24.
//

import UIKit

class FeedView: UIView {
    
    //MARK: - APP PROFILE
    lazy var imageView: UIImageView = {
        Components.buildImage()
    }()
    
    lazy var nameLabel: UILabel = {
        Components.buildLabel(text: "Olá, Nome", textColor: .white, font: .systemFont(ofSize: 20, weight: .regular))
    }()
    
    //MARK: - COLLECTIONVIEW
    lazy var feedSuggestionView = FeedSuggestionView()
    
    //MARK: - CARD INFERIOR HINTS
    lazy var feedTipsView = FeedTipsView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUserInfo(model: UserInfo) {
        nameLabel.text = "Olá, \(model.name)"
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        backgroundColor = .azulCatho
        
        feedSuggestionView.translatesAutoresizingMaskIntoConstraints = false
        feedTipsView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews([
            imageView, nameLabel, feedSuggestionView
        ])
        addSubview(feedTipsView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            
            feedSuggestionView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40),
            feedSuggestionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            feedSuggestionView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            feedSuggestionView.heightAnchor.constraint(equalToConstant: 200),
            
            
            
            
            feedTipsView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            feedTipsView.leadingAnchor.constraint(equalTo: feedSuggestionView.leadingAnchor),
            feedTipsView.trailingAnchor.constraint(equalTo: feedSuggestionView.trailingAnchor),
//            feedTipsView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
}
