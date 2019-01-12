//
//  EditSimpleBoardViewController.swift
//  PR_CoreDataWithSetting
//
//  Created by Hyeontae on 12/01/2019.
//  Copyright © 2019 onemoon. All rights reserved.
//

import UIKit
import CoreData

class EditSimpleBoardViewController: UIViewController {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var contentsField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var managedObjectContext: NSManagedObjectContext!
    var targetObject: Board?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleField.text = targetObject?.title
        contentsField.text = targetObject?.contents
    }
    
    @IBAction func clickSaveButton(_ sender: UIButton) {
        
    }
    
    
}
