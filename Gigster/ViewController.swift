//
//  PageViewController.swift
//  Gigster
//
//  Created by Rodney Gainous Jr on 4/29/16.
//  Copyright © 2016 Rodney. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var vcs: [PageContentViewController]?
    var animated = false
    
    @IBOutlet var skipButton: UIButton!
    @IBOutlet var pageControl: UIPageControl!
    
    var pageViewController: UIPageViewController?
    
    let walkthroughs = ["Walkthrough1", "Walkthrough2", "Walkthrough3", "Walkthrough4"]
    let pageHeaders = ["Hire an elite development team", "Instant price quotes", "Guaranteed, fixed pricing", "End-to-end management"]
    let pageSubtitles = ["GIGSTER CONNECTS YOU WITH THE TOP 1% VETTED TALENT", "GET STARTED IN 10 MINUTES OR LESS", "PRICING THATS AFFORDABLE AND ALWAYS FINAL", "A SILICON VALLEY PRODUCT MANAGER ON EVERY PROJECT"]
    var pageImages = ["gigster","hero-illustration-1","hero-illustration-2","hero-illustration-3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        vcs = [viewControllerAtIndex(0)]
        
        /* Getting the page View controller */
        pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        self.pageViewController!.dataSource = self
        
        let pageContentViewController = self.viewControllerAtIndex(0)
        self.pageViewController!.setViewControllers([pageContentViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        
        addChildViewController(pageViewController!)
        view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func viewControllerAtIndex(index: Int) -> PageContentViewController {
        if ((walkthroughs.count == 0) || (index >= walkthroughs.count)) {
            return PageContentViewController()
        }
        
        let vc: PageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Walkthrough") as! PageContentViewController
        
        if index > 0 { animated = true }
        
        vc.imageName = pageImages[index]
        vc.headerText = pageHeaders[index]
        vc.subtitleText = pageSubtitles[index]
        vc.pageControl = pageControl
        vc.skipButton = skipButton
        vc.pageIndex = index
        vc.animated = animated
        
        return vc
    }
    
    
    // MARK: - Page View Controller Data Source
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! PageContentViewController
        var index = vc.pageIndex!
        
        if (index == 0 || index == NSNotFound) {
            return nil
            
        }
        
        index -= 1
        return self.viewControllerAtIndex(index)
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! PageContentViewController
        var index = vc.pageIndex!
        
        if (index == NSNotFound) {
            return nil
        }
        
        index += 1
        
        if (index == self.walkthroughs.count) {
            return nil
        }
        
        return self.viewControllerAtIndex(index)
        
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return walkthroughs.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    @IBAction func skipTouched(sender: AnyObject) {
        performSegueWithIdentifier("ShowLogin", sender: self)
    }
}
