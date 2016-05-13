//
//  DashboardContentViewController.swift
//  Gigster
//
//  Created by Rodney Gainous Jr on 5/4/16.
//  Copyright © 2016 Rodney. All rights reserved.
//

import UIKit

class DashboardContentViewController: UIViewController {
    
    var pageIndex: Int?
    var projectName: String?
    var status: String?
    var totalTasks: Int?
    var completedTasks: Int?
    var pageControl: UIPageControl?
    var chartDisplayed: Bool!

    @IBOutlet var circleView: UIView!
    @IBOutlet var projectImageView: UIImageView!
    @IBOutlet var projectLabel: UILabel!
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var tasksLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chartDisplayed = false
        
        projectLabel.text = projectName
        tasksLabel.text = "Your team has completed \(completedTasks!) of \(totalTasks!) total tasks."
        
        let percentComplete = CGFloat(Double(completedTasks!)) / CGFloat(Double(totalTasks!)) * 100
        
        let completeText = "\(Int(percentComplete))% complete."
        var combinedText = "Welcome Rodney Gainous. Your project is \(status!)"
        
        if percentComplete < 99 { combinedText += " and \(completeText)" }
        else { combinedText += "." }
        
        let statusRange = (combinedText as NSString).rangeOfString(status!)
        let completeRange = (combinedText as NSString).rangeOfString(completeText)
        
        let attributedString = NSMutableAttributedString(string: combinedText)
        attributedString.addAttribute(NSForegroundColorAttributeName, value: pageControl!.tintColor!, range: statusRange)
        
        if percentComplete < 99 {
            attributedString.addAttribute(NSForegroundColorAttributeName, value: pageControl!.tintColor!, range: completeRange)
        }
        
        headerLabel.attributedText = attributedString
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        pageControl!.currentPage = pageIndex!
        
        if !chartDisplayed {
            chartDisplayed = true
            
            initalizeCircle()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initalizeCircle() {
        addCircleView(circleView, isForeground: true, duration: 0.0, fromValue: 0.0,  toValue: 100)
        addCircleView(circleView, isForeground: false, duration: 1.20, fromValue: 0.0,  toValue: CGFloat(Double(completedTasks!)) / CGFloat(Double(totalTasks!)))
    }
    
    func addCircleView( myView : UIView, isForeground : Bool, duration : NSTimeInterval, fromValue: CGFloat, toValue : CGFloat ) {
        let circleView = CircleView(frame: CGRectMake(0, 0, myView.frame.width, myView.frame.height))
        
        if (isForeground == true) {
            circleView.setStrokeColor(UIColor.lightGrayColor().CGColor)
        } else {
            circleView.setStrokeColor(pageControl!.tintColor!.CGColor)
        }
        
        myView.addSubview(circleView)
        
        circleView.transform = CGAffineTransformMakeRotation(-1.56)
        circleView.animateCircleTo(duration, fromValue: fromValue, toValue: toValue)
    }
}
