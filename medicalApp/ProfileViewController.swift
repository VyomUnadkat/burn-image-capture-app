//
//  ProfileViewController.swift
//  medicalApp
//
//  Created by Vyom Unadkat on 1/2/21.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.tabBarController?.title = "Profile"
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
        
        self.tabBarController?.navigationItem.leftBarButtonItem = nil
    }

}
