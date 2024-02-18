//
//  SceneDelegate.swift
//  CathoTeste
//
//  Created by Diggo Silva on 01/02/24.
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
    
    lazy var viewModel: LoadingViewModelProtocol = LoadingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.loadData()
    }
    
    //MARK: - Handle States
    func handleStates() {
        viewModel.state.bind { states in
            switch states {
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
    }
    
    func showLoadedState() {
        spinner.stopAnimating()
    }
    
    func showErrorState() {
        let alert = UIAlertController(title: "Ocorreu um erro!", message: "Falha ao carregar as Chaves", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { action in
            
        }
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let vc = UINavigationController(rootViewController: FeedViewController())
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
    
    private func setHierarchy () {
        view.backgroundColor = .systemBackground
        view.addSubview(spinner)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

// MARK: - LoadingViewModel
enum States {
    case loading
    case loaded
    case error
}

protocol LoadingViewModelProtocol {
    var state: Bindable<States> { get set }
    
    // Request
    func loadData()
}

class LoadingViewModel: LoadingViewModelProtocol {
    var state: Bindable<States> = Bindable(value: .loading)
    
    private var service = ServiceAuthenticator()
    private var keys: [SessionKeys] = []
    
    func loadData() {
        guard !service.isUpdating() else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.service.getKeys { sessionKeys in
                self.keys = sessionKeys
                UserSessionSingleton.shared.keys.value = self.keys
            } onError: { error in
                self.state.value = .error
            }
        }
    }
}

// MARK: - SceneDelegate
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UINavigationController(rootViewController: LoadingViewController())
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}
