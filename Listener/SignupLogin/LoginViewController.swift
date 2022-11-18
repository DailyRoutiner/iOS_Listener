//
//  LoginViewController.swift
//  Oral
//
//  Created by user207270 on 8/9/22.
//

import UIKit
//import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var UIemail: UITextField!
    
    @IBOutlet weak var UIpassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func LoginButton(_ sender: Any) {
        guard let email = UIemail.text else{
            return
        }
        guard let password = UIpassword.text else{
            return
        }
    
//        Auth.auth().signIn(withEmail: email, password: password){
//            firebaseResults,error in if let e = error{
//                print("error")
//            }
//            else{
//                self.performSegue(withIdentifier: "goToNext", sender: self)
//            }    }
        
        let api = APIManager()
        let block = { (message: String) in
            DispatchQueue.main.async {
                let app = UIApplication.shared.delegate as! AppDelegate
                let user = User(email: email)
                app.user = user
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: LoginNoti), object: nil)
            }
        }
        
        api.login(email: email, password: password, completion: block)
        
    }
}
