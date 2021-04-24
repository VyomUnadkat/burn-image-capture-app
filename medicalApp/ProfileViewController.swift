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
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.hidesBackButton = true

        self.tabBarController?.title = "Profile"
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
        
        self.tabBarController?.navigationItem.leftBarButtonItem = nil
    }

}
