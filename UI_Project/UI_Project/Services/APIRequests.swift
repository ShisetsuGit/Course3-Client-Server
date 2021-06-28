//
//  APIRequests.swift
//  UI_Project
//
//  Created by Shisetsu on 24.06.2021.
//

import Foundation
import Alamofire

final class APIRequest {
    
    let baseUrl = "https://api.vk.com/method"
    let token = VKSession.currentSession.token
    let cliendId = VKSession.currentSession.userId
    let version = "5.138"
    
    //    MARK: - GET USER FRIENDS
    func getFriends(completion: @escaping([User])->()) {
        
        let method = "/friends.get"
        let parameters: Parameters = [
            "user_id": cliendId,
            "order": "name",
            "fields": "sex,bdate,city,photo_200_orig,online,status",
            "access_token": token,
            "v": version]
        let url = baseUrl + method
        print("URL")
        print(url)
        print(parameters)
        
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            
            guard let data = response.data else { return }
            print("DATA")
            print(data)
            let friendsResponse = try? JSONDecoder().decode(Friends.self, from: data)
            guard let friends = friendsResponse?.response.items else { return }
            
            DispatchQueue.main.async {
                completion(friends)
            }
        }
    }
    
    //    MARK: - GET USER PHOTOS
    func getPhoto(userID: String, completion: @escaping([Photos])->()) {
        
        let method = "/photos.getAll"
        let parameters: Parameters = [
            "owner_id": userID,
            "photo_sizes": 0,
            "extended": 1,
            "no_service_albums": 1,
            "access_token": token,
            "v": version]
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            
            guard let data = response.data else { return }
            let friendsPhotoResponse = try? JSONDecoder().decode(FriendsPhoto.self, from: data).response
            
            //            Ниже - это какой-то дичайший костылище,
            //            но я что-то не вкурил как из JSON дергать
            //            элементы по конкретному условию :( Читал гугл - долго думал (с)
            //            "ЭТО" внизу забирает поледний элемент массива полученный из альбомов
            //            Так как последний элемент это картинка в хорошем качестве
            //            если этого не делать, оно шпарит вообще все экземпляры одной картинки, включая lowres.
            
            var array = [Albums]()
            array = friendsPhotoResponse!.items
            var sizesArray = [Photos]()
            var i = array.makeIterator()
            while var photos = i.next() {
                let p = photos.sizes.removeLast()
                sizesArray.append(p)
            }
            DispatchQueue.main.async {
                completion(sizesArray)
            }
        }
    }
    
    //    MARK: - GET USER GROUPS
    func getGroups(completion: @escaping([GroupsList])->()) {
        
        let method = "/groups.get"
        let parameters: Parameters = [
            "user_id": cliendId,
            "order": "name",
            "extended": 1,
            "access_token": token,
            "v": version]
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            
            guard let data = response.data else { return }
            let groupsResponse = try? JSONDecoder().decode(Groups.self, from: data)
            guard let groups = groupsResponse?.response.items else { return }
            DispatchQueue.main.async {
                completion(groups)
            }
        }
    }
    
    //    MARK: - GET SEARSCHED GROUPS
    func searchGroups(searchText: String, completion: @escaping([GroupsList])->()) {
        
        let method = "/groups.search"
        let parameters: Parameters = [
            "user_id": cliendId,
            "q": searchText,
            "access_token": token,
            "v": version]
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            
            guard let data = response.data else { return }
            let searchResponse = try? JSONDecoder().decode(Groups.self, from: data)
            guard let searchedGroups = searchResponse?.response.items else { return }
            DispatchQueue.main.async {
                completion(searchedGroups)
            }
        }
    }
}
