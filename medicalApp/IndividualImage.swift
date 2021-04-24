//
//  IndividualImage.swift
//  medicalApp
//
//  Created by Vyom Unadkat on 3/14/21.
//

import UIKit
import InstaZoom
import Firebase

import CoreML
import Vision
import ImageIO

class IndividualImage: UIViewController {
    
    var myStringValue:User?

    @IBOutlet weak var btnRun: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var imagedisplay: UIImageView!
    
    @IBOutlet weak var classificationLabel: UILabel!
    private let testImages = ["test1.png", "test2.jpg", "test3.png"]
    private var imgIndex = 0
    
    private var inferencer = ObjectDetector()
    private var image : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let profileImage = myStringValue{
            imagedisplay.loadimagefromcache(urlString: profileImage.url!)
            imagedisplay.isPinchable = true
        }
        btnRun.setTitle("Detect", for: .normal)

    }
    
    
    // MARK: - Image Classification
    
    /// - Tag: MLModelSetup
    @available(iOS 13.0, *)
    lazy var classificationRequest: VNCoreMLRequest = {
        do {
            /*
             Use the Swift class `MobileNet` Core ML generates from the model.
             To use a different Core ML classifier model, add it to the project
             and replace `MobileNet` with that model's generated Swift class.
             */
            //let model = try VNCoreMLModel(for: MobileNet().model)
            let model = try VNCoreMLModel(for: burn_network().model)
            
            let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                self?.processClassifications(for: request, error: error)
            })
            //request.imageCropAndScaleOption = .centerCrop
            return request
        } catch {
            fatalError("Failed to load Vision ML model: \(error)")
        }
    }()
    
    /// - Tag: PerformRequests
    func updateClassifications(for image: UIImage) {
        classificationLabel.text = "Classifying..."
        
        let orientation = CGImagePropertyOrientation(image.imageOrientation)
        guard let ciImage = CIImage(image: image) else { fatalError("Unable to create \(CIImage.self) from \(image).") }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
            do {
                try handler.perform([self.classificationRequest])
            } catch {

                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        }
    }
    
    /// Updates the UI with the results of the classification.
    /// - Tag: ProcessClassifications
    func processClassifications(for request: VNRequest, error: Error?) {
        DispatchQueue.main.async {
            guard let results = request.results else {
                self.classificationLabel.text = "Unable to classify image.\n\(error!.localizedDescription)"
                return
            }

            let classifications = results as! [VNCoreMLFeatureValueObservation]
            var localPrediction: String?
            var outputarray = classifications.first?.featureValue.multiArrayValue!
            
            var max_value : Float32 = 0
            var final_surgery = Array<Float>()
            for i in 0..<outputarray!.count{
                final_surgery.append(Float((outputarray?[i])!))
            }



            if classifications.isEmpty {
                self.classificationLabel.text = "Nothing recognized."
            } else {

                
                if final_surgery[1] >= 0.5 {
                    self.classificationLabel.text = "Classification:"+"\n"+" Surgery required"+"\n"+"\(final_surgery)"
                }else{
                    self.classificationLabel.text = "Classification:"+"\n"+" Surgery not required"+"\n"+"\(final_surgery)"
                }
            }
        }
    }
    
    
    
    @IBAction func runTapped(_ sender: Any) {
        btnRun.isEnabled = false
        btnRun.setTitle("Running the model...", for: .normal)
        
        image = self.imagedisplay.image
        
        var thumbnail:UIImage = (image?.resizeImage(224, opaque: true))!
        print(thumbnail.size)
        updateClassifications(for: thumbnail)
        
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

        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "changedescription2") as! changedescription2
        detailVC.myStringValue = myStringValue
        self.navigationController?.pushViewController(detailVC, animated: true)
    }

}

extension UIImage {
    func resizeImage(_ dimension: CGFloat, opaque: Bool, contentMode: UIView.ContentMode = .scaleAspectFit) -> UIImage {
            var width: CGFloat
            var height: CGFloat
            var newImage: UIImage

            let size = self.size
            let aspectRatio =  size.width/size.height

            switch contentMode {
                case .scaleAspectFit:
                    if aspectRatio > 1 {                            // Landscape image
                        width = dimension
                        height = dimension / aspectRatio
                    } else {                                        // Portrait image
                        height = dimension
                        width = dimension * aspectRatio
                    }

            default:
                fatalError("UIIMage.resizeToFit(): FATAL: Unimplemented ContentMode")
            }

            if #available(iOS 10.0, *) {
                let renderFormat = UIGraphicsImageRendererFormat.default()
                renderFormat.opaque = opaque
                let renderer = UIGraphicsImageRenderer(size: CGSize(width: 224, height: 224), format: renderFormat)
                newImage = renderer.image {
                    (context) in
                    self.draw(in: CGRect(x: 0, y: 0, width: 224, height: 224))
                }
            } else {
                UIGraphicsBeginImageContextWithOptions(CGSize(width: 224, height: 224), opaque, 0)
                    self.draw(in: CGRect(x: 0, y: 0, width: 224, height: 224))
                    newImage = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
            }

            return newImage
        }
    }
