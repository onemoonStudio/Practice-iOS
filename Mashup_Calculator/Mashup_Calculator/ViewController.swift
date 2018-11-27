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
    
    let myOperator: [String] = ["+" , "-" , "/" , "x"]
    // operator Enum 사용해보기
    let cellIdentifier: String = "myCalCell"
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
        guard let secondViewController: SecondViewController = segue.destination as? SecondViewController else {
            return
        }
        guard let cell: UITableViewCell = sender as? UITableViewCell else {
            return
        }
        secondViewController.textToSet = cell.textLabel?.text
     }
}

// MARK:- Table View Data & Delegate
// MARK: !! DataSource & Delegate Outlet 으로 연결해줘야 한다.

extension ViewController: UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myOperator.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let operatorCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        let operatorStr: String = myOperator[indexPath.row]
        
        operatorCell.textLabel?.text = operatorStr
        
        return operatorCell
    }

    
    // cell 을 선택했을 때 실행되는 함수
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let secondVC: SecondViewController = storyboard?.instantiateViewController(withIdentifier: "SecondViewControllerId") as? SecondViewController else {
//            return
//        }
//        secondVC.textToSet = myOperator[indexPath.row]
//        print("@@@")
//        print(myOperator[indexPath.row])
//        print(secondVC.textToSet)
//        print(indexPath.row)
//
//        navigationController?.pushViewController(secondVC, animated: true)
//    }
}

