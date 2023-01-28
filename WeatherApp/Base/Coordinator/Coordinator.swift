//
//  Coordinator.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 25/01/23.
//

import SwiftUI

open class Coordinator<R: Router>: ObservableObject {
    
    public let navigationController: UINavigationController
    public let startingRoute: R?
    
    public init(
        navigationController: UINavigationController = .init(),
        startingRoute: R? = nil
    ) {
        self.navigationController = navigationController
        self.startingRoute = startingRoute
    }
    
    public func start() {
        guard let route = startingRoute else { return }
        show(route)
    }
    
    public func show(
        _ route: R,
        animated: Bool = true) {
            let view = route.view()
            let viewWithCoordinator = view.environmentObject(self)
            let viewController = UIHostingController(rootView: viewWithCoordinator)
            
            if case .push = route.transition {
                navigationController.view.layer.add(
                    Transitions.fade,
                    forKey: nil
                )
                navigationController.pushViewController(
                    viewController,
                    animated: false
                )
                return
            }
            
            if case .default = route.transition {
                navigationController.pushViewController(
                    viewController,
                    animated: true
                )
                return
            }
            
            viewController.modalPresentationStyle = route.transition.presentationStyle
            navigationController.present(
                viewController,
                animated: true
            )
        }
    
    public func pop(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
    
    public func popToRoot(animated: Bool = true) {
        navigationController.popToRootViewController(animated: animated)
    }
    
    open func dismiss(animated: Bool = true) {
        navigationController.dismiss(
            animated: animated
        ) { [navigationController] in
            navigationController.viewControllers = []
        }
    }
}
