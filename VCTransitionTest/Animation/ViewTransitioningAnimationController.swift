//
//  ViewTransitioningAnimationController.swift
//  VCTransitionTest
//
//  Created by Dima Panchuk on 08.01.2020.
//  Copyright © 2020 dpanchuk. All rights reserved.
//

import UIKit

protocol ViewTransitioning {
    var transitioningView: UIView? { get }
}

class ViewTransitioningAnimationController: NSObject {
    
    let transitionDuraion: TimeInterval
    
    init(transitionDuraion: TimeInterval = 1) {
        self.transitionDuraion = transitionDuraion
    }
    
}

extension ViewTransitioningAnimationController: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuraion
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // required preconditions
        guard
            let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to),
            let sourceView = (fromVC as! ViewTransitioning).transitioningView,
            let destinationView = (toVC as! ViewTransitioning).transitioningView
        else {
            transitionContext.completeTransition(false)
            return
        }
        
        // prepare animation container
        let container = transitionContext.containerView
        container.backgroundColor = toVC.view.backgroundColor
        container.addSubview(fromVC.view)
        container.addSubview(toVC.view)
        
        // create snapshot and add it to animation container
        let snapshot = sourceView.snapshotView(afterScreenUpdates: false)!
        snapshot.frame = container.convert(sourceView.frame, from: sourceView.superview)
        container.addSubview(snapshot)

        // - initial animation setup -
        
        // hide transitioningView source & destination
        sourceView.isHidden = true
        destinationView.isHidden = true
        
        // transform toVC so it's at the bottom of page
        toVC.view.transform = CGAffineTransform(translationX: 0, y: container.bounds.height)
        toVC.view.layoutIfNeeded()
        
        // - animation -
        UIView.animate(
            withDuration: transitionDuraion,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 0,
            animations: {
                fromVC.view.alpha = 0
                toVC.view.transform = CGAffineTransform.identity
                snapshot.frame = container.convert(destinationView.frame, from: destinationView.superview)
            },
            completion: { _ in
                fromVC.view.alpha = 1
                sourceView.isHidden = false
                destinationView.isHidden = false

                snapshot.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
}
