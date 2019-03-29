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
    
    public var preparedData: Base!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabel()
        setupEditButton()
    }
    
    private func setupLabel() {
        typeTextField.isEnabled = false
        nameTextField.text = preparedData.name
        typeTextField.text = preparedData.memberType.stringValue
        switch preparedData.memberType {
        case .people:
            if let job = preparedData.people?.job {
                plusInfoTextField.text = job
            }
        case .pet:
            if let petdata = preparedData.pet {
                plusInfoTextField.text = "adopted? \(petdata.adopted)"
            }
            plusInfoTextField.isEnabled = false
        }
    }
    
    private func setupEditButton() {
        editButton.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
    }
    
    @objc private func didTapEditButton(_ sender: UIButton) {
        var data: HouseMemberData? {
            switch preparedData.memberType {
            case .people:
                guard
                    let name = nameTextField.text ,
                    let job = plusInfoTextField.text,
                    let peopleData = preparedData.people as? People
                    else { return nil }
                if name != String(preparedData.name) || job != peopleData.job {
                    return PeopleData(name: name, job: job)
                }
            case .pet:
                guard
                    let name = nameTextField.text,
                    let petData = preparedData.pet as? Pet
                    else { return nil }
                if name != preparedData.name {
                    return PetData(name: name, adopted: petData.adopted)
                }
            }
            return nil
        }
        guard
            let nsManagedObject = preparedData,
            let editedData = data
            else { return }
        HouseManager.edit(nsManagedObject: nsManagedObject, data: editedData)
    }
    
}
