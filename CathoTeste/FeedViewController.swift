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
    
    var token: UserInfo?
    var suggestionList: [Suggestion] = []
    var tipList: [Tips] = []
    
    init(apiKeys: ApiKeys) {
        self.apiKeys = apiKeys
    }
    
    func loadDataToken() {
        guard !service.isUpdating() else { return }
        self.service.performAuth { token in
            self.state.value = .loading
//            print("DEBUG: Token.. \(token)")
            self.token = token
            self.loadDataSuggestions()
        } onError: { error in
            self.state.value = .error
        }
    }
    
    func loadDataSuggestions() {
        guard !service.isUpdating() else { return }
        if let userInfo = self.token {
            self.service.getSuggestion(userInfo: userInfo, apiKey: self.apiKeys) { suggestions in
                self.state.value = .loading
//                print("DEBUG: Suggestions.. \(suggestions)")
                UserSessionSingleton.shared.suggestionList.bind { suggestions in
                    self.suggestionList = suggestions
                }
                self.loadDataTips()
            } onError: { error in
                self.state.value = .error
            }
        } else {
            print("DEBUG: UserInfo is nil.")
            self.state.value = .error
        }
    }
    
    func loadDataTips() {
        guard !service.isUpdating() else { return }
        self.service.getTips(apiKey: self.apiKeys) { tips in
            self.state.value = .loading
//            print("DEBUG: Tips.. \(tips)")
            UserSessionSingleton.shared.tipList.bind { tips in
                self.tipList = tips
            }
            self.state.value = .loaded(self.apiKeys)
        } onError: { error in
            self.state.value = .error
        }
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
