//
//  ViewController.swift
//  Gigster
//
//  Created by Rodney Gainous Jr on 4/29/16.
//  Copyright © 2016 Rodney. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {
    
    var pageIndex: Int?
    var headerText: String?
    var subtitleText: String?
    var imageName: String?
    var pageControl: UIPageControl?
    var skipButton: UIButton?
    var frame: CGRect?
    var animated = false
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named: imageName!)!
        headerLabel.text = headerText
        subtitleLabel.text = subtitleText
        
        if pageIndex == 0 && !animated {
            animated = true
            
            self.imageView.frame.origin.y += 350
            self.headerLabel.alpha = 0
            self.pageControl!.alpha = 0
            self.skipButton!.alpha = 0
            self.subtitleLabel.alpha = 0

            UIView.animateWithDuration(1.5, animations: {
                self.imageView.frame.origin.y -= 350
                }, completion: {
                    (value: Bool) in
                    self.parentViewController!.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height - 90)

                    UIView.animateWithDuration(1.0, animations: { () -> Void in
                        self.headerLabel.alpha = 1
                        self.pageControl!.alpha = 1
                        self.skipButton!.alpha = 1
                        self.imageView.alpha = 1
                        self.subtitleLabel.alpha = 1
                    })
            })
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        pageControl!.currentPage = pageIndex!
        
        if pageIndex == 3 {
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.skipButton!.setTitle("Get Started", forState: UIControlState.Normal)
            })
        } else {
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.skipButton!.setTitle("Skip", forState: UIControlState.Normal)
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

