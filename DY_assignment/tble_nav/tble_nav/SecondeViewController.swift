//
//  SecondeView.swift
//  tble_nav
//
//  Created by 김현태 on 24/11/2018.
//  Copyright © 2018 onemoon. All rights reserved.
//

import UIKit

class SecondView: UIViewController {
    @IBOutlet weak var centerButton: UIButton!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var presentNextViewButton: UIButton!
    
    var sendedStr: String?
    var nextFlag: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        targetLabel.text = sendedStr
        nextFlag = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if (!nextFlag) {
            if ( self.navigationController == nil ) {
                self.dismiss(animated: true, completion: nil)
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    // 기능을 명시하자
    @IBAction func back(_ sender: UIButton) {
//        self.navigationController?.dismiss(animated: true, completion: nil)
        // navigation controller 의 경우 push 의 반대이기 때문에 pop viewcontroller
        // 하지만 navigation controller 가 아닌경우 push 가 아닌 present 이기 때문에 dismiss로 해줘야 한다.
        if ( self.navigationController == nil ) {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        nextFlag = true
    }
    
}
