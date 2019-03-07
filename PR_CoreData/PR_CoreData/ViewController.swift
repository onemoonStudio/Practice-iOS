//
//  ViewController.swift
//  PR_CoreData
//
//  Created by Hyeontae on 07/03/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var plusBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    private let cellIdentifier = "Cell"
    
    lazy var list: [NSManagedObject] = {
        fetch()
    }()
    lazy var newMemberAlert: UIAlertController = {
        let addNewMemberAlertController =
            UIAlertController.init(title: "New Member", message: "wow", preferredStyle: .alert)
        
        addNewMemberAlertController.addTextField { (typeText) in
            typeText.placeholder = "typeNumber"
            typeText.keyboardType = .decimalPad
        }
        addNewMemberAlertController.addTextField { (nameText) in
            nameText.placeholder = "name"
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            print("good")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        addNewMemberAlertController.addAction(cancelAction)
        addNewMemberAlertController.addAction(addAction)
        return addNewMemberAlertController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlusBarButtonItem()
        setupTableView()
    }
    
    private func setupPlusBarButtonItem() {
        plusBarButtonItem.target = self
        plusBarButtonItem.action = #selector(plusMember)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func fetch() -> [NSManagedObject] {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "House")
        guard let result = try! context?.fetch(fetchRequest) else {
            return []
        }
        return result
    }
    
    @objc func plusMember() -> Void {
        present(newMemberAlert, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let cell =
                tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            let info = list[indexPath.row]
            var basicInfo: (title: String, detail: String)
            switch info {
            case is People:
                let data = info as! People
                basicInfo.title = data.base.name
                basicInfo.detail = MemberType(rawValue: data.base.type)!.stringValue
            case is Pet:
                let data = info as! Pet
                basicInfo.title = data.base.name
                basicInfo.detail = MemberType(rawValue: data.base.type)!.stringValue
            default:
                basicInfo.title = "!"
                basicInfo.detail = "Check Type"
            }
            cell.textLabel?.text = basicInfo.0
            cell.detailTextLabel?.text = basicInfo.1
            
            return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryBoard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let memberViewController =
            mainStoryBoard.instantiateViewController(withIdentifier: "HouseMemberViewController")
                as? HouseMemberViewController else { return }
        memberViewController.preparedData = list[indexPath.row]
        show(memberViewController, sender: nil)
    }
}

