//
//  ViewController.swift
//  CatsGram
//
//  Created by José Javier Cueto Mejía on 14/04/20.
//  Copyright © 2020 Pozolx. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    
    @IBAction func SignInClicked(_ sender: Any) {
        performSegue(withIdentifier: "toHomeVC", sender: nil)
    }
    
    
    @IBAction func SignUpClicked(_ sender: Any) {
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
}

