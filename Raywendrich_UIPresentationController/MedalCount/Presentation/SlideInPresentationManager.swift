//
//  SlideInPresentationManager.swift
//  MedalCount
//
//  Created by Hyeontae on 16/01/2019.
//  Copyright © 2019 Ron Kliffer. All rights reserved.
//

import UIKit

enum PresentationDirection {
  case left
  case top
  case right
  case bottom
}

class SlideInPresentationManager: NSObject {
  var direction = PresentationDirection.left

}

// MARK: - UIViewControllerTransitioningDelegate
extension SlideInPresentationManager: UIViewControllerTransitioningDelegate {
  func presentationController(forPresented presented: UIViewController,
                              presenting: UIViewController?,
                              source: UIViewController) -> UIPresentationController? {
    let presentationController = SlideInPresentationController(presentedViewController: presented,
                                                               presenting: presenting,
                                                               direction: direction)
    return presentationController
  }

}

