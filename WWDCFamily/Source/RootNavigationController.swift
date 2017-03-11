//
//  RootNavigationController.swift
//  WWDCFamily
//
//  Created by Adrian Domanico on 3/10/17.
//  Copyright © 2017 WWDC Family. All rights reserved.
//

import UIKit

protocol RootChildViewController: class {

}

extension RootChildViewController where Self : UIViewController {
    var rootNavigationController: RootNavigationController! {
        return navigationController as! RootNavigationController
    }
}

final class RootNavigationController: UINavigationController, StoryboardInstance {

    static let storyboardName: String =  "Root"

    // MARK: Child VCs

    private lazy var authVC: AuthViewController = {
        return AuthViewController.storyboardInit()
    }()

    private lazy var mapVC: MapViewController = {
        return MapViewController.storyboardInit()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initialRouting()
    }

    // MARK: Routing

    func routeToMap(animated: Bool) {
        setViewControllers([authVC, mapVC], animated: animated)
    }

    func routeToAuth(animated: Bool) {
        popToRootViewController(animated: animated)
    }

    private func initialRouting() {
        setViewControllers([authVC, mapVC], animated: false)

        guard Session.sharedInstance.isLoggedIn else {
            routeToAuth(animated: false)
            return
        }

        routeToMap(animated: false)
    }

}
