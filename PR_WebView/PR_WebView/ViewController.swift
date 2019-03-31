//
//  ViewController.swift
//  PR_WebView
//
//  Created by Hyeontae on 16/02/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var managedContext: NSManagedObjectContext = {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return NSManagedObjectContext()
        }
        let managedContext: NSManagedObjectContext =
            appDelegate.persistentContainer.viewContext
        return managedContext
    }()
    
    var webData: Data?
    
    @IBOutlet weak var ka: UILabel!
    
    override func viewDidLoad() {
        ka.textColor = .red
        
        super.viewDidLoad()
//        let urlString = "https://naver.com/"
        let urlString = "https://blockinpress.com/archives/13656"
        guard let url = URL(string: urlString) else { return }
        
        webViewWithData(url) { [weak self] (data) in
            guard let self = self else { return }
            self.webData = data
        }
    }
    
    @IBAction func checkData(_ sender: UIButton!) {
        let req: NSFetchRequest = HtmlData.fetchRequest()
        
        do{
            let result = try managedContext.fetch(req)
            print(result.count)
            for item in result {
                managedContext.delete(item)
            }
            try managedContext.save()
            title = "clear"
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    @IBAction func saveButtonDidTapped(_ sender: UIButton) {
        saveData(data: webData!)
    }
    
    func webViewWithData(_ url: URL, completion: @escaping (Data) -> Void ) {
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data: Data? , _ , error: Error? ) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                print("data error")
                return
            }
            completion(data)
            
        }
        
        task.resume()
    }
    
    func saveData(data: Data){
        
        
        guard let entity =
            NSEntityDescription.entity(forEntityName: "HtmlData", in: managedContext) else {
                return
        }
        let htmlEntity = HtmlData(entity: entity, insertInto: managedContext)
        htmlEntity.htmldata = data as NSData
        do {
            try managedContext.save()
            title = "Saved!"
        } catch {
            print(error.localizedDescription)
        }
    }
}

