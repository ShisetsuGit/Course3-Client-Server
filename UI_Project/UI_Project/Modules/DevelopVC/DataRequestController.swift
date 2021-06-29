//
//  DataRequestController.swift
//  UI_Project
//
//  Created by  Shisetsu on 18.06.2021.
//

import UIKit

class DataRequestController: UIViewController {
    
    @IBOutlet var userIDText: UITextField!
    
    @IBOutlet var tokenText: UITextField!
    
    let ApiRequest = APIRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("PRINTED TOKEN")
        print(VKSession.currentSession.token)
        print("PRINTED ID")
        print(VKSession.currentSession.userId)
        tokenText.text = VKSession.currentSession.token
        userIDText.text = VKSession.currentSession.userId
    }
    
    func createRequestUrl(method: String, parameter: String, parameterData: String, get: String, who: String) {
        let configuration = URLSessionConfiguration.default
        let session =  URLSession(configuration: configuration)

        let url = URL(string: "https://api.vk.com/method/\(method).\(get)?\(who)_id=\(VKSession.currentSession.userId)&\(parameter)=\(parameterData)&access_token=\(VKSession.currentSession.token)&v=5.131")

        let task = session.dataTask(with: url!) { (data, response, error) in
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            print(json!)
        }
        task.resume()
    }
    
    @IBAction func getFriends(_ sender: Any) {
//        createRequestUrl(method: "friends", parameter: "fields", parameterData: "nickname,sex,bdate,city,photo_100,online", get: "get", who: "user")
//        ApiRequest.getFriends { users in
//                print(users)
//        }

    }
    
    @IBAction func getPhoto(_ sender: Any) {
//        createRequestUrl(method: "photos", parameter: "extended", parameterData: "1", get: "getAll", who: "owner")
//        ApiRequest.getPhoto(userID: VKSession.currentSession.userId) { albums in
//            print(albums)
//        }
    }

    @IBAction func getGroups(_ sender: Any) {
//        createRequestUrl(method: "groups", parameter: "extended", parameterData: "1", get: "get", who: "user")
//        ApiRequest.getGroups { groups in
//            print(groups)
//        }
    }

    //Поиск групп по слову "breaker"
    @IBAction func searchGroup(_ sender: Any) {
//        createRequestUrl(method: "groups", parameter: "q", parameterData: "breaker", get: "search", who: "user")
        ApiRequest.searchGroups(searchText: "test") { searchedGroups in
            print(searchedGroups)
        }
    }
}
