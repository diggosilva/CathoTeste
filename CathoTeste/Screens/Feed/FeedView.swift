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
    lazy var suggestionLabel: UILabel = {
        Components.buildLabel(text: "Sugestões de vagas para você", textColor: .white, font: .systemFont(ofSize: 20, weight: .semibold))
    }()
    
    lazy var suggestionCollectionView: UICollectionView = {
        Components.buildCollectionView()
    }()
    
    lazy var pageControl: UIPageControl = {
        Components.buildPageControl()
    }()
    
    //MARK: - CARD INFERIOR
    lazy var hintLabel: UILabel = {
        Components.buildLabel(text: "#DicasDosRecrutadores", textColor: .white, font: .systemFont(ofSize: 20, weight: .semibold))
    }()
    
    lazy var hintCard: UIView = {
        Components.buildHintCardBG()
    }()
    
    lazy var hintLabel2: UILabel = {
        Components.buildLabel(text: "Antes de enviar o seu currículo, que tal bla bla bla", textColor: .gray, font: .systemFont(ofSize: 16, weight: .regular), numberOfLines: 0)
    }()
    
    lazy var checarCVButton: UIButton = {
        Components.buildButtonCheckCV()
    }()
    
    lazy var utilLabel: UILabel = {
        Components.buildLabel(text: "Achou útil?", textColor: .gray, font: .systemFont(ofSize: 16, weight: .regular))
    }()
    
    lazy var thumbsUpButton: UIButton = {
        Components.buildButtonLikeDislike(systemName: "hand.thumbsup.fill")
    }()
    
    lazy var thumbsDownButton: UIButton = {
        Components.buildButtonLikeDislike(systemName: "hand.thumbsdown.fill")
    }()
    
    lazy var hStackView: UIStackView = {
        Components.buildStack(arrangedSubviews: [checarCVButton, utilLabel, thumbsUpButton, thumbsDownButton], axis: .horizontal)
    }()
    
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
    
    func configureTips(model: Tips) {
        
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        backgroundColor = .azulCatho
        
        addSubviews([
            imageView, nameLabel, suggestionLabel, suggestionCollectionView, pageControl,
            hintLabel, hintCard, hintLabel2, hStackView
        ])
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            
            suggestionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40),
            suggestionLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            suggestionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            suggestionCollectionView.topAnchor.constraint(equalTo: suggestionLabel.bottomAnchor, constant: 20),
            suggestionCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            suggestionCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            suggestionCollectionView.heightAnchor.constraint(equalToConstant: 200),
            
            pageControl.topAnchor.constraint(equalTo: suggestionCollectionView.bottomAnchor, constant: 20),
            pageControl.centerXAnchor.constraint(equalTo: suggestionCollectionView.centerXAnchor),
            
            hintLabel.bottomAnchor.constraint(equalTo: hintCard.topAnchor, constant: -20),
            hintLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            hintLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20),
            
            hintCard.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            hintCard.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            hintCard.trailingAnchor.constraint(equalTo: suggestionLabel.trailingAnchor),
            hintCard.heightAnchor.constraint(equalToConstant: 200),
            
            hintLabel2.topAnchor.constraint(equalTo: hintCard.topAnchor, constant: 15),
            hintLabel2.leadingAnchor.constraint(equalTo: hintCard.leadingAnchor, constant: 15),
            hintLabel2.trailingAnchor.constraint(equalTo: hintCard.trailingAnchor, constant: -15),
            
            hStackView.bottomAnchor.constraint(equalTo: hintCard.bottomAnchor, constant: -15),
            hStackView.leadingAnchor.constraint(equalTo: hintCard.leadingAnchor, constant: 15),
            hStackView.trailingAnchor.constraint(equalTo: hintCard.trailingAnchor, constant: -15),
        ])
    }
}
