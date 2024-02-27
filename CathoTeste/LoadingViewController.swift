//
//  LoadingViewController.swift
//  CathoTeste
//
//  Created by Diggo Silva on 21/02/24.
//

import UIKit

// MARK: - LoadingViewController
class LoadingViewController: UIViewController {
    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        return spinner
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Aguarde"
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
    
    let viewModel: LoadingViewModelProtocol = LoadingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        animateIntro()
        handleStates()
        viewModel.loadData()
    }
    
    func animateIntro() {
        UIView.animate(withDuration: 0.5, animations: {
            self.spinner.center.y -= 10
            self.label.center.y += 10
        }) { (finished) in
            self.spinner.startAnimating()
        }
    }
    
    //MARK: - Handle States
    func handleStates() {
        viewModel.state.bind { states in
            switch states {
            case .loading:
                self.showLoadingState()
            case .loaded(let value):
                self.showLoadedState(value: value)
            case .error:
                self.showErrorState()
            }
        }
    }
    
    func showLoadingState() {
        stackView.isHidden = false
    }
    
    func showLoadedState(value: ApiKeys) {
        spinner.stopAnimating()
        stackView.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            let vc = FeedViewController(apiKeys: value)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
    
    func showErrorState() {
        let alert = UIAlertController(title: "Ocorreu um erro!", message: "Falha ao carregar as Chaves", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { action in
            self.spinner.stopAnimating()
            self.stackView.isHidden = true
        }
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy () {
        view.backgroundColor = .systemBackground
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
