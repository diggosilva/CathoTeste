//
//  FeedHeaderView.swift
//  CathoTeste
//
//  Created by Diggo Silva on 04/03/24.
//

import UIKit
import SDWebImage

class FeedHeaderView: UIView {
    //MARK: - APP PROFILE
    lazy var profileImage: UIImageView = {
        Components.buildImage()
    }()
    
    lazy var nameLabel: UILabel = {
        Components.buildLabel(text: "Olá, Nome", textColor: .white, font: .systemFont(ofSize: 20, weight: .regular))
    }()
    
    var candidate: UserInfo?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(candidate: UserInfo) {
        self.candidate = candidate
        guard let url = URL(string: candidate.photo) else { return }
        
        DispatchQueue.main.async {
            self.profileImage.sd_setImage(with: url)
            self.nameLabel.text = candidate.name
        }
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy () {
        backgroundColor = .brown
        addSubviews([profileImage, nameLabel])
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: topAnchor),
            profileImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            profileImage.widthAnchor.constraint(equalToConstant: 80),
            profileImage.heightAnchor.constraint(equalToConstant: 80),
            
            nameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nameLabel.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor),
        ])
    }
}
