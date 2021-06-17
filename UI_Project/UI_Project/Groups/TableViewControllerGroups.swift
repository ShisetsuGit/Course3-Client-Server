//
//  TableViewController_Groups.swift
//  UI_Project
//
//  Created by  Shisetsu on 11.12.2020.
//

import UIKit

class TableViewControllerGroups: UITableViewController {
    
    
    var userGroups = [String] ()
    var groupPics = [String] ()
    var groupInfo = [String] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        cell.userGroupsLabel.text = groups
        let groupDescription  = groupInfo[indexPath.row]
        cell.groupDescription.text = groupDescription.description
        let imageGroup = "\(self.groupPics[indexPath.row])"
        cell.userGroupsPhoto.image = UIImage(named: imageGroup)
        cell.userGroupsPhoto.layer.cornerRadius = cell.userGroupsPhoto.frame.width / 2
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            userGroups.remove(at: indexPath.row)
            groupPics.remove(at: indexPath.row)
            groupInfo.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func showSerachScreen() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SearchScreen") as! TableViewControllerRecomendGroups
        self.navigationController!.pushViewController(nextViewController, animated: true)
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        if segue.identifier == "addGroup" {
            guard let RecomendedGroups = segue.source as? TableViewControllerRecomendGroups else { return }
            
            if let indexPath = RecomendedGroups.tableView.indexPathForSelectedRow {
                //let groups = RecomendedGroups.userReccomendGroups[indexPath.row]
                let groups = RecomendedGroups.sendData[indexPath.row]
                let image = RecomendedGroups.sendData[indexPath.row]
                let descr = RecomendedGroups.sendData[indexPath.row]
                
                if !userGroups.contains(groups.name) || !groupPics.contains(image.photo) ||  !groupInfo.contains(descr.description){
                    userGroups.append(groups.name)
                    groupPics.append(image.photo)
                    groupInfo.append(descr.description)
                    tableView.reloadData()
                }
            }
        }
    }
}
