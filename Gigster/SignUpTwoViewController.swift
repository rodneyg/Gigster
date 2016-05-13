//
//  SignUpViewController.swift
//  Gigster
//
//  Created by Rodney Gainous Jr on 5/3/16.
//  Copyright © 2016 Rodney. All rights reserved.
//

import UIKit

class SignUpTwoViewController: UIViewController, UITextFieldDelegate {
    
    let organizationTypes = ["1 - 10", "11 - 100", "101 - 1000", "1001 - 10,000", "10,000+"]

    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var phoneField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var orgSizeField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addExpandArrow(orgSizeField)
        
        setPlaceholderColor(nameField)
        setPlaceholderColor(phoneField)
        setPlaceholderColor(emailField)
        setPlaceholderColor(passwordField)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        addBorderToTextField(orgSizeField)
        addBorderToTextField(nameField)
        addBorderToTextField(phoneField)
        addBorderToTextField(emailField)
        addBorderToTextField(passwordField)
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
    
    func showOrganizationAlert() {
        let alert = UIAlertController(title: "Select an organization size.", message: "", preferredStyle: .ActionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in }
        alert.addAction(cancelAction)

        for organization in organizationTypes {
            let optionAction = UIAlertAction(title: organization, style: .Default)  { (action) in
                self.orgSizeField.text = "      \(organization)"
            }
            
            alert.addAction(optionAction)
        }
        
        self.view.endEditing(true)
        self.presentViewController(alert, animated: true) { }
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        showOrganizationAlert()
        
        return false
    }
    
    @IBAction func nextTouched(sender: AnyObject) {
        
    }
}
