//
//  SignUpViewController.swift
//  Gigster
//
//  Created by Rodney Gainous Jr on 5/3/16.
//  Copyright © 2016 Rodney. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var projectNameField: UITextField!
    @IBOutlet var budgetRangeField: UITextField!
    @IBOutlet var startField: UITextField!
    @IBOutlet var projectTypeField: UITextField!
    
    let budgetRanges = ["$5k - $10k", "$10k - $20k", "$20k - $50k", "$50k+", "I Don't Know"]
    let startTimes = ["Now", "1 week", "2 weeks", "1 month", "2 months"]
    let projectTypes = ["iOS", "Android", "Website", "Backend", "Integration", "UI/UX", "Code Review", "Other"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addExpandArrow(budgetRangeField)
        addExpandArrow(startField)
        addExpandArrow(projectTypeField)
        
        setPlaceholderColor(projectNameField)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        addBorderToTextField(projectNameField)
        addBorderToTextField(budgetRangeField)
        addBorderToTextField(startField)
        addBorderToTextField(projectTypeField)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setPlaceholderColor(textField: UITextField) {
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!,
                                                             attributes:[NSForegroundColorAttributeName: UIColor.blackColor()])
    }
    
    func addExpandArrow(textField: UITextField) {
        let imageView = UIImageView(image: UIImage(named: "expand-arrow"))
        imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        textField.rightViewMode = UITextFieldViewMode.Always
        textField.rightView = imageView
    }
    
    func addBorderToTextField(textField: UITextField) {
        let border = CALayer()
        let width = CGFloat(1.25)
        border.borderColor = UIColor.lightGrayColor().CGColor
        border.frame = CGRect(x: 0, y: textField.frame.size.height - width, width: textField.frame.size.width, height: textField.frame.size.height)
        
        border.borderWidth = width
        border.opaque = true
        border.opacity = 0.11
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
    }
    
    func showAlertView(textField: UITextField) {
        let alert = UIAlertController(title: textField.placeholder!, message: "", preferredStyle: .ActionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in }
        alert.addAction(cancelAction)
        
        var options = projectTypes
        if textField == startField { options = startTimes }
        else if textField == budgetRangeField { options = budgetRanges }
        
        for option in options {
            let optionAction = UIAlertAction(title: option, style: .Default)  { (action) in
                textField.text = option
            }
            
            alert.addAction(optionAction)
        }
        
        self.view.endEditing(true)
        self.presentViewController(alert, animated: true) { }
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        showAlertView(textField)

        return false
    }
    
    @IBAction func nextTouched(sender: AnyObject) {
        performSegueWithIdentifier("ShowSignUpTwo", sender: self)
    }
}
