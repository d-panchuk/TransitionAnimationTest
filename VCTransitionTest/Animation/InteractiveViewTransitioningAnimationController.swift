//
//  InteractiveViewTransitioningAnimationController.swift
//  VCTransitionTest
//
//  Created by Dima Panchuk on 13.01.2020.
//  Copyright © 2020 dpanchuk. All rights reserved.
//

import UIKit

class InteractiveViewTransitioningAnimationController: UIPercentDrivenInteractiveTransition {
    
    let viewController: UIViewController
    var isTransitioning: Bool = false
    
    init(viewController: UIViewController) {
        self.viewController = viewController
        
        super.init()
        
        setupLeftEdgePanGesture(for: viewController.view)
    }
    
    @objc func handleEdgePan(_ gesture: UIScreenEdgePanGestureRecognizer) {
        guard let gestureView = gesture.view else { return }
        
        let translation = gesture.translation(in: gestureView)
        let velocity = gesture.velocity(in: gestureView)
        let progress = translation.x / gestureView.bounds.size.width
        
        switch gesture.state {
        case .began:
            isTransitioning = true
            viewController.navigationController?.popViewController(animated: true)
        
        case .changed:
            update(progress)
        
        case .cancelled:
            cancel()
            isTransitioning = false
        
        case .ended:
            let shouldCompleteTransition = progress > 0.5 || velocity.x > 0
            shouldCompleteTransition ? finish() : cancel()
            isTransitioning = false
        
        default:
            break
        }
    }
    
    private func setupLeftEdgePanGesture(for view: UIView) {
        let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleEdgePan(_:)))
        gesture.edges = .left
        view.addGestureRecognizer(gesture)
    }
    
}
