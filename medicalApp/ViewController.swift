//
//  ViewController.swift
//  medicalApp
//
//  Created by Vyom Unadkat on 1/1/21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        email.overrideUserInterfaceStyle = .light
        password.overrideUserInterfaceStyle = .light
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        
    }
    

    @IBAction func signInOnClick(_ sender: UIButton) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "tabbarcontroller") as! UITabBarController
        self.navigationController?.pushViewController(detailVC, animated: true)
//        if email.text == "test1@usc.edu" && password.text == "trojan"{
//            self.navigationController?.pushViewController(detailVC, animated: true)
//        }
//        else{
//                    let alert = UIAlertController(title: "Invalid credentials", message: "Please enter the correct Email Id and Password.", preferredStyle: UIAlertController.Style.alert)
//
//                    // add an action (button)
//                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//
//                    // show the alert
//                    self.present(alert, animated: true, completion: nil)
//        }

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if Core.shared.isNewUser(){
            //show onboarding
            let vc = storyboard?.instantiateViewController(identifier: "WelcomeViewController") as! WelcomeViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    
}

class Core{
    static let shared = Core()
    
    func isNewUser() -> Bool{
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }
    
    func setIsNotNewUser(){
        UserDefaults.standard.setValue(true, forKey: "isNewUser")
    }
}

