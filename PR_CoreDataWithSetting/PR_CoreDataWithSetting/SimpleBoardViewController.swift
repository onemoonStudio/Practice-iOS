//
//  SimpleBoardVC.swift
//  PR_CoreDataWithSetting
//
//  Created by Hyeontae on 12/01/2019.
//  Copyright © 2019 onemoon. All rights reserved.
//

import UIKit
import CoreData

class SimpleBoardViewController: UIViewController {
 
    @IBOutlet weak var uiTableView: UITableView!
    
    let cellIdentifier = "cell"
    var managedObjectContext: NSManagedObjectContext!
    lazy var fetchedResultsController: NSFetchedResultsController<Board> = {
        
        let fetchRequest = NSFetchRequest<Board>()
        let entity = Board.entity()
        fetchRequest.entity = entity
        
        let sort1 = NSSortDescriptor(key: "regdate", ascending: true)
        let sort2 = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sort1, sort2]
        
        fetchRequest.fetchBatchSize = 20
        
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: managedObjectContext,
            sectionNameKeyPath: nil ,
            cacheName: nil)
        
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performFetch()
    }
    
    func performFetch() {
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController: EditSimpleBoardViewController = segue.destination as? EditSimpleBoardViewController else {
            return
        }
        guard let senderCell: SimepleBoardCell = sender as? SimepleBoardCell else {
            return
        }

        nextViewController.managedObjectContext = managedObjectContext
        nextViewController.targetObject = senderCell.targetObject!
        
    }
    
    
    
}

class SimepleBoardCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    var targetObject: Board?
    
    func configure(_ addressName: String, _ object: Board) {
        name.text = addressName
        targetObject = object
    }
    
}

extension SimpleBoardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController.sections else {
            fatalError("No sections in fetchedResultsController")
        }
        return sections[section].numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SimepleBoardCell else {
            return UITableViewCell()
        }
        let info = fetchedResultsController.object(at: indexPath)
        cell.configure(info.title!, info)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension SimpleBoardViewController: NSFetchedResultsControllerDelegate {
    
}
