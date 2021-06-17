//
//  FriendsTableController.swift
//  UI_Project
//
//  Created by Shisetsu on 11.12.2020.
//

import UIKit

class FriendsTableController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var friendsData = [
        UserInfo(fio: "Петр Иванов", userID: "GHAVR6R", name: "Петр", onlineStatus: "Online", userAvatar: "Petya.png", surname: "Иванов", age: 25, birthDate: "13.01.1995", city: "Москва", bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque auctor, velit vel condimentum euismod, arcu magna fermentum augue, ac cursus lectus elit et nunc. Praesent vitae varius risus.", photoGallery: ["Petya.png", "1-1", "1-2", "1-3", "1-4"]),
        UserInfo(fio: "Василий Сидоров", userID: "NNBAGBB", name: "Василий",  onlineStatus: "Offline", userAvatar: "Vasya.png", surname: "Сидоров", age: 32, birthDate: "19.02.1988", city: "Воронеж", bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque auctor, velit vel condimentum euismod, arcu magna fermentum augue, ac cursus lectus elit et nunc. Praesent vitae varius risus.", photoGallery: ["Vasya.png", "1-1", "1-2", "1-3", "1-4"]),
        UserInfo(fio: "Федор Горюнов", userID: "BBSJLOP", name: "Федор", onlineStatus: "Offline", userAvatar: "Fedor.png", surname: "Горюнов", age:40, birthDate: "10.07.1980", city: "Санкт-Петербург", bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque auctor, velit vel condimentum euismod, arcu magna fermentum augue, ac cursus lectus elit et nunc. Praesent vitae varius risus.", photoGallery: ["Fedor.png", "3-1", "3-2", "3-3", "3-4"]),
        UserInfo(fio: "Владимир Сергеев",userID: "VW5PFLM", name: "Владимир", onlineStatus: "Online", userAvatar: "Vova.png", surname: "Сегреев", age:18, birthDate: "13.03.2002", city: "Нижний Новгород", bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque auctor, velit vel condimentum euismod, arcu magna fermentum augue, ac cursus lectus elit et nunc. Praesent vitae varius risus.", photoGallery: ["Vova.png", "4-1", "4-2", "4-3", "4-4"]),
        UserInfo(fio: "Виктор Бунин", userID: "MNDBJ76", name: "Виктор", onlineStatus: "Online", userAvatar: "Viktor.png", surname: "Бунин", age:28, birthDate: "18.05.1992", city: "Псков", bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque auctor, velit vel condimentum euismod, arcu magna fermentum augue, ac cursus lectus elit et nunc. Praesent vitae varius risus.", photoGallery: ["Viktor.png", "5-1", "5-2", "5-3", "5-4"]),
        UserInfo(fio: "Виктория Авдошина", userID: "KJKJKD1", name: "Виктория",  onlineStatus: "Offline", userAvatar: "Vika.png", surname: "Авдошина", age:20, birthDate: "1.02.2000", city: "Казань", bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque auctor, velit vel condimentum euismod, arcu magna fermentum augue, ac cursus lectus elit et nunc. Praesent vitae varius risus.", photoGallery: ["Vika.png", "6-1", "6-2", "6-3", "6-4"]),
        UserInfo(fio: "Анна Иванова", userID: "KJKJKD1", name: "Анна", onlineStatus: "Online", userAvatar: "Anna.png", surname: "Иванова", age:25, birthDate: "3.09.1995", city: "Пенза", bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque auctor, velit vel condimentum euismod, arcu magna fermentum augue, ac cursus lectus elit et nunc. Praesent vitae varius risus.", photoGallery: ["Anna.png", "7-1.png", "7-2.png", "7-3.png", "7-4.png"]),
        UserInfo(fio: "Дарья Петрова", userID: "KJKJKD1", name: "Дарья", onlineStatus: "Offline", userAvatar: "Dasha.png", surname: "Петрова", age:21, birthDate: "3.04.1999", city: "Ярославль", bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque auctor, velit vel condimentum euismod, arcu magna fermentum augue, ac cursus lectus elit et nunc. Praesent vitae varius risus.", photoGallery: ["Dasha.png", "8-1", "8-2", "8-3", "8-4"])]
    
    var sections: [String: [UserInfo]] = [:]
    var keys: [String] = []
    var filteredData = [UserInfo]()
    var searchBarStatus = false
    var imageName = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 60
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        
        friendsData.forEach { friend in
            let firstLetter = String(friend.fio.first!)
            if sections[firstLetter] != nil {
                sections[firstLetter]!.append(friend)
            } else {
                sections[firstLetter] = [friend]
            }
        }
        keys = Array(sections.keys).sorted(by: <)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = friendsData.filter ({ (friend: UserInfo) -> Bool in
            return friend.fio.lowercased().contains(searchText.lowercased())
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
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let returnedView = UIView(frame: CGRect(x: 30, y: 20, width: 42, height: 42))
        returnedView.backgroundColor = UIColor.lightGray
        returnedView.alpha = 0.5
        
        let label = UILabel(frame: CGRect(x: 4, y: 4, width: 160, height: 20))
        label.textColor = .black
        if searchBarStatus {
            label.text = "Результат поиска"
        } else {
            label.text = keys[section]
        }
        returnedView.addSubview(label)
        
        return returnedView
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBarStatus {
            return filteredData.count
        }
        let key = keys[section]
        let count = sections[key]!.count
        return count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if searchBarStatus {
            return 1
        }
        return sections.count
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if searchBarStatus {
            return ["#"]
        }
        return keys
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return keys[section]
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
        
        let key = keys[indexPath.section]
        
        if searchBarStatus {
            let searchedFriends = filteredData[indexPath.row]
            cell.friendLabel.text = searchedFriends.fio
            imageName = UIImage(named: searchedFriends.userAvatar)!
            cell.friendPhoto.image = UIImage(named: searchedFriends.userAvatar)
        } else {
            let friendsClass = sections[key]![indexPath.row]
            cell.friendLabel.text = friendsClass.fio
            imageName = UIImage(named: friendsClass.userAvatar)!
            cell.friendPhoto.image = UIImage(named: friendsClass.userAvatar)
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
            let key = keys[indexPath.section]
            if searchBarStatus {
                let friendsClass = filteredData[indexPath.row]
                vc.userPhoto = UIImage(named: friendsClass.userAvatar)
                vc.userName = friendsClass.name
                vc.userSurname = friendsClass.surname
                vc.userCity = friendsClass.city
                vc.userBirth = friendsClass.birthDate
                vc.userAge = "\(friendsClass.age)"
                vc.userStatus = friendsClass.onlineStatus
                vc.userBio = friendsClass.bio
            } else {
                let friendsClass = sections[key]![indexPath.row]
                vc.userPhoto = UIImage(named: friendsClass.userAvatar)
                vc.userName = friendsClass.name
                vc.userSurname = friendsClass.surname
                vc.userCity = friendsClass.city
                vc.userBirth = friendsClass.birthDate
                vc.userAge = "\(friendsClass.age)"
                vc.userStatus = friendsClass.onlineStatus
                vc.userBio = friendsClass.bio
            }
        }
    }
}
