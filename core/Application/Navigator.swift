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
    }
    
    enum Transition {
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
        case .splash(let viewModel):
            let storyboard = UIStoryboard(name: "Splash", bundle: nil)
            let vc = storyboard.instantiateViewController(ofType: SplashViewController.self)
            vc.viewModel = viewModel
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
    func show(scene: Scene,
              sender: UIViewController?,
              transition: Transition = .navigation(type: .cover(direction: .left))) {
        if let target = self.get(scene: scene) {
            self.show(target: target, sender: sender, transition: transition)
        }
    }
    
    private func show(target: UIViewController,
                      sender: UIViewController?,
                      transition: Transition) {
        switch transition {
        case .root(in: let window):
            window.rootViewController = target
//            UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft, animations: {
//                window.rootViewController = target
//            }, completion: nil)
            return
        default:
            break
        }
        
        guard let sender = sender else {
            fatalError("You need to pass in a sender for .navigation or .modal transitions")
        }
        
        if let navigationController = sender.navigationController {
            // push root controller on navigation stack
            navigationController.pushViewController(target, animated: true)
            return
        }
        
        switch transition {
        case .navigation(let type):
            if let nav = sender.navigationController {
                // push controller to navigation stack
                nav.hero.navigationAnimationType = .autoReverse(presenting: type)
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
                let nav = NavigationController(rootViewController: target)
                sender.present(nav, animated: true, completion: nil)
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