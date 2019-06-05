//
//  ViewController.swift
//  PR_PageViewController
//
//  Created by HyeonTae on 04/06/2019.
//  Copyright © 2019 onemoonstudio. All rights reserved.
//

import UIKit

class ViewController: UIPageViewController {
    
    private let viewcontrollersIdentifier: [String] = ["RedVC" ,"GreenVC" ,"BlueVC"]
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
    // 이전에 보여줄 ViewController를 설정한다.
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = pageviewcontrollers.firstIndex(of: viewController) else { return nil }
        let previousIndex = vcIndex - 1
        guard previousIndex >= 0 else { return pageviewcontrollers.last }
        return pageviewcontrollers[previousIndex]
    }
    
    // 이후에 보여줄 ViewController를 설정한다.
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = pageviewcontrollers.firstIndex(of: viewController) else { return nil }
        let nextIndex = vcIndex + 1
        guard pageviewcontrollers.count > nextIndex else { return pageviewcontrollers.first }
        return pageviewcontrollers[nextIndex]
    }
    
    
}

extension ViewController: UIPageViewControllerDelegate {
    
}

