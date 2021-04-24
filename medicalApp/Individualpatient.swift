//
//  Individualpatient.swift
//  medicalApp
//
//  Created by Vyom Unadkat on 3/4/21.
//

import UIKit
import Firebase

import InstaZoom


class Individualpatient: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate{
    
    
    
    var datatopass: String?
    @IBOutlet weak var searchbaritem: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    let cellId = "cellId"
    var uniquevalues = [String]()
    
    var optionstoselect = [String]()

    var user = [User]()
    var filteresuser = [User]()
    
    
    let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = nameofpatient?.name as? String
        tableView.delegate = self
        tableView.dataSource = self
        self.datatopass = ""
        tableView.register(CutomizedTableViewCell.self, forCellReuseIdentifier: cellId)
        
        optionstoselect.append("All")
        getpatients()

        
        

        print(nameofpatient?.name)
        self.uniquevalues.append((nameofpatient?.name)!)
    }
    
    func initSearchController(){
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        definesPresentationContext = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        print("I am initialising the options")
        print(self.optionstoselect)
        searchController.searchBar.scopeButtonTitles = self.optionstoselect
        searchController.searchBar.delegate = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive{
            return filteresuser.count
        }
        return user.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        print(user[indexPath.row].url)
        
        performSegue(withIdentifier: "detailimage", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? IndividualImage{
            if searchController.isActive{
                destination.myStringValue = filteresuser[tableView.indexPathForSelectedRow!.row]
            }
            else{
                destination.myStringValue = user[tableView.indexPathForSelectedRow!.row]
            }
        }
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scopeButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        let searchText = searchBar.text!
        
        filterForSearchTextAndScopeButton(searchText: searchText, scopeButton: scopeButton)
    }
    
    func filterForSearchTextAndScopeButton(searchText: String, scopeButton: String = "All") {
        
        filteresuser = [User]()
        
        for patient in user{
            if patient.tag!.lowercased().contains(scopeButton.lowercased()) || patient.tag!.lowercased().contains(searchText.lowercased()){
                filteresuser.append(patient)
            }
        }
        
        if scopeButton == "All" && searchText == ""{
            filteresuser = user
        }
        
        tableView.reloadData()
    }
    
   
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CutomizedTableViewCell
        
        if searchController.isActive{
            cell.mytag?.text = filteresuser[indexPath.row].tag?.capitalized
            cell.selectionStyle = .none
            cell.myimage.isPinchable = true
            var usertopass = filteresuser[indexPath.row].url
            self.datatopass = usertopass
            
            if let profileImage = filteresuser[indexPath.row].url{
                cell.myimage?.loadimagefromcache(urlString: profileImage)
            }
        }
        else{
            cell.mytag?.text = user[indexPath.row].tag?.capitalized
            cell.selectionStyle = .none
            cell.myimage.isPinchable = true
            var usertopass = user[indexPath.row].url
            self.datatopass = usertopass
            
            if let profileImage = user[indexPath.row].url{
                cell.myimage?.loadimagefromcache(urlString: profileImage)
            }
        }
        
        return cell
        
    }
    
    var nameofpatient: User?
    
    
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
                    user.name = dictionaryy["name"] as! String
                    user.tag = dictionaryy["tag"] as! String
                    user.url = dictionaryy["url"] as! String
                    user.uniquevalue = dictionaryy["id"] as! String
                    user.age = dictionaryy["age"] as! String
                    user.sex = dictionaryy["sex"] as! String
                    user.race = dictionaryy["race"] as! String
                    user.date_injury = dictionaryy["date_injury"] as! String
                    user.date_admission = dictionaryy["date_admission"] as! String
                    user.mechanism = dictionaryy["mechanism"] as! String
                    user.postburndate = dictionaryy["post_burn_date"] as! String
                    user.TBSA = dictionaryy["TBSA"] as! String
                    user.surfacearea = dictionaryy["surfacearea"] as! String
                    user.thickness = dictionaryy["thickness"] as! String
                    self.optionstoselect.append(user.tag!)
                }
                    
                    DispatchQueue.global(qos: .background).async {

                        // Background Thread

                        DispatchQueue.main.async {
                            // Run UI Updates
                            self.initSearchController()
                            self.tableView.reloadData()
                        }
                    }
                }
            }, withCancel: nil)
        initSearchController()
        }


}
