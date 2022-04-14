//
//  LoginViewController.swift
//  PetFoster
//
//  Created by Niko Holbrook on 4/6/22.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var loginUserField: UITextField!
    @IBOutlet weak var loginPassField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        let username = loginUserField.text!
        let password = loginPassField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password)
        { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    @IBAction func signUp(_ sender: Any) {
        var user = PFUser()
        user.username = loginUserField.text
        user.password = loginPassField.text
        
        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
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
