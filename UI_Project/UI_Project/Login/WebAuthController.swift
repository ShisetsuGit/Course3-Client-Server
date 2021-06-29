//
//  WebViewController.swift
//  UI_Project
//
//  Created by  Shisetsu on 18.06.2021.
//

import UIKit
import WebKit
import Alamofire
import SwiftKeychainWrapper

class WebAuthController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView! {
        didSet{
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let token = KeychainWrapper.standard.string(forKey: "AuthToken"), let userID = KeychainWrapper.standard.string(forKey: "ID") {
            
            VKSession.currentSession.token = token
            VKSession.currentSession.userId = userID

            showMainScreen()
            
            return
        }
        
        VKAuth()
    }
    
    func VKAuth() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7767306"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "friends,photos,groups"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "state", value: "Your_TOKEN_is_MINE!!!"),
//            URLQueryItem(name: "revoke", value: "1") // принудительный запрос прав на доступ, даже если уже выданы. Для отладки, что страница загружается.
        ]
        let request = URLRequest(url: urlComponents.url!)
        webView.load(request)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
        if let token = params["access_token"],
           let userID = params["user_id"] {
            print("TOKEN = ", token as Any)
            KeychainWrapper.standard.set(token, forKey: "AuthToken")
            VKSession.currentSession.token = token
            KeychainWrapper.standard.set(userID, forKey: "ID")
            VKSession.currentSession.userId = userID
            showMainScreen()
        }
        
        decisionHandler(.cancel)
    }
    
    func showMainScreen() {
        //        MARK: - Usual work segue to main Friend List VC
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "mainScreenSegue", sender: nil)
        }
        //        MARK: - Seque to service VC for analyze data
//        DispatchQueue.main.async {
//            self.performSegue(withIdentifier: "ServiceSegue", sender: nil)
//        }
    }
}
