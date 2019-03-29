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
    private var sortMemberType: MemberType?
    private var predicate: NSPredicate? {
        if let sortMemberType = sortMemberType {
            return NSPredicate(
                format: "%K == %@",
                #keyPath(Base.type),
                NSNumber(value: sortMemberType.rawValue)
            )
        } else {
            return nil
        }
    }
    private lazy var resultController: NSFetchedResultsController<Base> = {
        let fetchRequest = NSFetchRequest<Base>(entityName: "Base")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "regDate", ascending: false)]
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: HouseManager.managedContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    private lazy var newMemberAlert: UIAlertController = {
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
            self.sortMemberType = nil
            self.updateList()
        }
        let filterPeopleAction = UIAlertAction.init(title: "People", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.sortMemberType = MemberType(rawValue: 0)!
            self.updateList()
        }
        let filterPetAction = UIAlertAction(title: "Pet", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.sortMemberType = MemberType(rawValue: 1)!
            self.updateList()
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
        updateList()
        title = "My House Member"
    }
    
    private func updateList() {
        do {
            resultController.fetchRequest.predicate = predicate
            try resultController.performFetch()
            tableView.reloadData()
        } catch let error as NSError {
            print("\(error.code) code & \(error.localizedDescription)")
        }
        
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
            memberType = MemberType(rawValue: 0)!
            memberData = PeopleData(
                name: data.name,
                job: data.additional
            )
        case .pet:
            memberType = MemberType(rawValue: 1)!
            memberData = PetData(
                name: data.name,
                adopted: data.additional.lowercased() == "t" ? true : false
            )
        }
        HouseManager.insert(memberType: memberType , data: memberData)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func connectFilterMemberAlert() -> Void {
        present(filterAlert, animated: true)
    }
    
    @objc func connectAddNewMemberAlert() -> Void {
        present(newMemberAlert, animated: true)
    }
    
}

extension HouseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionInfo = resultController.sections?[0] else { return 0 }
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let cell =
                tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            let info = resultController.object(at: indexPath)
            cell.textLabel?.text = info.name
            cell.detailTextLabel?.text = info.memberType.stringValue
            return cell
    }
}

extension HouseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryBoard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let memberViewController =
            mainStoryBoard.instantiateViewController(withIdentifier: "HouseMemberViewController")
                as? HouseMemberViewController else { return }
        memberViewController.preparedData = resultController.object(at: indexPath)
        show(memberViewController, sender: nil)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            HouseManager.deleteObject(object: resultController.object(at: indexPath))
        }
    }
}

extension HouseViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller:
        NSFetchedResultsController<NSFetchRequestResult>) {
        print("start")
        tableView.beginUpdates()
    }
    
    func controller(_ controller:
        NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        case .update:
            let cell = tableView.cellForRow(at: indexPath!)
            let info = resultController.object(at: indexPath!)
            cell?.textLabel?.text = info.name
            cell?.detailTextLabel?.text = info.memberType.stringValue
        case .move:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        }
    }
    
    func controllerDidChangeContent(_ controller:
        NSFetchedResultsController<NSFetchRequestResult>) {
        print("end")
        tableView.endUpdates()
        
    }
        
}

