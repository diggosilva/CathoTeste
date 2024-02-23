//
//  FeedViewController.swift
//  CathoTeste
//
//  Created by Diggo Silva on 01/02/24.
//

import UIKit

class FeedViewModel {
    let apiKeys: ApiKeys
    
    init(apiKeys: ApiKeys) {
        self.apiKeys = apiKeys
    }
}

class FeedViewController: UIViewController {
    
    let viewModel: FeedViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
       
    }
    
    init(apiKeys: ApiKeys) {
        self.viewModel = FeedViewModel(apiKeys: apiKeys)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
