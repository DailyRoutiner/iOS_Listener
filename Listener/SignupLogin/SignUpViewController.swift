//
//  SignUpViewController.swift
//  Oral
//
//  Created by user207270 on 8/9/22.
//

import UIKit
//import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var EmailUI: UITextField!
   
    @IBOutlet weak var PwordUI: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func SignUpButton(_ sender: Any) {
        guard let email = EmailUI.text else{
            return
        }
        guard let password = PwordUI.text else{
            return
        }
//        Auth.auth().createUser(withEmail: email, password: password){
//            firebaseResults,error in if let e = error{
//                print("error")
//            }
//            else{
//                self.performSegue(withIdentifier: "goToNext", sender: self)
//            }
//        }
        let api = APIManager()
        let block = { (message: String) in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
        api.register(email: email, password: password, completion: block)
        
 }
    @IBAction func LoginButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
