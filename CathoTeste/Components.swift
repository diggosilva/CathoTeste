//
//  Components.swift
//  CathoTeste
//
//  Created by Diggo Silva on 29/02/24.
//

import UIKit

class Components {
    static func buildImage() -> UIImageView{
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 40
        imageView.layer.borderWidth = 6
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.backgroundColor = .systemGray5
        return imageView
    }
    
    static func buildLabel(text: String, textColor: UIColor, font: UIFont, numberOfLines: Int = 1, textAlignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textColor = textColor
        label.font = font
        label.numberOfLines = numberOfLines
        label.textAlignment = textAlignment
        return label
    }
    
    static func buildCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: FeedCell.identifier)
        collectionView.alwaysBounceHorizontal = true
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }
    
    static func buildButtonSendCV() -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("ENVIAR CURRÍCULO", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .azulCatho
        button.layer.cornerRadius = 5
        return button
    }
    
    static func buildEyeImage() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "eye.fill")?.withTintColor(.azulCatho, renderingMode: .alwaysOriginal)
        return imageView
    }
    
    static func buildPageControl() -> UIPageControl {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .white
        return pageControl
    }
    
    static func buildHintCardBG() -> UIView {
        let card = UIView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.backgroundColor = .white
        card.layer.cornerRadius = 10
        return card
    }
    
    static func buildButtonCheckCV() -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("CHECAR CURRÍCULO", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.setTitleColor(.azulCatho, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.azulCatho.cgColor
        button.layer.cornerRadius = 5
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 160).isActive = true
        return button
    }
    
    static func buildButtonLikeDislike(systemName: String) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFill
        button.setImage(UIImage(systemName: systemName), for: .normal)
        button.tintColor = .gray
        return button
    }
    
    static func buildStack(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = axis
        stackView.spacing = 5
        stackView.distribution = .fillProportionally
        return stackView
    }
}
