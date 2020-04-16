//
//  ViewController.swift
//  CatsGram
//
//  Created by José Javier Cueto Mejía on 14/04/20.
//  Copyright © 2020 Pozolx. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var indicatorActivity: UIActivityIndicatorView!
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicatorActivity.isHidden = true
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func SignInClicked(_ sender: Any) {
        indicatorActivity.isHidden = false
        if emailText.text != "" && passwordText.text !=  ""{
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (authData, error) in
                if let safeError = error {
                    self.makeAlert(titleInput: "Error", messageInput: safeError.localizedDescription)
                }else{
                    self.performSegue(withIdentifier: "toHomeVC", sender: nil)
                }
            }
            
        }else{
            makeAlert(titleInput: "Error", messageInput: "Fields empty to Sign")
            
        }
        
    }
    
    
    @IBAction func SignUpClicked(_ sender: Any) {
        indicatorActivity.isHidden = false
        
        if emailText.text != "" && passwordText.text !=  ""{
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (authData, error) in
                if let safeError = error {
                    self.makeAlert(titleInput: "Error", messageInput: safeError.localizedDescription)
                }else{
                    self.performSegue(withIdentifier: "toHomeVC", sender: nil)
                }
            }
        }else{
            makeAlert(titleInput: "Error", messageInput: "Fields empty")
            
        }
        
        
    }
    
    @IBAction func HelpClicked(_ sender: Any) {
        performSegue(withIdentifier: "toHelpVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHelpVC" {
            let helpVC = segue.destination
            helpVC.popoverPresentationController?.delegate = self
        }
    }
    
    // to show like a modal inside of the view
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    func makeAlert(titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        indicatorActivity.isHidden = true
    }
}

