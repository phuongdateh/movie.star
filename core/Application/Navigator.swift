//
//  Navigator.swift
//  core
//
//  Created by phuong.doan on 7/18/21.
//

import Foundation
import UIKit
import Hero

protocol Navigatable {
    var navigator: Navigator! { get set }
}

class Navigator {
    static var `default` = Navigator()
    
    // MARK: - segues list, all app scenes
    enum Scene {
        case splash(SplashViewModel)
        case getstarted(viewModel: GetStartedViewModel)
        case tabbar(viewModel: TabbarViewModel)
        case videoPlaying(viewModel: VideoPlayingViewModel)
        case movieDetail(moviedId: Int)
        case creditDetail(id: Int)
        case movieList(title: String?,
                       movies: [Movie]?,
                       genre: Genre?,
                       item: HomeMovieSectionItem?)
        case about
        case myFavorite
        case login(LoginType)
    }
    
    enum Transition {
        case tabbar(in: UIWindow)
        case root(in: UIWindow)
        case navigation(type: HeroDefaultAnimationType)
        case customModal(type: HeroDefaultAnimationType)
        case modal
        case detail
        case alert
        case custom
    }
}

extension Navigator {
    func get(scene: Scene) -> UIViewController?  {
        switch scene {
        case .myFavorite:
            let viewModel = FavoriteViewModel()
            let vc = FavoriteViewController.fromNib()
            vc.set(viewModel: viewModel,
                   navigator: self)
            return vc
        case .about:
            let viewModel = AboutViewModel()
            let vc = AboutViewController.fromNib()
            vc.set(viewModel: viewModel, navigator: self)
            return vc
        case let .movieList(title: title,
                            movies: movies,
                            genre: genre,
                            item: item):
            let viewModel = MovieListViewModel(movies: movies,
                                               title: title,
                                               genre: genre,
                                               item: item)
            let vc = MovieListViewController.fromNib()
            vc.set(viewModel: viewModel,
                   navigator: self)
            return vc
        case let .creditDetail(id: id):
            let viewModel = CreditsDetailViewModel(id: id)
            let vc = CreditsDetailViewController.fromNib()
            vc.set(viewModel: viewModel,
                   navigator: self)
            return vc
        case let .movieDetail(moviedId: id):
            let viewModel = MovieDetailViewModel(movieId: id)
            let vc = MovieDetailViewController.fromNib()
            vc.set(viewModel: viewModel,
                   navigator: self)
            return vc
        case .splash(let viewModel):
            let vc = SplashViewController.fromNib()
            vc.set(viewModel: viewModel,
                   navigator: self)
            let navitaionController = NavigationController(rootViewController: vc)
            return navitaionController
        case .getstarted(viewModel: let viewModel):
            let vc = GetStartedV2ViewController.fromNib()
            vc.set(viewModel: viewModel,
                   navigator: self)
            return vc
        case let .tabbar(viewModel: viewModel):
            let storyboard = UIStoryboard(name: "Tabbar", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "TabbarViewController") as! TabbarViewController
            vc.viewModel = viewModel
            vc.navigator = self
            vc.setupChilds()
            return vc
        case let .videoPlaying(viewModel: viewModel):
            let vc = VideoPlayingViewController.fromNib()
            vc.set(viewModel: viewModel,
                   navigator: self)
            return vc
        case .login(let type):
            let vc = LoginViewController()
            vc.set(viewModel: LoginViewModel(), navigator: self)
            vc.type = type
            return vc
        }
    }
}

extension Navigator {
    func pop(sender: UIViewController?, toRoot: Bool = false) {
        if toRoot {
            sender?.navigationController?.popToRootViewController(animated: true)
        } else {
            sender?.navigationController?.popViewController(animated: true)
        }
    }
    
    func dismiss(sender: UIViewController?) {
        sender?.navigationController?.dismiss(animated: true, completion: nil)
    }
}

extension Navigator {
    func show(segue: Scene,
              sender: UIViewController?,
              transition: Transition = .navigation(type: .cover(direction: .left))) {
        if let target = self.get(scene: segue) {
            self.show(target: target, sender: sender, transition: transition)
        }
    }
    
    private func show(target: UIViewController,
                      sender: UIViewController?,
                      transition: Transition) {
        switch transition {
        case .root(in: let window),
                .tabbar(in: let window):
            window.rootViewController = target
            UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                window.rootViewController = target
            }, completion: nil)
            return
        default:
            break
        }
        
        guard let sender = sender else {
            fatalError("You need to pass in a sender for .navigation or .modal transitions")
        }
        
        if let nav = sender as? UINavigationController {
            // push root controller on navigation stack
            nav.pushViewController(target, animated: false)
            return
        }
        
        switch transition {
        case .navigation(let type):
            if let nav = sender.navigationController {
                // push controller to navigation stack
                nav.hero.navigationAnimationType = .autoReverse(presenting: type)
                target.hidesBottomBarWhenPushed = true
                nav.pushViewController(target, animated: true)
            }
        case .customModal(let type):
            // present modally with custom animation
            DispatchQueue.main.async {
                let nav = NavigationController(rootViewController: target)
                nav.hero.modalAnimationType = .autoReverse(presenting: type)
                sender.present(nav, animated: true, completion: nil)
            }
        case .modal:
            // present modally
            DispatchQueue.main.async {
                target.modalPresentationStyle = .fullScreen
                sender.present(target, animated: true, completion: nil)
            }
        case .detail:
            DispatchQueue.main.async {
                let nav = NavigationController(rootViewController: target)
                sender.showDetailViewController(nav, sender: nil)
            }
        case .alert:
            DispatchQueue.main.async {
                sender.present(target, animated: true, completion: nil)
            }
        default: break
        }
        
    }
}
