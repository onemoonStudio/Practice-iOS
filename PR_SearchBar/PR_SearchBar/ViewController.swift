//
//  ViewController.swift
//  PR_SearchBar
//
//  Created by Hyeontae on 23/01/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var uiTableView: UITableView!
    @IBOutlet weak var uiSearchBar: UISearchBar!
    
    private var lastContentOffset: CGFloat = -64
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        uiTableView.delegate = self
        uiTableView.dataSource = self
        uiSearchBar.delegate = self
     
        uiTableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        uiTableView.separatorStyle = .none
        
        // 이거 때문에 올라가는게 가려짐
        uiSearchBar.backgroundImage = UIImage()
        
        let searchBarTextfield: UITextField = uiSearchBar.value(forKey: "searchField") as! UITextField
        searchBarTextfield.backgroundColor = UIColor(red: 142/256, green: 142/256, blue: 147/256, alpha: 0.12)
        searchBarTextfield.textColor = UIColor.black
        
        
        
        guard let navibar = self.navigationController?.navigationBar else { return }
        //        navibar.isTranslucent = false
        navibar.backgroundColor = UIColor.white
        navibar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        navibar.shadowImage = UIImage()
    
    
        
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell() }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 스크롤 할 때 호출
        let contentYOffset = scrollView.contentOffset.y
        
        if lastContentOffset < contentYOffset {
            print("down")
            
        } else {
            print("up")
        }
        
        lastContentOffset = scrollView.contentOffset.y
    }
    
    
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        // called when focus on search field
        uiSearchBar.setShowsCancelButton(true, animated: true)
    }
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        print("hello \(searchBar.text!)")
        self.navigationItem.title = searchBar.text!
        
        uiSearchBar.setShowsCancelButton(false, animated: true)
        // 더이상 키보드 인풋을 받지 않는다 ! focusing 해제 따라서 키보드가 내려감
        searchBar.resignFirstResponder()
    }
    
    
//    func position(for bar: UIBarPositioning) -> UIBarPosition {
//        // 상태바에 붙인다.
////        return .topAttached
//        
//        return .top
//    }
    
}

