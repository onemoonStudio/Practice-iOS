//
//  ViewController.swift
//  tble_nav
//
//  Created by 김현태 on 24/11/2018.
//  Copyright © 2018 onemoon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var myTableView: UITableView!
    
    let mySource: [Int] = Array(1...15)
    let cellIdentifier: String = "myCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController: SecondView = segue.destination as? SecondView else {
            return
        }
        guard let cell: UITableViewCell = sender as? UITableViewCell else {
            return
        }
        nextViewController.sendedStr = cell.textLabel?.text
    }
}

// MARK:- table datasource & delegate
extension ViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mySource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let numberSource = mySource[indexPath.row]
        cell.textLabel?.text = String(numberSource)
        
        return cell
    }
}
