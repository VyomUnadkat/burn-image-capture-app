//
//  ViewController.swift
//  burn
//
//  Created by Vyom Unadkat on 12/22/20.
//

import UIKit
import Firebase
import FirebaseDatabase
class CameraViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
    @IBOutlet weak var imagedescription: UITextField!
    @IBOutlet weak var patientname: UITextField!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var myimageview: UIImageView!

    var ref: DatabaseReference!
    @IBAction func importbtn(_ sender: Any) {
        progressBar.isHidden = true
        let image = UIImagePickerController()
        
        image.delegate = self
        
        image.sourceType = UIImagePickerController.SourceType.camera
        
        image.allowsEditing = false
        
        self.present(image, animated: true){
            //
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]){
        if let image1 = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            myimageview.image = image1
        }
        else{
            //error
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func uploadButtonTapped(_ sender: Any) {
        progressBar.isHidden = false
        ref = Database.database().reference()
        let randomID = UUID.init().uuidString
        let uploadRef = Storage.storage().reference(withPath: "burn/\(randomID).jpg")
        guard let imageData = myimageview.image?.jpegData(compressionQuality: 0.75) else {return}
        let uploadMetaData = StorageMetadata.init()
        uploadMetaData.contentType = "image/jpeg"
        
        let taskreference = uploadRef.putData(imageData, metadata: uploadMetaData){ (downloadMetaData, error) in
            if let error = error{
                print("Got an error! \(error.localizedDescription)")
                return
            }
            print("Put is complete and got back \(String(describing: downloadMetaData))")
            uploadRef.downloadURL(completion: { (url, error) in
                            if let urlText = url?.absoluteString {
                                print("this  is the url")
                                print(urlText)
                                self.ref.child("users").child(randomID).setValue(["name": self.patientname.text!, "description": self.imagedescription.text!, "url": urlText])
                            return
                            }
                        })
        }
        
        taskreference.observe(.progress){[weak self](snapshot) in
            guard let pctThere = snapshot.progress?.fractionCompleted else {return}
            print("You are \(pctThere) complete")
            self?.progressBar.progress = Float(pctThere)
        }
        
        
        // Fetch the download URL
        
        
       
      
        
       
        
        
        
        

        
        
        

    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.isHidden = true
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
         view.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }


}

