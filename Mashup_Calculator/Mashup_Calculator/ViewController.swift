//
//  ViewController.swift
//  Mashup_Calculator
//
//  Created by 김현태 on 23/11/2018.
//  Copyright © 2018 onemoon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
//    let myOperator: [String] = ["+" , "-" , "/" , "*"]
//    let myOperator: [OperatorEnum] = [.plus , .minus , .divide , .multiply]
    let myOperator: [OperatorEnum] = OperatorEnum.toArray()
    let cellIdentifier: String = "myCalCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let secondViewController: SecondViewController = segue.destination as? SecondViewController else { return }
        guard let cell: UITableViewCell = sender as? UITableViewCell else { return }
        
        // 짧은-회로 평가 (short-circuit evaluation) 때문에 뒤에 !를 써도 괜찮다.
        if SharedClass.shared.value != nil && SharedClass.shared.value!.contains(".") {
            SharedClass.shared.value = String(SharedClass.shared.value!.split(separator: ".")[0])
        }
        secondViewController.textToSet = cell.textLabel?.text
     }
}

// MARK:- Table View Data & Delegate
// MARK: !! DataSource & Delegate 뷰컨트롤러에 연결해줘야 한다.
extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myOperator.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let operatorCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        let operatorStr: String = myOperator[indexPath.row].text
        
        operatorCell.textLabel?.text = operatorStr
        
        return operatorCell
    }
}

