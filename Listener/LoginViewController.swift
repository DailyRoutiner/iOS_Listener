//
//  LoginViewController.swift
//  Listener
//  Oral Nelson
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var logoImageView: UIImageView!
    
    let indicator = UIActivityIndicatorView(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField(textfield: emailTextField, placeholder: "Email adress")
        setupTextField(textfield: passwordTextField, placeholder: "password")
        passwordTextField.isSecureTextEntry = true
        
        registerButton.layer.borderColor = UIColor.systemGray.cgColor
        registerButton.layer.borderWidth = 1.0
        registerButton.layer.cornerRadius = 8.0
        registerButton.layer.masksToBounds = true
        logoImageView.layer.cornerRadius = 50
        
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerAction(_ sender: Any) {
        guard let email = self.emailTextField.text,
              let password = self.passwordTextField.text,
              email != "",
              password != "" else {
        
            alert(title: "Input Error", message: "Please input your email or password")
            return
        }
        
        indicator.startAnimating()
        let api = APIManager()
        let block = { (message: String) in
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
                self.alert(title: message, message: "") {
                    let app = UIApplication.shared.delegate as! AppDelegate
                    let user = User(email: email)
                    app.user = user
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: LoginNoti), object: nil)
                }
            }
        }
        
        api.login(email: email, password: password, completion: block)
    }
    
    private func setupTextField(textfield: UITextField, placeholder: String) {
        let text = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray2])
        textfield.attributedPlaceholder = text
        
        textfield.layer.cornerRadius = 8.0
        textfield.layer.masksToBounds = true
        textfield.layer.borderColor = UIColor.systemGray.cgColor
        textfield.layer.borderWidth = 1.0
    }
    
    private func alert(title: String, message: String, completion: (() -> ())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { action in
            if let com = completion {
                com()
            }
        }))
        self.present(alert, animated: true, completion: nil)
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
