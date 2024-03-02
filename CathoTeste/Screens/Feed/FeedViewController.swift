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
        feedView.feedTipsView.isHidden = true
    }
    
    func showLoadedState() {
        feedView.imageView.isHidden = false
        feedView.nameLabel.isHidden = false
        
        feedView.feedSuggestionView.suggestionCollectionView.delegate = self
        feedView.feedSuggestionView.suggestionCollectionView.dataSource = self
        feedView.feedSuggestionView.pageControl.numberOfPages = viewModel.numberOfRowsSuggestion()
        feedView.feedSuggestionView.isHidden = false
        
        feedView.feedTipsView.tipsCollectionView.delegate = self
        feedView.feedTipsView.tipsCollectionView.dataSource = self
        feedView.feedTipsView.isHidden = false
    }
    
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
    
    func configCollectionCell(cell: FeedSuggestionCell) {
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 10
    }
}

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRowsSuggestion()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedSuggestionCell.identifier, for: indexPath) as? FeedSuggestionCell else { return UICollectionViewCell() }
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
