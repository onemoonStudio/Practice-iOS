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
    @IBOutlet weak var filterBarButtonItem: UIBarButtonItem!
    
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
            for field in fields {
                field.text = nil
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { _ in
            guard let fields = addNewMemberAlertController.textFields else { return }
            for field in fields {
                field.text = nil
            }
        }
        addNewMemberAlertController.addAction(cancelAction)
        addNewMemberAlertController.addAction(addAction)
        return addNewMemberAlertController
    }()
    
    private lazy var filterAlert: UIAlertController = {
        let filterAlert = UIAlertController(title: "Choice Member Filter", message: nil, preferredStyle: .actionSheet)
        let filterAllAction = UIAlertAction(title: "All", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.list = HouseManager.filter(nil)
            self.tableView.reloadData()
        }
        let filterPeopleAction = UIAlertAction.init(title: "People", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.list = HouseManager.filter(.people)
            self.tableView.reloadData()
        }
        let filterPetAction = UIAlertAction(title: "Pet", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.list = HouseManager.filter(.pet)
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        filterAlert.addAction(filterAllAction)
        filterAlert.addAction(filterPeopleAction)
        filterAlert.addAction(filterPetAction)
        filterAlert.addAction(cancelAction)
        return filterAlert
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFilterBarButtonItem()
        setupPlusBarButtonItem()
        setupTableView()
        title = "My House Member"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadWithFetch()
    }
    
    private func setupFilterBarButtonItem() {
        filterBarButtonItem.target = self
        filterBarButtonItem.action = #selector(connectFilterMemberAlert)
    }
    
    private func setupPlusBarButtonItem() {
        plusBarButtonItem.target = self
        plusBarButtonItem.action = #selector(connectAddNewMemberAlert)
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
        reloadWithFetch()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetch() -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "House")
        return try! HouseManager.managedContext.fetch(fetchRequest)
    }
    
    @objc func connectFilterMemberAlert() -> Void {
        present(filterAlert, animated: true)
    }
    
    @objc func connectAddNewMemberAlert() -> Void {
        present(newMemberAlert, animated: true)
    }
    
    private func reloadWithFetch() {
        list = fetch()
        tableView.reloadData()
    }
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
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            HouseManager.deleteObject(object: list[indexPath.row])
        }
        reloadWithFetch()
    }
}

