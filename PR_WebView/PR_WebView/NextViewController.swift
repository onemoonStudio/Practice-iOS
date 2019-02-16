//
//  NextViewController.swift
//  PR_WebView
//
//  Created by Hyeontae on 16/02/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import UIKit
import WebKit
import CoreData

class NextViewController: UIViewController,WKNavigationDelegate, WKUIDelegate {

    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var webData: Data? = Data()
    var webView: WKWebView!
    
    var managedContext: NSManagedObjectContext = {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return NSManagedObjectContext()
        }
        let managedContext: NSManagedObjectContext =
            appDelegate.persistentContainer.viewContext
        return managedContext
    }()
    
    
    override func loadView() {
        super.loadView()
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [refresh]
        navigationController?.isToolbarHidden = false
        
        let req: NSFetchRequest = HtmlData.fetchRequest()
        do{
            let result = try managedContext.fetch(req)
            if let myData: Data = result.first?.htmldata as? Data {
                webData = myData
            }
        } catch let err {
            print(err.localizedDescription)
        }
        webView.load(webData!, mimeType: "text/html", characterEncodingName: "utf-8", baseURL: URL(string: "https://blockinpress.com/archives/13656")!)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let otherAction = UIAlertAction(title: "OK", style: .default, handler: { action in completionHandler() })
        alert.addAction(otherAction)
        
        present(alert,animated: true,completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { action in completionHandler(false) })
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { action in completionHandler(true) })
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert,animated: true,completion: nil)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.frame = CGRect(
            x: view.frame.midX-50,
            y: view.frame.midY-50,
            width: 100,
            height: 100)
        activityIndicator.color = .red
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
        activityIndicator.removeFromSuperview()
    }
}
