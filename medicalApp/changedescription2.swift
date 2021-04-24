//
//  changedescription2.swift
//  medicalApp
//
//  Created by Vyom Unadkat on 4/3/21.
//

import UIKit
import Firebase

class changedescription2: UIViewController {

    let gender_array = ["Male", "Female", "Trans - F to M", "Trans - M to F", "Intersex", "Other"]
    var genderpickerview = UIPickerView()
    
    let race_array = ["White", "Black", "Asian", "Hispanic", "Native American", "Native Hawaiin/Pacific Islander"]
    var racepickerview = UIPickerView()
    
    let mechanism_array = ["Scald", "Contact", "Flame", "Electrical", "Chemical", "Dermatologic"]
    var mechanismpickerview = UIPickerView()
    
    let injurydatepicker = UIDatePicker()
    let admissiondatepicker = UIDatePicker()
    
    @IBOutlet weak var newdesccription: UITextField!
    @IBOutlet weak var newage: UITextField!
    
    @IBOutlet weak var labelcurrent: UILabel!
    var myStringValue:User?
    @IBOutlet weak var agecurrent: UILabel!
    
    @IBOutlet weak var sexcurrent: UILabel!
    @IBOutlet weak var newsex: UITextField!
    
    @IBOutlet weak var racecurrent: UILabel!
    @IBOutlet weak var newrace: UITextField!
    
    @IBOutlet weak var dateofinjurycurrent: UILabel!
    @IBOutlet weak var newdateofinjury: UITextField!
    
    @IBOutlet weak var dateofadmissioncurrent: UILabel!
    @IBOutlet weak var newdateofadmission: UITextField!
    
    @IBOutlet weak var mechanismcurrent: UILabel!
    @IBOutlet weak var newmechanism: UITextField!
    
    @IBOutlet weak var pbdatecurrent: UILabel!
    @IBOutlet weak var newpbdate: UITextField!
    
    @IBOutlet weak var TBSA: UILabel!
    @IBOutlet weak var newTBSA: UITextField!
    
    @IBOutlet weak var surfaceareacurrent: UILabel!
    @IBOutlet weak var newsurfacearea: UITextField!
    
    @IBOutlet weak var thicknesscurrent: UILabel!
    @IBOutlet weak var newthickness: UITextField!
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        injurydatepicker.datePickerMode = .date
        injurydatepicker.preferredDatePickerStyle = .wheels
        injurydatepicker.addTarget(self, action: #selector(changedescription2.dateChanged(injurydatepicker:)), for: .valueChanged)
        newdateofinjury.inputView = injurydatepicker
        
        
        admissiondatepicker.datePickerMode = .date
        admissiondatepicker.preferredDatePickerStyle = .wheels
        admissiondatepicker.addTarget(self, action: #selector(changedescription2.dateChanged2(admissiondatepicker:)), for: .valueChanged)
        newdateofadmission.inputView = admissiondatepicker
        
        
        
        
        
        genderpickerview.tag = 1
        racepickerview.tag = 2
        mechanismpickerview.tag = 3
        

        print(myStringValue)
        
        print("The tag of the current image is: \(myStringValue!.uniquevalue!)")
        print("The tag of the current image is: \(myStringValue!.tag!)")
        print("The tag of the current image is: \(myStringValue!.age!)")
        labelcurrent.text = myStringValue!.tag
        agecurrent.text = myStringValue!.age
        sexcurrent.text = myStringValue!.sex
        racecurrent.text = myStringValue!.race
        dateofinjurycurrent.text = myStringValue!.date_injury
        dateofadmissioncurrent.text = myStringValue!.date_admission
        mechanismcurrent.text = myStringValue!.mechanism
        pbdatecurrent.text = myStringValue!.postburndate
        TBSA.text = myStringValue!.TBSA
        surfaceareacurrent.text = myStringValue!.surfacearea
        thicknesscurrent.text = myStringValue!.thickness
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
         view.addGestureRecognizer(tapGesture)
        
        genderpickerview.delegate = self
        genderpickerview.dataSource = self
        
        racepickerview.delegate = self
        racepickerview.dataSource = self
        
        mechanismpickerview.delegate = self
        mechanismpickerview.dataSource = self
        
        newsex.inputView = genderpickerview
        newrace.inputView = racepickerview
        newmechanism.inputView = mechanismpickerview
    }
    
    @objc func dateChanged(injurydatepicker: UIDatePicker){
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MM/dd/yyyy"
        newdateofinjury.text = dateformatter.string(from: injurydatepicker.date)
    }
    
    @objc func dateChanged2(admissiondatepicker: UIDatePicker){
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MM/dd/yyyy"
        newdateofadmission.text = dateformatter.string(from: admissiondatepicker.date)
    }
    
    
    @IBAction func uploadBtnclicked(_ sender: Any) {
        if newdesccription.text != ""{
        Database.database().reference().child("users").child("\(myStringValue!.uniquevalue!)").updateChildValues(["tag": newdesccription.text! as? String])
            
        Database.database().reference().child("users").child("\(myStringValue!.uniquevalue!)").updateChildValues(["age": newage.text! as? String])
            
        Database.database().reference().child("users").child("\(myStringValue!.uniquevalue!)").updateChildValues(["sex": newsex.text! as? String])
            
        Database.database().reference().child("users").child("\(myStringValue!.uniquevalue!)").updateChildValues(["race": newrace.text! as? String])
            
        Database.database().reference().child("users").child("\(myStringValue!.uniquevalue!)").updateChildValues(["date_injury": newdateofinjury.text! as? String])
            
        Database.database().reference().child("users").child("\(myStringValue!.uniquevalue!)").updateChildValues(["date_admission": newdateofadmission.text! as? String])
            
        Database.database().reference().child("users").child("\(myStringValue!.uniquevalue!)").updateChildValues(["mechanism": newmechanism.text! as? String])
            
        Database.database().reference().child("users").child("\(myStringValue!.uniquevalue!)").updateChildValues(["post_burn_date": newpbdate.text! as? String])
            
        Database.database().reference().child("users").child("\(myStringValue!.uniquevalue!)").updateChildValues(["TBSA": newTBSA.text! as? String])
            
        Database.database().reference().child("users").child("\(myStringValue!.uniquevalue!)").updateChildValues(["surfacearea": newsurfacearea.text! as? String])
            
        Database.database().reference().child("users").child("\(myStringValue!.uniquevalue!)").updateChildValues(["thickness": newthickness.text! as? String])
        
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

extension changedescription2: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView.tag == 1{
            return 1
        } else if pickerView.tag == 2{
            return 1
        } else if pickerView.tag == 3{
            return 1
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1{
            return gender_array.count
        } else if pickerView.tag == 2{
            return race_array.count
        } else if pickerView.tag == 3{
            return mechanism_array.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        if pickerView.tag == 1{
            return gender_array[row]
        } else if pickerView.tag == 2{
            return race_array[row]
        } else if pickerView.tag == 3{
            return mechanism_array[row]
        }
        return "nil"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        if pickerView.tag == 1{
            newsex.text = gender_array[row]
            newsex.resignFirstResponder()
        } else if pickerView.tag == 2{
            newrace.text = race_array[row]
            newrace.resignFirstResponder()
        } else if pickerView.tag == 3{
            newmechanism.text = mechanism_array[row]
            newmechanism.resignFirstResponder()
        }
    }
    
}
