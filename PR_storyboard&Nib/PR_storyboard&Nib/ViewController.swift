//
//  ViewController.swift
//  PR_storyboard&Nib
//
//  Created by Hyeontae on 09/04/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let hudView: View2 = View2() // init frame
        guard let hudView: View2 = Bundle.main.loadNibNamed("View2", owner: self, options: nil)?.first as? View2 else {
            print("returned? ")
            return
        }
        
        hudView.centerLabel.text = "View2"
        let hudViewPosition: CGRect = CGRect(x: view.center.x - 50, y: view.center.y - 50, width: 100, height: 100)
        hudView.frame = hudViewPosition
        view.addSubview(hudView)
    }
}

