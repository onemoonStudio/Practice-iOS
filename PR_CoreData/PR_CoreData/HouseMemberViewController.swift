//
//  HouseMemberViewController.swift
//  PR_CoreData
//
//  Created by Hyeontae on 07/03/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import UIKit

class HouseMemberViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var plusInfoTextField: UITextField!
    @IBOutlet weak var editButton: UIButton!
    
    public var preparedData: AnyObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabel()
    }
    
    private func setupLabel() {
        typeTextField.isEnabled = false
        switch preparedData {
        case is People:
            let data = preparedData as! People
            nameTextField.text = data.base.name
            typeTextField.text = MemberType(rawValue: data.base.type)!.stringValue
            plusInfoTextField.text = data.job
        case is Pet:
            let data = preparedData as! Pet
            nameTextField.text = data.base.name
            typeTextField.text = MemberType(rawValue: data.base.type)!.stringValue
            plusInfoTextField.text = "adopted? \(data.adopted)"
            plusInfoTextField.isEnabled = false
        default:
            print(preparedData)
            fatalError("check object type")
        }
    }

}
