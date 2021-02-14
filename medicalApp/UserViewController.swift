//
//  UserViewController.swift
//  medicalApp
//
//  Created by Vyom Unadkat on 2/14/21.
//

import UIKit
import Firebase

class UserViewController: UITableViewController {
    
    
    let cellId = "cellId"
    var user = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UICell.self, forCellReuseIdentifier: cellId)
        //tableView.rowHeight = UITableView.automaticDimension
        //tableView.estimatedRowHeight = 150
        getpatients()
    }
    
    func getpatients(){
            Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
                
                if let dictionaryy = snapshot.value as? [String: AnyObject]{
                    let user = User()
                    self.user.append(user)
                    //print(dictionaryy["name"])
                    user.name = dictionaryy["name"] as! String
                    user.tag = dictionaryy["tag"] as! String
                    user.url = dictionaryy["url"] as! String
                    print(user.name, user.tag, user.url)
                    
                    
                    DispatchQueue.global(qos: .background).async {

                        // Background Thread

                        DispatchQueue.main.async {
                            // Run UI Updates
                            self.tableView.reloadData()
                        }
                    }
                    
                }
                
                
                //print(snapshot)
                
            }, withCancel: nil)
        }

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.tabBarController?.navigationItem.hidesBackButton = true
//    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return user.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            //let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UICell
            let users = user[indexPath.row]
            cell.textLabel?.text = users.name
            cell.detailTextLabel?.text = users.tag
        cell.imageView?.contentMode = .scaleAspectFill
        cell.layoutSubviews()
        
        if let profileImage = users.url{
            
            cell.profileImageView.loadimagefromcache(urlString: profileImage)
//            let url = NSURL(string: profileImage)
//            URLSession.shared.dataTask(with: url! as URL, completionHandler:{(data, response, error) in
//
//                if error != nil{
//                    print(error)
//                    return
//                }
//
//                DispatchQueue.global(qos: .background).async {
//                    DispatchQueue.main.async {
//                        cell.profileImageView.image = UIImage(data: data!)
//                        //cell.imageView?.image = UIImage(data: data!)
//                    }
//                }
//
//            }).resume()
        }
        
        
        
            return cell
        }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.title = "Patients"
        
        
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        self.tabBarController?.navigationItem.rightBarButtonItem?.tintColor = UIColor.init(red: 6/255, green: 155/255, blue: 158/255, alpha: 1.0)
        self.tabBarController?.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: nil)
        self.tabBarController?.navigationItem.leftBarButtonItem?.tintColor = UIColor.init(red: 6/255, green: 155/255, blue: 158/255, alpha: 1.0)
    }
  

}

class UICell: UITableViewCell{

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        
        textLabel?.frame = CGRect(x: 80, y: textLabel!.frame.origin.y+175, width: textLabel!.frame.width, height: textLabel!.frame.height)
        
        detailTextLabel?.frame = CGRect(x: 80, y: detailTextLabel!.frame.origin.y+175, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
    }
    
    
    var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var messageView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle,  reuseIdentifier: String?){
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        addSubview(messageView)
        
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        profileImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 350).isActive = true
        profileImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        //profileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 30).isActive = true
        
        
        messageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        messageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        messageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
