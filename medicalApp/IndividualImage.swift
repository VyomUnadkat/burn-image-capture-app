//
//  IndividualImage.swift
//  medicalApp
//
//  Created by Vyom Unadkat on 3/14/21.
//

import UIKit
import InstaZoom
import Firebase


class IndividualImage: UIViewController {
    
    var myStringValue:User?

    @IBOutlet weak var imagedisplay: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("The value of myStringValue is: \(myStringValue!.url!)")
        print("The unique id of the user is: \(myStringValue!.uniquevalue!)")
        print(123)
        if let profileImage = myStringValue{
            imagedisplay.loadimagefromcache(urlString: profileImage.url!)
            imagedisplay.isPinchable = true
        }
        //getpatients()
        

    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
            return false
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = myStringValue?.tag as? String
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(menuButtonTapped(sender:)))
        
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.init(red: 6/255, green: 155/255, blue: 158/255, alpha: 1.0)
    }

    @objc func menuButtonTapped(sender: UIBarButtonItem) {

        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "changedescription") as! changedescription
        detailVC.myStringValue = myStringValue
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    func getpatients(){
        Database.database().reference().child("users").observe(.childAdded, with: { [self] (snapshot) in
                let namevalue = snapshot.value as? [String: AnyObject]
            print(snapshot.key)
                print("this is the name value")
                    if let dictionaryy = snapshot.value as? [String: AnyObject]{
                        print(dictionaryy.keys)
                    
                }
                    
                    DispatchQueue.global(qos: .background).async {

                        // Background Thread

                        DispatchQueue.main.async {
                            // Run UI Updates
                            //self.tableView.reloadData()
                        }
                    }
                
            }, withCancel: nil)
        }
    

}
