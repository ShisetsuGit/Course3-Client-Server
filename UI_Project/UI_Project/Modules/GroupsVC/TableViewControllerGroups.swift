//
//  TableViewController_Groups.swift
//  UI_Project
//
//  Created by  Shisetsu on 11.12.2020.
//

import UIKit

class TableViewControllerGroups: UITableViewController {
    
    var userGroups = [GroupsModel]()
    let groupsRequest = APIRequest()
    var userReccomendGroups = [GroupsModel]()
    var imageName = UIImage()
    let DB = GroupsDatabaseService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupsRequest.getGroups()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.userGroups = self.DB.read()
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userGroups.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userGroups", for: indexPath) as! TableViewCellGroups
        
        let groups = userGroups[indexPath.row]
        cell.userGroupsLabel.text = groups.name
        
        imageCache(url: groups.photo50!) { image in
            cell.userGroupsPhoto.image = image
        }
        cell.userGroupsPhoto.layer.cornerRadius = cell.userGroupsPhoto.frame.width / 2
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let item = userGroups[indexPath.row]
//            print("GROUP TO DELETE")
//            print(item)
//            DB.delete(groups: item)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            tableView.reloadData()
//        }
//    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            DB.delete(groups: userGroups[indexPath.row])
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                self.tableView.reloadData()
//            }
//        }
//    }
    
    @IBAction func showSerachScreen() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SearchScreen") as! TableViewControllerRecomendGroups
        self.navigationController!.pushViewController(nextViewController, animated: true)
    }
    
//    @IBAction func addGroup(segue: UIStoryboardSegue) {
//        if segue.identifier == "addGroup" {
//            guard let RecomendedGroups = segue.source as? TableViewControllerRecomendGroups else { return }
//
//
//            if let indexPath = RecomendedGroups.tableView.indexPathForSelectedRow {
//                let searchedGroups = RecomendedGroups.sendData[indexPath.row]
//                if !userGroups.contains(searchedGroups) {
//                    DispatchQueue.main.async() {
//                        self.DB.add(groups: [searchedGroups])
//                    }
//                }
//            }
//        }
//    }
}
