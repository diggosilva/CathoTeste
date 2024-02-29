//
//  FeedCell.swift
//  CathoTeste
//
//  Created by Diggo Silva on 29/02/24.
//

import UIKit

class FeedCell: UICollectionViewCell {
    static let identifier = "FeedCell"
    
    lazy var titleLabel1: UILabel = {
        Components.buildLabel(text: "Assistente de Telemarketing Ativista", textColor: .systemBlue, font: .systemFont(ofSize: 16, weight: .semibold))
    }()
    
    lazy var titleLabel2: UILabel = {
        Components.buildLabel(text: "WESGERBER Transportadora de laticínios", textColor: .gray, font: .systemFont(ofSize: 16))
    }()
    
    lazy var titleLabel3: UILabel = {
        Components.buildLabel(text: "3 vagas - São Paulo (SP) + 3 cidades", textColor: .gray, font: .systemFont(ofSize: 16))
    }()
    
    lazy var titleLabel4: UILabel = {
        Components.buildLabel(text: "R$2.001,00 a R$3.000,00", textColor: .gray, font: .systemFont(ofSize: 16, weight: .semibold))
    }()
    
    lazy var vStackView: UIStackView = {
        Components.buildStack(arrangedSubviews: [titleLabel1, titleLabel2, titleLabel3, titleLabel4], axis: .vertical)
    }()
    
    lazy var titleLabel1Day: UILabel = {
        Components.buildLabel(text: "hoje", textColor: .systemOrange, font: .boldSystemFont(ofSize: 16), textAlignment: .right)
    }()
    
    lazy var eyeImageView: UIImageView = {
        Components.buildEyeImage()
    }()
    
    lazy var enviarCVButton: UIButton = {
        Components.buildButtonSendCV()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: Suggestion) {
        titleLabel1.text = model.company
        titleLabel2.text = model.jobAdTile
        titleLabel3.text = model.locations.first
        titleLabel4.text = model.salary.range
        titleLabel1Day.text = model.date
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy () {
        addSubviews([vStackView, titleLabel1Day, eyeImageView, enviarCVButton])
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            vStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            vStackView.trailingAnchor.constraint(equalTo: titleLabel1Day.leadingAnchor, constant: -15),
            
            titleLabel1Day.topAnchor.constraint(equalTo: vStackView.topAnchor),
            titleLabel1Day.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            eyeImageView.bottomAnchor.constraint(equalTo: vStackView.bottomAnchor),
            eyeImageView.trailingAnchor.constraint(equalTo: titleLabel1Day.trailingAnchor),
            
            enviarCVButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            enviarCVButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            enviarCVButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            enviarCVButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}
