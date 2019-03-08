//
//  ViewController.swift
//  PR_CoreData
//
//  Created by Hyeontae on 07/03/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import UIKit
import CoreData

class HouseViewController: UIViewController {
    
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
        addNewMemberAlertController.addTextField { (additional) in
            additional.placeholder = "additional"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (action) in
            guard let fields = addNewMemberAlertController.textFields,
                let tempData: (String,String,String) = (
                    fields[0].text!,
                    fields[1].text!,
                    fields[2].text!
                )
                else { return }
            self.addNewMember(tempData)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    private func addNewMember(_ data: (type: String,name: String,additional: String)) {
        var memberType: MemberType = MemberType(rawValue: Int16(data.type)!)!
        var memberData: HouseMemberData
        switch memberType {
        case .people:
            memberType = MemberType(rawValue: 1)!
            memberData = PeopleData(
                name: data.name,
                job: data.additional
            )
        case .pet:
            memberType = MemberType(rawValue: 2)!
            memberData = PetData(
                name: data.name,
                adopted: data.additional.lowercased() == "t" ? true : false
            )
        }
        HouseManager.insert(memberType: memberType , data: memberData)
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
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let memberController =
//            segue.destination as? HouseMemberViewController,
//        let cell = sender as? UITableViewCell,
//        let indexPath = tableView.indexPath(for: cell)
//            else { return }
//        memberController.preparedData = list[indexPath.row]
//    }
}

extension HouseViewController: UITableViewDataSource {
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

extension HouseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryBoard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let memberViewController =
            mainStoryBoard.instantiateViewController(withIdentifier: "HouseMemberViewController")
                as? HouseMemberViewController else { return }
        memberViewController.preparedData = list[indexPath.row]
        show(memberViewController, sender: nil)
//        tableView.deselectRow(at: indexPath, animated: false)
    }
}

