//
//  FriendsTableController.swift
//  UI_Project
//
//  Created by Shisetsu on 11.12.2020.
//

import UIKit
import RealmSwift
import Kingfisher

class FriendsTableController: UITableViewController {
    
    let friendsRequest = APIRequest()
    let DB = UsersDatabaseService()
    
    var friendsData: [UserModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 60
        friendsRequest.getFriends()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.friendsData = self.DB.read()
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let returnedView = UIView(frame: CGRect(x: 30, y: 20, width: 42, height: 42))
        returnedView.backgroundColor = UIColor.lightGray
        returnedView.alpha = 0.5
        
        let label = UILabel(frame: CGRect(x: 4, y: 4, width: 160, height: 20))
        label.textColor = .black
        label.text = "Список друзей"
        returnedView.addSubview(label)
        
        return returnedView
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friendsData.count
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animate(
            withDuration: 0.25,
            animations: {
                cell.layer.transform = CATransform3DMakeScale(1,1,1)
            })
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        guard let viewAvatar = tableView.cellForRow(at: indexPath) as? TableViewCell else {return}
        
        let spring = CASpringAnimation(keyPath: "transform.scale")
        spring.duration = 0.5
        spring.damping = 0.1
        spring.initialVelocity = 0.1
        spring.fromValue = 1
        spring.toValue = 0.9
        
        let animation = CAAnimationGroup()
        animation.duration = 1
        animation.animations = [spring]
        
        viewAvatar.headerView.layer.add(animation, forKey: "spring")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userFriends", for: indexPath) as! TableViewCell
        
        let friends = friendsData[indexPath.row]
        cell.friendLabel.text = friends.firstName! + " " + friends.lastName!
        
        imageCache(url: friends.photo50!) { image in
            cell.friendPhoto.image = image
        }
        
        cell.friendPhoto.clipsToBounds = true
        cell.friendPhoto.layer.cornerRadius = cell.friendPhoto.frame.height / 2
        cell.headerView.addSubview(cell.friendPhoto)
        
        cell.addSubview(cell.headerView)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ProfileController
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let friends = friendsData[indexPath.row]
            vc.userID = friends.id
            vc.userPhoto = friends.photo100!
            vc.userName = friends.firstName
            vc.userSurname = friends.lastName
            vc.userCity = friends.city
            vc.userBirth = friends.bdate
            if friends.online == 1 {
                vc.userStatus = "Online"
            } else if friends.online == 0 {
                vc.userStatus = "Offline"
            }
        }
    }
}
