//
//  Extension.swift
//  medicalApp
//
//  Created by Vyom Unadkat on 2/14/21.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView{
    func loadimagefromcache(urlString: String){
        
        self.image = nil
        
        if let cachedimage = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            self.image = cachedimage
            return
        }
        
        let url = NSURL(string: urlString)
        URLSession.shared.dataTask(with: url! as URL, completionHandler:{(data, response, error) in
            
            if error != nil{
                print(error)
                return
            }
            
            DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.async {
                    
                    if let downloadedImage = UIImage(data: data!){
                        imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                        self.image = UIImage(data: data!)
                    }
                   
                    //cell.imageView?.image = UIImage(data: data!)
                }
            }
            
        }).resume()
    }
}
