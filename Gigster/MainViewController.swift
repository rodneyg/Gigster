//
//  MainViewController.swift
//  Gigster
//
//  Created by Rodney Gainous Jr on 5/4/16.
//  Copyright © 2016 Rodney. All rights reserved.
//

import UIKit

class MainViewController:UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var vcs: [DashboardContentViewController]?
    var animated = false
    
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var dashButton: UIButton!
    
    var pageViewController: UIPageViewController?
    
    let projectNames = ["Uber", "Facebook", "Slack"]
    let projectStatuses = ["in progress", "in progress", "completed"]
    let projectTotalTasks = [10, 10, 12]
    let completedProjectTasks = [2, 5, 12]
    
    @IBOutlet var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var titleView : UIImageView
        titleView = UIImageView(frame: CGRectMake(0, 0, 50, 10.5))
        titleView.image = UIImage(named: "gigster-text")
        titleView.contentMode = .ScaleAspectFit
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.translucent = false
        
        self.navigationItem.titleView = titleView
        
        let menuImage = UIImage(named: "Menu Burger")!
        let menuButton = UIButton(type: .Custom)
        menuButton.frame = CGRectMake(0, 0, 22, 16)
        menuButton.setBackgroundImage(menuImage, forState: .Normal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)
        
        let postImage = UIImage(named: "Write a Post Icon")!
        let postButton = UIButton(type: .Custom)
        postButton.frame = CGRectMake(0, 0, 22, 22)
        postButton.setBackgroundImage(postImage, forState: .Normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: postButton)
        
        vcs = [viewControllerAtIndex(0)]
        
        self.view.layoutIfNeeded()
        
        if pageViewController == nil {
            /* Getting the page View controller */
            pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DashPageView") as? UIPageViewController
            self.pageViewController!.dataSource = self
            self.pageViewController!.view.frame = CGRect(x: containerView.frame.origin.x, y: containerView.frame.origin.y + 3, width: containerView.frame.width, height: containerView.frame.height)
            self.pageViewController!.view.layoutIfNeeded()
            
            let pageContentViewController = self.viewControllerAtIndex(0)
            self.pageViewController!.setViewControllers([pageContentViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
            
            addChildViewController(pageViewController!)
            view.addSubview(pageViewController!.view)
            pageViewController!.didMoveToParentViewController(self)
            pageControl.numberOfPages = projectNames.count
        }
        
        addTopBorder(containerView)
        addBorderToButton(dashButton)
        
        self.view.layoutIfNeeded()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addBorderToButton(button: UIButton) {
        let border = CALayer()
        let width = CGFloat(3.5)
        border.borderColor = pageControl.tintColor.CGColor
        border.frame = CGRect(x: 0, y: button.frame.size.height - width, width: button.frame.size.width, height: button.frame.size.height)
        
        border.borderWidth = width
        border.opaque = true
        border.opacity = 1.0
        button.layer.addSublayer(border)
        button.layer.masksToBounds = true
    }
    
    func addTopBorder(view: UIView) {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.lightGrayColor().CGColor
        border.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 2)
        
        border.borderWidth = width
        border.opaque = true
        border.opacity = 0.75
        view.layer.addSublayer(border)
        view.layer.masksToBounds = true
    }
    
    func viewControllerAtIndex(index: Int) -> DashboardContentViewController {
        if ((projectNames.count == 0) || (index >= projectNames.count)) {
            return DashboardContentViewController()
        }
        
        let vc: DashboardContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Dashboard") as! DashboardContentViewController
        
        if index > 0 { animated = true }
        
        vc.projectName = projectNames[index]
        vc.status = projectStatuses[index]
        vc.totalTasks = projectTotalTasks[index]
        vc.completedTasks = completedProjectTasks[index]
        vc.pageControl = pageControl
        vc.pageIndex = index
        vc.view.frame = containerView.frame
        vc.view.layoutIfNeeded()
        
        return vc
    }
    
    
    // MARK: - Page View Controller Data Source
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! DashboardContentViewController
        var index = vc.pageIndex!
        
        if (index == 0 || index == NSNotFound) {
            return nil
            
        }
        
        index -= 1
        return self.viewControllerAtIndex(index)
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! DashboardContentViewController
        var index = vc.pageIndex!
        
        if (index == NSNotFound) {
            return nil
        }
        
        index += 1
        
        if (index == self.projectNames.count) {
            return nil
        }
        
        return self.viewControllerAtIndex(index)
        
    }
    
    @IBAction func milestoneTouched(sender: AnyObject) {
    }
    
    @IBAction func topButtonTouched(sender: AnyObject) {
        //to change button highlight remove all sublayers and add border to new button
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
}
