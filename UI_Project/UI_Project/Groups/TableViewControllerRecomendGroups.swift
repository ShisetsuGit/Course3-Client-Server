//
//  TableViewControllerRecomendGroups.swift
//  UI_Project
//
//  Created by  Shisetsu on 11.12.2020.
//

import UIKit

class TableViewControllerRecomendGroups: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var friendGroups = [
        GroupInfo(name: "Книжный", photo: "Books.png", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
        GroupInfo(name: "Бары", photo: "Pub.png", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
        GroupInfo(name: "Музыка", photo: "Music.png", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
        GroupInfo(name: "Сериалы", photo: "Serials.png", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
        GroupInfo(name: "Кино-новинки", photo: "Cinema.png", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
        GroupInfo(name: "Новости твоего города", photo: "News.jpg", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
        GroupInfo(name: "Игры", photo: "Games.jpg", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
    ]
    
    var userReccomendGroups = [String]()
    var recGroupPics = [String]()
    var sendData = [GroupInfo]()
    var filteredData = [GroupInfo]()
    var searchBarStatus = false
    var imageGroup = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        sendData = friendGroups
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = friendGroups.filter ({ (friend: GroupInfo) -> Bool in
            return friend.name.lowercased().contains(searchText.lowercased())
        })
        searchBar.showsCancelButton = true
        searchBarStatus = true
        tableView.reloadData()
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
            return filteredData.count
        } else {
        return friendGroups.count
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recomendedGroups", for: indexPath) as! TableViewCellRecomendedGroups
        
        if searchBarStatus {
            let searchedGroups = filteredData[indexPath.row]
            cell.recomendedGroupsLabel.text = searchedGroups.name
            var sendData = filteredData[indexPath.row]
            sendData.name = searchedGroups.name
            imageGroup = UIImage(named: searchedGroups.photo)!
            sendData.photo = searchedGroups.photo
            cell.groupDescription.text = searchedGroups.description
            sendData.description = searchedGroups.description
            cell.recomendedGroupsPhoto.image = imageGroup
            cell.recomendedGroupsPhoto.layer.cornerRadius = cell.recomendedGroupsPhoto.frame.width / 2
            //tableView.reloadData()
        } else {
            let nonSearchedGroups = friendGroups[indexPath.row]
            cell.recomendedGroupsLabel.text = nonSearchedGroups.name
            var sendData = friendGroups[indexPath.row]
            sendData.name = nonSearchedGroups.name
            imageGroup = UIImage(named: nonSearchedGroups.photo)!
            sendData.photo = nonSearchedGroups.photo
            cell.groupDescription.text = nonSearchedGroups.description
            sendData.description = nonSearchedGroups.description
            cell.recomendedGroupsPhoto.image = imageGroup
            cell.recomendedGroupsPhoto.layer.cornerRadius = cell.recomendedGroupsPhoto.frame.width / 2
            //tableView.reloadData()
        }
        
        return cell
    }
}
