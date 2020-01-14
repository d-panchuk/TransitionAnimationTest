//
//  NavigationAnimationController.swift
//  VCTransitionTest
//
//  Created by Dima Panchuk on 13.01.2020.
//  Copyright © 2020 dpanchuk. All rights reserved.
//

import UIKit

class NavigationAnimationController: NSObject, UINavigationControllerDelegate {
    
    var interactiveAnimationController: InteractiveViewTransitioningAnimationController?
    var isPopping: Bool = false
    
    init(navigationController: UINavigationController) {
        super.init()
        navigationController.delegate = self
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPopping = operation == .pop
        
        if operation == .push {
            interactiveAnimationController = InteractiveViewTransitioningAnimationController(viewController: toVC)
        }
        
        return ViewTransitioningAnimationController()
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        guard isPopping,
            let _ = animationController as? ViewTransitioningAnimationController,
            let interactiveAnimationController = interactiveAnimationController,
            interactiveAnimationController.isTransitioning
        else { return nil }
        
        return interactiveAnimationController
    }
    
}
