//
//  LayoutViewController.swift
//  PRAutoLayout
//
//  Created by Hyeontae on 09/01/2019.
//  Copyright © 2019 onemoon. All rights reserved.
//

import UIKit

class LayoutViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var genButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func genLabel() {
        let newLabel = UILabel()
//        newLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 0)
        newLabel.textAlignment = .center
        newLabel.text = textField.text
        view.addSubview(newLabel)
        let topConst = NSLayoutConstraint(item: newLabel,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: genButton,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: 30)
        let left = NSLayoutConstraint(item: newLabel,
                                      attribute: .left,
                                      relatedBy: .equal,
                                      toItem: view.safeAreaLayoutGuide,
                                      attribute: .right,
                                      multiplier: 1,
                                      constant: 0)
        let right = NSLayoutConstraint(item: newLabel,
                                      attribute: .right,
                                      relatedBy: .equal,
                                      toItem: view.safeAreaLayoutGuide,
                                      attribute: .left,
                                      multiplier: 1,
                                      constant: 0)
        
        NSLayoutConstraint.activate([topConst,left,right])
        
        newLabel.addConstraints([topConst, left, right])
        print("hello world")
    }
    
}
