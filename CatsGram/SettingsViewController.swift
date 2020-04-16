//
//  SettingsViewController.swift
//  CatsGram
//
//  Created by José Javier Cueto Mejía on 15/04/20.
//  Copyright © 2020 Pozolx. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        do{
             try Auth.auth().signOut()
             print("session finished")
             performSegue(withIdentifier: "toViewController", sender: nil)
        }catch{
            print("error")
        }
       
       
       
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
