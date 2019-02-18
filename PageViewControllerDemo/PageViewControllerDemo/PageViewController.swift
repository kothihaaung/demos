//
//  PageViewController.swift
//  PageViewControllerDemo
//
//  Created by Thiha Aung on 2019/02/18.
//  Copyright © 2019 Thiha Aung. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    lazy var viewControllerList:[UIViewController] = {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let viewControllerA = storyboard.instantiateViewController(withIdentifier: "viewControllerA")
        let viewControllerB = storyboard.instantiateViewController(withIdentifier: "viewControllerB")
        let viewControllerC = storyboard.instantiateViewController(withIdentifier: "viewControllerC")
        
        return [viewControllerA, viewControllerB, viewControllerC]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self;
        
        // Initial View Controller
        if let firstViewController = viewControllerList.first {
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = viewControllerList.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard viewControllerList.count > previousIndex else {
            return nil
        }
        
        return viewControllerList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = viewControllerList.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard viewControllerList.count != nextIndex else {
            return nil
        }
        
        guard viewControllerList.count > nextIndex else {
            return nil
        }
        
        return viewControllerList[nextIndex]
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
