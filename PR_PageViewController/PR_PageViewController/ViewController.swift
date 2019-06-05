//
//  ViewController.swift
//  PR_PageViewController
//
//  Created by HyeonTae on 04/06/2019.
//  Copyright © 2019 onemoonstudio. All rights reserved.
//

import UIKit

class ViewController: UIPageViewController {
    
    private let viewcontrollersIdentifier: [String] = ["RedVC" ,"BlueVC"]
    private lazy var pageviewcontrollers: [UIViewController] = {
        return self.viewcontrollersIdentifier.map { UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: $0) }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.dataSource = self
        setPageViewController()
    }
    
    private func setPageViewController() {
        guard let firstVC = pageviewcontrollers.first  else { return }
        self.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
    }
    
    


}

extension ViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = pageviewcontrollers.firstIndex(of: viewController) else { return nil }
        let previousIndex = vcIndex - 1
        guard previousIndex >= 0, pageviewcontrollers.count > previousIndex else { return nil }
        return pageviewcontrollers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = pageviewcontrollers.firstIndex(of: viewController) else { return nil }
        let nextIndex = vcIndex + 1
        guard pageviewcontrollers.count != nextIndex, pageviewcontrollers.count > nextIndex else { return nil }
        return pageviewcontrollers[nextIndex]
    }
    
    
}

extension ViewController: UIPageViewControllerDelegate {
    
}

