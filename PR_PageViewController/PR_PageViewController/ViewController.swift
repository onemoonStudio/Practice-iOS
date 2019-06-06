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
    private let pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        for view in self.view.subviews {
            if let scrollView = view as? UIScrollView {
                scrollView.delegate = self
            }
        }
        setupPageControl()
        setPageViewController()
    }
    
    private func setupPageControl() {
        // PageControl 세팅
        self.pageControl.frame = CGRect()
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.pageControl.numberOfPages = pageviewcontrollers.count
        self.pageControl.currentPage = 0
        self.view.addSubview(self.pageControl)
        
        self.pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.pageControl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30).isActive = true
        self.pageControl.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -20).isActive = true
        self.pageControl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
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
//        guard previousIndex >= 0 else { return pageviewcontrollers.last }
        guard previousIndex >= 0 else { return nil }
        return pageviewcontrollers[previousIndex]
    }
    
    // 이후에 보여줄 ViewController를 설정한다.
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = pageviewcontrollers.firstIndex(of: viewController) else { return nil }
        let nextIndex = vcIndex + 1
//        guard pageviewcontrollers.count > nextIndex else { return pageviewcontrollers.first }
        guard pageviewcontrollers.count > nextIndex else { return nil }
        return pageviewcontrollers[nextIndex]
    }
}

extension ViewController: UIPageViewControllerDelegate {
    // 넘어가는 것이 끝나면 호출
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
//        for pre in previousViewControllers {
//            // 이전 viewcontroller
//            print(pre.restorationIdentifier)
//        }
        
//        for item in pageViewController.viewControllers! {
//            // 나타난 viewcontroller
//            print(item.restorationIdentifier)
//        }
        
        guard let nowViewController = pageViewController.viewControllers?.first,
            let index: Int = pageviewcontrollers.firstIndex(of: nowViewController) else { return }
        
        pageControl.currentPage = index
    }
}


extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if pageControl.currentPage == 0 && scrollView.contentOffset.x < scrollView.bounds.size.width {
            scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0)
        } else if pageControl.currentPage == pageviewcontrollers.count - 1 && scrollView.contentOffset.x > scrollView.bounds.size.width {
            scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0)
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if pageControl.currentPage == 0 && scrollView.contentOffset.x < scrollView.bounds.size.width {
            scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0)
        } else if pageControl.currentPage == pageviewcontrollers.count - 1 && scrollView.contentOffset.x > scrollView.bounds.size.width {
            scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0)
        }
    }
}
