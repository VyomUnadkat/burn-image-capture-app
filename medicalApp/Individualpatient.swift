//
//  Individualpatient.swift
//  medicalApp
//
//  Created by Vyom Unadkat on 3/4/21.
//

import UIKit
import Firebase

import InstaZoom


class Individualpatient: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var datatopass: String?
    @IBOutlet weak var searchbaritem: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    let cellId = "cellId"
    var uniquevalues = [String]()

    var user = [User]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "detailimage", sender: self)
//    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        print(user[indexPath.row].url)
        
        performSegue(withIdentifier: "detailimage", sender: self)
        
       
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? IndividualImage{
            destination.myStringValue = user[tableView.indexPathForSelectedRow!.row]
        }
    }
    
    
    
    
    
    
   
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CutomizedTableViewCell
        cell.mytag?.text = user[indexPath.row].tag?.capitalized
        cell.selectionStyle = .none
        cell.myimage.isPinchable = true
        var usertopass = user[indexPath.row].url
        self.datatopass = usertopass
        
        if let profileImage = user[indexPath.row].url{
            cell.myimage?.loadimagefromcache(urlString: profileImage)
        }
        
        
        
        return cell
        
    }
    
    
    
    var nameofpatient: User?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = nameofpatient?.name as? String
        tableView.delegate = self
        tableView.dataSource = self
        self.datatopass = ""
        tableView.register(CutomizedTableViewCell.self, forCellReuseIdentifier: cellId)
        //tableView.register(UICell.self, forCellReuseIdentifier: cellId)
        
        getpatients()

        print(nameofpatient?.name)
        self.uniquevalues.append((nameofpatient?.name)!)

        // Do any additional setup after loading the view.
    }
    
    @objc func menuButtonTapped(sender: UIBarButtonItem) {

        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "CameraViewController") as! CameraViewController
        detailVC.valuetolabel = nameofpatient?.name
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(menuButtonTapped(sender:)))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.init(red: 6/255, green: 155/255, blue: 158/255, alpha: 1.0)
        
    
    }
    
    func getpatients(){
            Database.database().reference().child("users").queryOrdered(byChild: "tag").observe(.childAdded, with: { (snapshot) in
                let namevalue = snapshot.value as? [String: AnyObject]
                if self.uniquevalues.contains(namevalue?["name"] as! String){
                    if let dictionaryy = snapshot.value as? [String: AnyObject]{
                    let user = User()
                    self.user.append(user)
                    self.user = Array(Set(self.user))
                    //print(dictionaryy["name"])
                    user.name = dictionaryy["name"] as! String
                    user.tag = dictionaryy["tag"] as! String
                    user.url = dictionaryy["url"] as! String
                    user.uniquevalue = dictionaryy["id"] as! String
                        print(user.name, user.tag, user.url, user.uniquevalue)
                    print("now next")
                    print(user)
                }
                    //self.uniquevalues.append(namevalue?["name"] as! String)
                    
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
