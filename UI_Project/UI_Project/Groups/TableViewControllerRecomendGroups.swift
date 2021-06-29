//
//  TableViewControllerRecomendGroups.swift
//  UI_Project
//
//  Created by  Shisetsu on 11.12.2020.
//

import UIKit

class TableViewControllerRecomendGroups: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let searchRequest = APIRequest()
    var userReccomendGroups = [String]()
    var recGroupPics = [String]()
    var searchedGroups: [GroupsList] = []
    var searchBarStatus = false
    var imageGroup = UIImage()
    var imageName = UIImage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.placeholder = "Search"
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchRequest.searchGroups(searchText: searchText) { searchedGroups in
            self.searchedGroups = searchedGroups
            DispatchQueue.main.async() {
                self.tableView.reloadData()
            }
        }
        searchBar.showsCancelButton = true
        searchBarStatus = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.placeholder = "Search"
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
        searchBarStatus = false
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBarStatus {
            return searchedGroups.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recomendedGroups", for: indexPath) as! TableViewCellRecomendedGroups
        
        let searchedGroups = searchedGroups[indexPath.row]
        cell.recomendedGroupsLabel.text = searchedGroups.name
        let imageUrlString = searchedGroups.photo200
        let imageUrl = URL(string: imageUrlString)!
        let imageData = try! Data(contentsOf: imageUrl)
        let imageName = UIImage(data: imageData)!
        imageGroup = imageName
        cell.recomendedGroupsPhoto.image = imageGroup
        cell.recomendedGroupsPhoto.layer.cornerRadius = cell.recomendedGroupsPhoto.frame.width / 2
        
        return cell
    }
}
