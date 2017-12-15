//
//  LoginViewController.swift
//  SpecialTopicProject
//
//  Created by Prajakta Morale on 11/20/17.
//  Copyright © 2017 Prajakta Morale. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import LocalAuthentication

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    let reason = NSLocalizedString("Authentication Required", comment: "authReason")
    var errorPointer:NSError?

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func SignUp(_ sender: UIButton, forEvent event: UIEvent) {
    }
    
    
    @IBAction func loginAction(_ sender: UIButton, forEvent event: UIEvent) {
        
        if self.emailTextField.text == "" || self.passwordTextField.text == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                
                if error == nil {
                    
                    //Print into the console if successfully logged in
                    print("You have successfully logged in")
                    
                    //Go to the HomeViewController if the login is sucessful
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                    self.present(vc!, animated: true, completion: nil)
                    
                } else {
                    
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func reset(_ sender: Any, forEvent event: UIEvent) {
    }
    override func viewDidLoad() {
        
        self.emailTextField.delegate = self
        passwordTextField.text = "12345678"
        emailTextField.text = "pre@gmail.com"
        
        
    }
    
    //Hide keyboard when user touches outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    //Press return key function
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        return(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        touchIDAuthentication()
    }
    
    func touchIDAuthentication() {
        let context = LAContext() //1
        
        //2
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &errorPointer) {
            //3
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason, reply: { (success, error) in
                if success {
                    DispatchQueue.main.async {
                        let a = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                        self.present(a!, animated: true, completion: nil)
                        //Authentication was successful
                    }
                    
                }else {
                    DispatchQueue.main.async {
                        //Authentication failed. Show alert indicating what error occurred
                        self.displayErrorMessage(error: error as! LAError )
                    }
                    
                }
            })
        }else {
            //Touch ID is not available on Device, use password.
            self.showAlertWith(title: "Error", message: (errorPointer?.localizedDescription)!)
            
        }
    }
    
    func displayErrorMessage(error:LAError) {
        var message = ""
        switch error.code {
        case LAError.authenticationFailed:
            message = "Authentication was not successful because the user failed to provide valid credentials."
            break
        case LAError.userCancel:
            message = "Authentication was canceled by the user"
            break
        case LAError.userFallback:
            message = "Authentication was canceled because the user tapped the fallback button"
            break
        case LAError.touchIDNotEnrolled:
            message = "Authentication could not start because Touch ID has no enrolled fingers."
        case LAError.passcodeNotSet:
            message = "Passcode is not set on the device."
            break
        case LAError.systemCancel:
            message = "Authentication was canceled by system"
            break
        default:
            message = error.localizedDescription
        }
        
        self.showAlertWith(title: "Authentication Failed", message: message)
    }
    
}

extension UIViewController {
    func showAlertWith(title:String, message:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(actionButton)
        self.present(alertController, animated: true, completion: nil)
    }
}





