//
//  FeedViewController.swift
//  CathoTeste
//
//  Created by Diggo Silva on 01/02/24.
//

import UIKit

class FeedViewModel {
    let apiKeys: ApiKeys
    
    var state: Bindable<FeedViewControllerStates> = Bindable(value: .loading)
    private var service = ServiceAuthenticator()
    let dispatchGroup = DispatchGroup()
    
    var token: UserInfo?
    var suggestionList: [Suggestion] = []
    var tipList: [Tips] = []
    
    init(apiKeys: ApiKeys) {
        self.apiKeys = apiKeys
    }
    
    func hasArrivedSuggestionAndTips() {
        if !suggestionList.isEmpty && !tipList.isEmpty {
            self.state.value = .loaded
        } else {
            self.state.value = .error
        }
    }
    
    func loadDataToken() {
        service.performAuth { userInfo in
            self.loadDataSuggestions(userInfo)
            self.loadDataTips()
            self.dispatchGroup.notify(queue: .main) {
                self.hasArrivedSuggestionAndTips()
            }
        } onError: { error in
            self.state.value = .error
        }
    }
    
    func loadDataSuggestions(_ userInfo: UserInfo) {
        dispatchGroup.enter()
        service.getSuggestion(userInfo: userInfo, apiKey: apiKeys) { suggestions in
            self.suggestionList = suggestions
            self.dispatchGroup.leave()
        } onError: { error in
            self.dispatchGroup.leave()
        }
    }
    
    func loadDataTips() {
        dispatchGroup.enter()
        service.getTips(apiKey: self.apiKeys) { tips in
            self.tipList = tips
            self.dispatchGroup.leave()
        } onError: { error in
            self.dispatchGroup.leave()
        }
    }
}

enum FeedViewControllerStates {
    case loading
    case loaded
    case error
}

class FeedViewController: UIViewController {
    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        return spinner
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Carregando..."
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [spinner, label])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()
    
    let viewModel: FeedViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        handleStates()
        viewModel.loadDataToken()
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
        spinner.startAnimating()
        label.isHidden = false
        stackView.isHidden = false
    }
    
    func showLoadedState() {
        spinner.stopAnimating()
        label.isHidden = true
        stackView.isHidden = true
    }
    
    func showErrorState() {
        let alert = UIAlertController(title: "Ocorreu um erro!", message: "Tentar novamente?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Sim", style: .default) { action in
            self.viewModel.loadDataToken()
        }
        let nok = UIAlertAction(title: "Não", style: .cancel) { action in
            self.showLoadedState()
        }
        alert.addAction(ok)
        alert.addAction(nok)
        present(alert, animated: true)
    }
    
    init(apiKeys: ApiKeys) {
        self.viewModel = FeedViewModel(apiKeys: apiKeys)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy () {
        view.backgroundColor = .systemYellow
        view.addSubview(label)
        view.addSubview(spinner)
        view.addSubview(stackView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
}
