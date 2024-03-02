//
//  FeedCell.swift
//  CathoTeste
//
//  Created by Diggo Silva on 29/02/24.
//

import UIKit

class FeedCell: UICollectionViewCell {
    static let identifier = "FeedCell"
    
    lazy var companyLabel: UILabel = {
        Components.buildLabel(text: "Assistente de Telemarketing Ativista", textColor: .systemBlue, font: .systemFont(ofSize: 16, weight: .semibold))
    }()
    
    lazy var jobLabel: UILabel = {
        Components.buildLabel(text: "WESGERBER Transportadora de laticínios", textColor: .gray, font: .systemFont(ofSize: 16))
    }()
    
    lazy var locationsLabel: UILabel = {
        Components.buildLabel(text: "3 vagas - São Paulo (SP) + 3 cidades", textColor: .gray, font: .systemFont(ofSize: 16))
    }()
    
    lazy var salaryLabel: UILabel = {
        Components.buildLabel(text: "R$2.001,00 a R$3.000,00", textColor: .gray, font: .systemFont(ofSize: 16, weight: .semibold))
    }()
    
    lazy var vStackView: UIStackView = {
        Components.buildStack(arrangedSubviews: [companyLabel, jobLabel, locationsLabel, salaryLabel], axis: .vertical)
    }()
    
    lazy var dateLabel: UILabel = {
        Components.buildLabel(text: "hoje", textColor: .systemOrange, font: .boldSystemFont(ofSize: 16), textAlignment: .right)
    }()
    
    lazy var eyeImageView: UIImageView = {
        Components.buildEyeImage()
    }()
    
    lazy var sendCVButton: UIButton = {
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
        companyLabel.text = model.company
        jobLabel.text = model.jobAdTile
        locationsLabel.text = model.locations.joined(separator: "; ")
        salaryLabel.text = model.salary.range
        dateLabel.text = model.date
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy () {
        addSubviews([vStackView, dateLabel, eyeImageView, sendCVButton])
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            vStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            vStackView.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -15),
            
            dateLabel.topAnchor.constraint(equalTo: vStackView.topAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            eyeImageView.bottomAnchor.constraint(equalTo: vStackView.bottomAnchor),
            eyeImageView.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            
            sendCVButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            sendCVButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            sendCVButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            sendCVButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}
