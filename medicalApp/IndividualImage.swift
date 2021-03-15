//
//  IndividualImage.swift
//  medicalApp
//
//  Created by Vyom Unadkat on 3/14/21.
//

import UIKit
import InstaZoom


class IndividualImage: UIViewController {
    
    var myStringValue:User?

    @IBOutlet weak var imagedisplay: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        print("The value of myStringValue is: \(myStringValue!.url)")
        
        print(123)
        if let profileImage = myStringValue{
            imagedisplay.loadimagefromcache(urlString: profileImage.url!)
            imagedisplay.isPinchable = true
        }
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = myStringValue?.tag as? String
    }

    

}
