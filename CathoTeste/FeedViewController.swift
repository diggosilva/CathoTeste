//
//  FeedViewController.swift
//  CathoTeste
//
//  Created by Diggo Silva on 01/02/24.
//

import UIKit

class FeedViewModel {
    let apiKeys: ApiKeys
    
    var state: Bindable<States> = Bindable(value: .loading)
    private var service = ServiceAuthenticator()
    let dispatchGroup = DispatchGroup()
    
    var token: UserInfo?
    var suggestionList: [Suggestion] = []
    var tipList: [Tips] = []
    var hasArrivedSuggestion: Bool = false
    var hasArrivedTips: Bool = false
    
    init(apiKeys: ApiKeys) {
        self.apiKeys = apiKeys
    }
    
    func hasArrivedSuggestionAndTips() {
        if self.hasArrivedSuggestion || self.hasArrivedTips {
            self.state.value = .loaded(self.apiKeys)
            print("Entrou aqui e tudo foi carregado")
        } else {
            print("Algo não foi carregado")
        }
    }
    
    func loadDataToken() {
        self.service.performAuth { token in
            self.state.value = .loading
            self.token = token
            self.loadDataSuggestions()
            self.loadDataTips()
        } onError: { error in
            self.state.value = .error
        }
    }
    
    func loadDataSuggestions() {
        if let userInfo = self.token {
            dispatchGroup.enter()
            self.service.getSuggestion(userInfo: userInfo, apiKey: self.apiKeys) { suggestions in
                self.state.value = .loading
                
                    self.suggestionList = suggestions
//                self.hasArrivedSuggestion = true
                print(self.hasArrivedSuggestion)
//                self.hasArrivedSuggestionAndTips()
            } onError: { error in
                self.state.value = .error
            }
            dispatchGroup.leave()
            print("DEBUG: Suggestion SAIU.")
        } else {
            print("DEBUG: UserInfo is nil.")
            self.state.value = .error
        }
    }
    
    func loadDataTips() {
        dispatchGroup.enter()
        self.service.getTips(apiKey: self.apiKeys) { tips in
            self.state.value = .loading
                self.tipList = tips
//            self.hasArrivedTips = true
            print(self.hasArrivedTips)
//            self.hasArrivedSuggestionAndTips()
            self.state.value = .loaded(self.apiKeys)
        } onError: { error in
            self.state.value = .error
        }
        dispatchGroup.leave()
        print("DEBUG: Tips SAIU.")
    }
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
//        viewModel.dispatchGroup.notify(queue: .main) {
//            print("DEU CERTO")
//        }
    }
    
    func handleStates() {
        viewModel.state.bind { state in
            switch state {
            case .loading:
                self.showLoadingState()
            case .loaded(_):
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
        print("DEBUG: CARREGANDO DADOS..")
    }
    
    func showLoadedState() {
        spinner.stopAnimating()
        label.isHidden = true
        stackView.isHidden = true
    }
    
    func showErrorState() {
        let alert = UIAlertController(title: "Ocorreu um erro!", message: "Falha ao carregar os Tokens \n\n ESSE ERRO TÁ FULEIRO", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { action in
            
        }
        alert.addAction(ok)
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
