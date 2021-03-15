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
    
    func getpatients(){
            Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
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
                    print(user.name, user.tag, user.url)
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
