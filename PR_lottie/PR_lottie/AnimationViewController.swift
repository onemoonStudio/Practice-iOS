//
//  AnimationViewController.swift
//  PR_lottie
//
//  Created by Hyeontae on 25/07/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import UIKit
import Lottie

class AnimationViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startAnimation()
    }
    
    func startAnimation() {
        let lottieView = AnimationView(name: "7751-load")
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lottieView)
        lottieView.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
        lottieView.heightAnchor.constraint(equalToConstant: 400.0).isActive = true
        lottieView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        lottieView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        lottieView.loopMode = .loop
        lottieView.play()
    }
}
