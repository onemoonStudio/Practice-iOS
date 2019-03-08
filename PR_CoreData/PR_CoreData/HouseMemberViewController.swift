//
//  HouseMemberViewController.swift
//  PR_CoreData
//
//  Created by Hyeontae on 07/03/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import UIKit
import CoreData

class HouseMemberViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var plusInfoTextField: UITextField!
    @IBOutlet weak var editButton: UIButton!
    
    public var preparedData: NSManagedObject?
    private lazy var memberType: MemberType = {
        switch preparedData {
        case is People:
            return .people
        case is Pet:
            return .pet
        default:
            fatalError("check memberType")
        }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabel()
        setupEditButton()
    }
    
    private func setupLabel() {
        typeTextField.isEnabled = false
        switch memberType {
        case .people:
            let data = preparedData as! People
            nameTextField.text = data.base.name
            typeTextField.text = memberType.stringValue
            plusInfoTextField.text = data.job
        case .pet:
            let data = preparedData as! Pet
            nameTextField.text = data.base.name
            typeTextField.text = memberType.stringValue
            plusInfoTextField.text = "adopted? \(data.adopted)"
            plusInfoTextField.isEnabled = false
        }
    }
    
    private func setupEditButton() {
        editButton.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
    }
    
    @objc private func didTapEditButton(_ sender: UIButton) {
        var data: HouseMemberData? = {
            switch self.memberType {
            case .people:
                let data = preparedData as! People
                guard
                    let name = nameTextField.text ,
                    let job = plusInfoTextField.text
                    else { return nil }
                if name != data.base.name || job != data.job {
                    return PeopleData(name: name, job: job)
                }
            case .pet:
                guard let name = nameTextField.text else { return nil }
                let data = preparedData as! Pet
                if name != data.base.name {
                    return PetData(name: name, adopted: data.adopted)
                }
            }
            return nil
        }()
        guard
            let nsManagedObject = preparedData,
            let editedData = data
            else { return }
        HouseManager.edit(nsManagedObject: nsManagedObject, data: editedData)
    }
    
}
