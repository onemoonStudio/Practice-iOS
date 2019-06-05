//
//  SecondViewController.swift
//  PR_NavigationController
//
//  Created by Hyeontae on 26/05/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    private var flag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func click() {
        let topItem = navigationController?.navigationBar.topItem
        topItem?.title = "topItem"
        
        navigationItem.title = "not topItem"
    }
    
    

    

}
