//
//  ViewController.swift
//  PR_AlaMoya
//
//  Created by Hyeontae on 11/09/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import UIKit
import Moya

class ViewController: UIViewController {
    let provider = MoyaProvider<TestTarget>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("get Data")
        provider.request(.getData) { result in
            switch result {
            case .success(let value):
                print("success \(value)")
            case .failure(let error):
                print("error \(error.response)")
            }
        }
    }


}

