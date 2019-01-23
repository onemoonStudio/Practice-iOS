//
//  CustomModalViewController.swift
//  PR_semiModall
//
//  Created by Hyeontae on 22/01/2019.
//  Copyright © 2019 onemoon. All rights reserved.
//

import UIKit

class CustomModalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        roundCorners(layer: self.view.layer, radius: CGFloat(15.0))
    }
    
    func roundCorners(layer targetLayer: CALayer, radius withRaidus: CGFloat) {
        targetLayer.cornerRadius = withRaidus
        targetLayer.masksToBounds = true // default = false
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
