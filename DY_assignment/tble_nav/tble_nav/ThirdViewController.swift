//
//  ThirdViewController.swift
//  tble_nav
//
//  Created by 김현태 on 24/11/2018.
//  Copyright © 2018 onemoon. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    @IBOutlet weak var closeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
}


extension ThirdViewController {
    @IBAction func close(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
}

@IBDesignable class MyCustomColor: UIView {
    @IBInspectable var hello: Int = 30
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
}
