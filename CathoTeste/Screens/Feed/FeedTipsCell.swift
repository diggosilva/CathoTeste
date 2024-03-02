//
//  FeedTipsCell.swift
//  CathoTeste
//
//  Created by Diggo Silva on 02/03/24.
//

import UIKit

class FeedTipsCell: UICollectionViewCell {
    static let identifier = "FeedTipsCell"
    
    lazy var hintLabel: UILabel = {
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
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: Tips) {
        hintLabel.text = model.description
        checarCVButton.setTitle(model.button.label, for: .normal)
        checarCVButton.isHidden = model.button.show
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy () {
        addSubviews([hintLabel, hStackView])
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            hintLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            hintLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            hintLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            hStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            hStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            hStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            hStackView.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}
