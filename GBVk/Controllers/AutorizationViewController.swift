//
//  AutorizationViewController.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 23.01.2020.
//  Copyright © 2020 Даниил Мурыгин. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

class AutorizationViewController: UIViewController {
    
    let privateKay = "7292248"
    
    
    var webView: WKWebView!
    var vkAPI = VKApi()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webViewConfig = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webViewConfig)
        webView.navigationDelegate = self
        
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "oauth.vk.com"
        urlComponent.path = "/authorize"
        urlComponent.queryItems = [URLQueryItem(name: "client_id", value: privateKay),
                                   URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
                                   URLQueryItem(name: "display", value: "mobile"),
                                   URLQueryItem(name: "scope", value: "262150"),
                                   URLQueryItem(name: "response_type", value: "token"),
                                   URLQueryItem(name: "v", value: "5.103")]

        let request = URLRequest(url: urlComponent.url!)
        webView.load(request)
        
        view = webView
        
    }

}

class VKApi {
    
    let vkURL = "https://api.vk.com/method/"
    
    func getFriendList(token: String){
        let requestURL = vkURL + "friends.get"
        
        let params = ["v": "5.103",
                      "access_token":token,
                      "order":"name",
                      "fields": "city,domain"]
        
        Alamofire.request(requestURL,
                          method: .post,
                          parameters: params).responseString(completionHandler: {(response) in
                            print(response.value)
                          })
    }
    
    func getPhoto(ownerId: String) {
        let requestURL = vkURL + "photos.getAll"
        
        let params = ["v": "5.103",
                      "access_token":Session.instance.token,
                      "owner_id": ownerId,
                      "extended": "0",
                      "photo_sizes":"0",
                      "no_service_albums":"0"]
        
        Alamofire.request(requestURL,
                          method: .post,
                          parameters: params).responseString(completionHandler: {(response) in
                            print(response.value)
                          })
    }
    
    func getUserGroup(ownerId: String){
        let requestURL = vkURL + "groups.get"
               
               let params = ["v": "5.103",
                             "access_token":Session.instance.token,
                             "owner_id": ownerId,
                             "extended": "1"]
               
               Alamofire.request(requestURL,
                                 method: .post,
                                 parameters: params).responseString(completionHandler: {(response) in
                                   print(response.value)
                                 })
    }
    
    func getSearchGroup(searchString: String){
        let requestURL = vkURL + "groups.search"
               
               let params = ["v": "5.103",
                             "access_token":Session.instance.token,
                             "q": searchString,"sort": "0"]
               
               Alamofire.request(requestURL,
                                 method: .post,
                                 parameters: params).responseString(completionHandler: {(response) in
                                   print(response.value)
                                 })
    }
}

extension AutorizationViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url,
            url.path == "/blank.html",
            let fragment = url.fragment else{
                decisionHandler(.allow)
                return
        }
        
        let params = fragment.components(separatedBy: "&")
            .map{ $0.components(separatedBy: "=")}
            .reduce([String:String]()) {
                value, params in
                var dict = value
                let kay = params[0]
                let value = params[1]
                dict[kay] = value
                return dict
        }
        print(params)
        Session.instance.token = params["access_token"]!
        Session.instance.userId = params["user_id"]!
        vkAPI.getFriendList(token: Session.instance.token)
        vkAPI.getPhoto(ownerId: Session.instance.userId)
        vkAPI.getUserGroup(ownerId: Session.instance.userId)
        vkAPI.getSearchGroup(searchString: "Music")
        decisionHandler(.cancel)
    }
}
