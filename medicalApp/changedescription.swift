//
//  changedescription.swift
//  medicalApp
//
//  Created by Vyom Unadkat on 3/19/21.
//

import UIKit
import Firebase

class changedescription: UIViewController {

    
    @IBOutlet weak var labelcurrent: UILabel!
    var myStringValue:User?
    
    @IBOutlet weak var newdesccription: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("The tag of the current image is: \(myStringValue!.uniquevalue!)")
        print("The tag of the current image is: \(myStringValue!.tag!)")
        labelcurrent.text = myStringValue!.tag
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
         view.addGestureRecognizer(tapGesture)

    }
    @IBAction func uploadBtnclicked(_ sender: Any) {
        if newdesccription.text != ""{
        Database.database().reference().child("users").child("\(myStringValue!.uniquevalue!)").updateChildValues(["tag": newdesccription.text! as? String])
        
        navigationController?.popViewControllers(viewsToPop: 3)
        }else{
                let alert = UIAlertController(title: "Empty field", message: "Please enter a new description.", preferredStyle: UIAlertController.Style.alert)
            
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
                // show the alert
                self.present(alert, animated: true, completion: nil)
        }
        
    }
    
}

extension UINavigationController {

  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.filter({$0.isKind(of: ofClass)}).last {
      popToViewController(vc, animated: animated)
    }
  }

  func popViewControllers(viewsToPop: Int, animated: Bool = true) {
    if viewControllers.count > viewsToPop {
      let vc = viewControllers[viewControllers.count - viewsToPop - 1]
      popToViewController(vc, animated: animated)
    }
  }

}
