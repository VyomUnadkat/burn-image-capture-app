//
//  Allpatients.swift
//  medicalApp
//
//  Created by Vyom Unadkat on 3/4/21.
//

import UIKit
import Firebase

class Allpatients: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    let cellId = "cellId"
    var user = [User]()
    var uniquevalues = [String]()
    
    var currentuser = [User]()
    
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getpatients()
         self.user.sort { (message1, message2) -> Bool in
            return message1.name! < message2.name!
        }
        self.user = Array(Set(self.user))
        print("I am here")
        tableView.delegate = self
        tableView.dataSource = self
        

        
        // Do any additional setup after loading the view.
    }
    
   
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = user[indexPath.row].name
        cell.selectionStyle = .none
        cell.imageView?.image = UIImage(named: "37-contact")
        cell.imageView?.contentMode = .scaleAspectFill
        return cell
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? Individualpatient{
            destination.nameofpatient = user[tableView.indexPathForSelectedRow!.row]
        }
    }
    
    @objc func menuButtonTapped(sender: UIBarButtonItem) {

        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "CameraViewController") as! CameraViewController
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.title = "All patients"
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(menuButtonTapped(sender:)))
        self.tabBarController?.navigationItem.rightBarButtonItem?.tintColor = UIColor.init(red: 6/255, green: 155/255, blue: 158/255, alpha: 1.0)
        self.tabBarController?.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: nil)
        self.tabBarController?.navigationItem.leftBarButtonItem?.tintColor = UIColor.init(red: 6/255, green: 155/255, blue: 158/255, alpha: 1.0)
    }
    

    
    func getpatients(){
        Database.database().reference().child("users").queryOrdered(byChild: "name").observe(.childAdded, with: { [self] (snapshot) in
                let namevalue = snapshot.value as? [String: AnyObject]
                print("this is the name value")
                if !self.uniquevalues.contains(namevalue?["name"] as! String){
                    if let dictionaryy = snapshot.value as? [String: AnyObject]{
                        print(dictionaryy.keys)
                    let user = User()
                    self.user.append(user)
                    
                        

                    //self.user = Array(Set(self.user))
                        
                    
//                        self.user.sortInPlace({(message1, message2) -> Bool in
//                            return message1.name? < message2.name
//                        })
                    //self.user.sort(by: {$0["name"] < $1["name"]})
                    //print(dictionaryy["name"])
                    user.uniquevalue = dictionaryy["id"] as! String
                    user.name = dictionaryy["name"] as! String
                    user.tag = dictionaryy["tag"] as! String
                    user.url = dictionaryy["url"] as! String
                    print(user.name, user.tag, user.url, user.uniquevalue)
                    print("now next")
                    print(user)
                }
                    self.uniquevalues.append(namevalue?["name"] as! String)
                    
                    DispatchQueue.global(qos: .background).async {

                        // Background Thread

                        DispatchQueue.main.async {
                            // Run UI Updates
                            self.tableView.reloadData()
                        }
                    }
                }
            }, withCancel: nil)
        }
    
    
    
    
    

}


