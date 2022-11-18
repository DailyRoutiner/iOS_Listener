//
//  MainNavigationViewController.swift
//  Listener
//
//  Created by Dongpeng Dai on 2022/8/4.
//

import UIKit

let LoginNoti = "LoginNoti"
let LogoutNoti = "LogoutNoti"

class MainNavigationViewController: UINavigationController {

    var mainTab: UIViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(receiveLoginNotification), name: NSNotification.Name(rawValue: LoginNoti), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(receiveLogoutNotification), name: NSNotification.Name(rawValue: LogoutNoti), object: nil)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        receiveLogoutNotification()
    }
    
    @objc func receiveLoginNotification() {
        let app = UIApplication.shared.delegate as! AppDelegate
        app.isLogin = true
        self.popViewController(animated: true)
    }
    
    @objc func receiveLogoutNotification() {
        let app = UIApplication.shared.delegate as! AppDelegate
        if !app.isLogin {
            let vc = Self.getLoginController()
            self.pushViewController(vc, animated: false)
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


extension MainNavigationViewController {
    static func getRegisterController() -> UIViewController {
//        let storyboard = UIStoryboard(name: "register", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "RegisterViewController")
        let storyboard = UIStoryboard(name: "signuplogin", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SignUpViewController")
        return vc
    }
    
    static func getLoginController() -> UIViewController {
        let storyboard = UIStoryboard(name: "signuplogin", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        return vc
    }
    
    static func getPlayerController(book: Book) -> UIViewController {
        let storyboard = UIStoryboard(name: "player", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
        vc.setBook(book: book)
        
        return vc
    }
    
    static func getBookDetailController(book: Book) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "BookDetailViewController") as! BookDetailViewController
        vc.bookDetail = book
        return vc
    }
}
