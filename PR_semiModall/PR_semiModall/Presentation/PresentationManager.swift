//
//  PresentationManager.swift
//  PR_semiModall
//
//  Created by Hyeontae on 20/01/2019.
//  Copyright © 2019 onemoon. All rights reserved.
//

import UIKit

enum PresentationDirection {
    case left
    case top
    case right
    case bottom
}

class PresentationManager: NSObject {
    var direction: PresentationDirection = .left
    
}

extension PresentationManager: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        let presentationController = PresentationController(presentedViewController: presented,
                                                                   presenting: presenting,
                                                                   direction: direction)
        return presentationController
    }
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentationAnimator(direction: direction, isPresentation: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
            return PresentationAnimator(direction: direction, isPresentation: false)
    }
}
