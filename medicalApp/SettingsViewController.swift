//
//  SettingsViewController.swift
//  medicalApp
//
//  Created by Vyom Unadkat on 1/2/21.
//

import UIKit

class SettingsViewController: UIViewController {

    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func logOutOnClick(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.title = "Settings"
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
        self.tabBarController?.navigationItem.hidesBackButton = true
        
        self.tabBarController?.navigationItem.leftBarButtonItem = nil
    }
}
