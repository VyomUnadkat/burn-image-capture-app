//
//  ViewController.swift
//  medicalApp
//
//  Created by Vyom Unadkat on 1/1/21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
         view.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }
    


    @IBAction func signInOnClick(_ sender: UIButton) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "tabbarcontroller") as! UITabBarController
        self.navigationController?.pushViewController(detailVC, animated: true)

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

