//
//  LoginViewController.swift
//  Gigster
//
//  Created by Rodney Gainous Jr on 5/1/16.
//  Copyright © 2016 Rodney. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        addBorderToTextField(emailField)
        setPlaceholderColor(emailField, text: "Email address")
        
        addBorderToTextField(passwordField)
        setPlaceholderColor(passwordField, text: "Password")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setPlaceholderColor(textField: UITextField, text: String) {
        textField.attributedPlaceholder = NSAttributedString(string:text, attributes:[NSForegroundColorAttributeName: UIColor.blackColor()])
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
    
    @IBAction func loginTouched(sender: AnyObject) {
        if emailField.text!.isEmpty { emailField.shake() }
        else if passwordField.text!.isEmpty { passwordField.shake() }
        else { self.performSegueWithIdentifier("ShowDashFromLogin", sender: self) }
    }
    
    @IBAction func startTouched(sender: AnyObject) {
        self.performSegueWithIdentifier("ShowSignUp", sender: self)
    }
}
