//
//  FeedViewController.swift
//  CathoTeste
//
//  Created by Diggo Silva on 01/02/24.
//

import UIKit

class FeedViewController: UIViewController {
    private let feedView = FeedView()
    private let viewModel: FeedViewModel
    
    override func loadView() {
        view = feedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleStates()
        viewModel.loadDataToken()
    }
    
    init(apiKeys: ApiKeys) {
        self.viewModel = FeedViewModel(apiKeys: apiKeys)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func handleStates() {
        viewModel.state.bind { state in
            switch state {
            case .loading:
                self.showLoadingState()
            case .loaded:
                self.showLoadedState()
            case .error:
                self.showErrorState()
            }
        }
    }
    
    
    func showLoadingState() {
        feedView.imageView.isHidden = true
        feedView.nameLabel.isHidden = true
        feedView.feedSuggestionView.isHidden = true
        self.feedView.hintCard.isHidden = true
        self.feedView.hintLabel.isHidden = true
        self.feedView.hintLabel2.isHidden = true
        self.feedView.hStackView.isHidden = true
    }
    
    func showLoadedState() {
        feedView.feedSuggestionView.suggestionCollectionView.delegate = self
        feedView.feedSuggestionView.suggestionCollectionView.dataSource = self
        feedView.imageView.isHidden = false
        feedView.nameLabel.isHidden = false
        feedView.feedSuggestionView.isHidden = false
        feedView.feedSuggestionView.pageControl.numberOfPages = viewModel.numberOfRows()
    }
    
    
//    func showLoadingState() {
//        feedView.imageView.isHidden = true
//        feedView.nameLabel.isHidden = true
//        feedView.suggestionLabel.isHidden = true
//        feedView.suggestionCollectionView.isHidden = true
//        self.feedView.hintCard.isHidden = true
//        self.feedView.hintLabel.isHidden = true
//        self.feedView.hintLabel2.isHidden = true
//        self.feedView.hStackView.isHidden = true
//    }
//    
//    func showLoadedState() {
//        feedView.suggestionCollectionView.delegate = self
//        feedView.suggestionCollectionView.dataSource = self
//        feedView.imageView.isHidden = false
//        feedView.nameLabel.isHidden = false
//        feedView.suggestionLabel.isHidden = false
//        feedView.suggestionCollectionView.isHidden = false
//        feedView.pageControl.numberOfPages = viewModel.numberOfRows()
//    }
    
    func showErrorState() {
        let alert = UIAlertController(title: "Ocorreu um erro!", message: "Tentar novamente?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Sim", style: .default) { action in
            self.showLoadingState()
            self.viewModel.loadDataToken()
        }
        let nok = UIAlertAction(title: "Não", style: .cancel) { action in
            self.showLoadingState()
        }
        alert.addAction(ok)
        alert.addAction(nok)
        present(alert, animated: true)
    }
    
    func configCollectionCell(cell: FeedCell) {
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 10
    }
}

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCell.identifier, for: indexPath) as? FeedCell else { return UICollectionViewCell() }
        let collectionCell = viewModel.suggestion(of: indexPath)
        cell.configure(model: collectionCell)
        configCollectionCell(cell: cell)
        return cell
    }
}

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
