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
//        feedView.feedSuggestionView.isHidden = true
//        feedView.feedTipsView.isHidden = true
        
    }
    
    func showLoadedState() {
        feedView.imageView.isHidden = false
        feedView.nameLabel.isHidden = false
        
//        feedView.feedSuggestionView.pageControl.numberOfPages = viewModel.numberOfRowsSuggestion()
//        feedView.feedSuggestionView.isHidden = false
//        feedView.feedSuggestionView.suggestionList = viewModel.suggestionList
//        feedView.feedSuggestionView.suggestionCollectionView.reloadData()
//        
//        feedView.feedTipsView.isHidden = false
        
        feedView.configure(suggestionList: viewModel.suggestionList, tipsList: viewModel.tipList)
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
}
