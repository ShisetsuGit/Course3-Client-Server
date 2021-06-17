//
//  NewsTableController.swift
//  UI_Project
//
//  Created by  Shisetsu on 22.12.2020.
//

import UIKit

class NewsTableController: UITableViewController {
    
    var newsData = [
        NewsInfo(name: "News № 1", photo: "NewsPic.png", description: "Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Pellentesque habitant morbi tristique senectus et."),
        NewsInfo(name: "News № 2", photo: "NewsPic.png", description: "Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Pellentesque habitant morbi tristique senectus et."),
        NewsInfo(name: "News № 3", photo: "NewsPic.png", description: "Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Pellentesque habitant morbi tristique senectus et."),
        NewsInfo(name: "News № 4", photo: "NewsPic.png", description: "Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Pellentesque habitant morbi tristique senectus et."),
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "News", for: indexPath)  as! NewsViewCell

        let news = newsData[indexPath.row]
        cell.newsLabel.text = news.name
        
        let imageGroup = news.photo
        cell.photo.image = UIImage(named: imageGroup)

        cell.newsDescription.text = news.description

        return cell
    }

}
