//
//  LoginViewController.swift
//  Wlkthru
//
//  Created by Yohannes Wijaya on 7/26/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Stored Properties
    
    var isCancelButtonTouched: Bool!

    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - IBAction Properties
    
    @IBAction func cancelButtonDidTouch(sender: UIBarButtonItem) {
        self.isCancelButtonTouched = true
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
    
    @IBAction func forgotPasswordButtonDidTouch(sender: UIButton) {
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
    
    @IBAction func loginButtonDidTouch(sender: UIButton) {
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
    
    @IBAction func unwindToLoginViewController(segue: UIStoryboardSegue) {}
    
    // MARK: - UITextFieldDelegate Methods
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        if self.isCancelButtonTouched == true {
            self.dismissViewControllerAnimated(true, completion: nil)
            return true
        }
        guard self.validateEmail(self.emailTextField.text!) else {
            if self.presentedViewController == nil {
                let alertController = UIAlertController(title: "Invalid Email Address", message: "Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
            }
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if !(self.emailTextField.text?.isEmpty)! && !(self.passwordTextField.text?.isEmpty)! {
            self.emailTextField.resignFirstResponder()
            self.passwordTextField.resignFirstResponder()
        }
        else if !(self.emailTextField.text?.isEmpty)! {
            self.passwordTextField.becomeFirstResponder()
        }
        return true
    }
    
    // MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        
        self.isCancelButtonTouched = false

        self.emailTextField.becomeFirstResponder()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)

        if NSString(string: self.emailTextField.text!).length > 0 {
            self.passwordTextField.becomeFirstResponder()
        }
        else {
            self.emailTextField.becomeFirstResponder()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ForgotMyPasswordSegue" {
            guard let validForgotPasswordViewController = segue.destinationViewController as? ForgotPasswordViewController else { return }
            validForgotPasswordViewController.emailAddress = self.emailTextField.text!
        }
    }

    // MARK: - Helper Methods
    
    private func validateEmail(emailString: NSString) -> Bool {
        let emailRegex = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"
        let emailText = NSPredicate(format: "SELF MATCHES [c]%@", emailRegex)
        return (emailText.evaluateWithObject(emailString))
    }
}
