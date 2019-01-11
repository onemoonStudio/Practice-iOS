//
//  ListTableVC.swift
//  PR_CoreDataWithSetting
//
//  Created by Hyeontae on 11/01/2019.
//  Copyright © 2019 onemoon. All rights reserved.
//

import UIKit
import CoreData

class ListTableVC: UIViewController{

    @IBOutlet weak var tableview: UITableView!
    
    lazy var list: [NSManagedObject] = { [weak self] in
        return self!.fetch()
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add(_:)))
        self.navigationItem.rightBarButtonItem = addBtn
    }
    
}

extension ListTableVC {
    
    func fetch() -> [NSManagedObject] {
        // 코어데이터에서 레코드를 읽어오는 과정을 fetch라고 한다.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // 1. 앱 델리게이트 객체 참조
        let context = appDelegate.persistentContainer.viewContext
        // 2. 관리 객체 컨텍스트 참조
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Board")
        // 3. 요청 객체 생성 ,  쿼리랑 비슷한 개념이라고 생각하자.
        let sort = NSSortDescriptor(key: "regdate", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        // 3.1 요청의 정렬 설정
        // 왜 배열? -> 여러개의 정렬 기준을 정할 수 있다 만약 첫번째 기준으로 애매한 경우 두번째 정렬 기준을 통해서 내부에서 다시 정렬한다. 우선순위가 있다고 생각하자
        let result = try! context.fetch(fetchRequest)
        // 4. 요청
        return result
    }
    
    func save(title: String, contents: String) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        // 컨텍스트 참조 과정
        
        let object = NSEntityDescription.insertNewObject(forEntityName: "Board", into: context)
        // 관리 객체 설정 및 초기화
        object.setValue(title, forKey: "title")
        object.setValue(contents, forKey: "contents")
        object.setValue(Date(), forKey: "regdate")
        
        do {
            try context.save()
            // 값을 저장
//            list.append(object)
            list.insert(object, at: 0)
            return true
        } catch {
            context.rollback()
            // 마지막 동기화 시점 이후 변경 내역을 삭제한다.
            return false
        }
        
        
    }
    
    func delete(object: NSManagedObject) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        context.delete(object)
        do {
            try context.save()
            return true
        } catch {
            context.rollback()
            return false
        }
    }
    
    func edit(object: NSManagedObject, title: String, contents: String) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        object.setValue(title, forKey: "title")
        object.setValue(contents, forKey: "contents")
        object.setValue(Date(), forKey: "regdate")
        
        do {
            // 만약 여러개를 수정해야 한다고 했을때 save를 여러번 호출할 필요 없이 바뀐 객체들을 한번에 save하면 된다.
            try context.save()
//            list = fetch()
//            tableview.reloadData()
            return true
        } catch {
            context.rollback()
            return false
        }
    }
    
    @objc func add(_ sender: Any) {
        let alert = UIAlertController(title: "게시글 등록", message: nil, preferredStyle: .alert)
        alert.addTextField { $0.placeholder="제목" }
        alert.addTextField { $0.placeholder="내용" }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (_) in
            guard let title = alert.textFields?.first?.text , let contents = alert.textFields?.last?.text else {
                return
            }
            if self.save(title: title, contents: contents) {
                self.tableview.reloadData()
            }
        }))
        present(alert, animated: false)
    }
    
}

extension ListTableVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let record = list[indexPath.row]
        // 코어데이터는 실제로 저장되는 값이 어떤 형식인지 모르기 때문에 Any 타입으로 가져온다. 따라서 캐스팅이 필요함
        let title = record.value(forKey: "title") as? String
        let contents = record.value(forKey: "contents") as? String
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = contents
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let object = list[indexPath.row]
        
        if delete(object: object) {
            list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object = list[indexPath.row]
        let title = object.value(forKey: "title") as? String
        let contents = object.value(forKey: "contents") as? String
        
        let alert = UIAlertController(title: "게시글 수정", message: nil, preferredStyle: .alert)
        
        alert.addTextField {$0.text = title }
        alert.addTextField {$0.text = contents }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Save", style: .default) { (_) in
            guard let title = alert.textFields?.first?.text , let contents = alert.textFields?.last?.text
                else { return }
            
            if self.edit(object: object, title: title, contents: contents) {
//                tableView.reloadData()
                let cell = tableView.cellForRow(at: indexPath)
                cell?.textLabel?.text = title
                cell?.detailTextLabel?.text = contents
                
                let firstIndexPath = IndexPath(item: 0, section: 0)
                tableView.moveRow(at: indexPath, to: firstIndexPath)
            }
        })
        present(alert,animated: false)
    }
    
}
