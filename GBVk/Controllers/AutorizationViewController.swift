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
    let vkApi = VKApi()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webViewConfig = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webViewConfig)
        webView.navigationDelegate = self
        
        
        let dataRequest = Alamofire.request("https://oauth.vk.com/authorize",
                          method: .post,
                          parameters: ["client_id": privateKay,
                                       "redirect_uri": "https://oauth.vk.com/blank.html",
                                       "display": "mobile",
                                       "scope": "262150",
                                       "response_type":"token",
                                       "v":"5.103"])
        
        guard let url = dataRequest.request else {return}
        webView.load(url)
        
        view = webView
        
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
        Session.instance.token = params["access_token"]!
        Session.instance.userId = params["user_id"]!
        print(Session.instance.token)
        print(Session.instance.userId)

        
        //print(vkApi.getPhoto(by: Session.instance.token,ownerId: Session.instance.userId))
        vkApi.getFriendList(by: Session.instance.token, hundler: {
            print($0)
        })
        vkApi.getProfilePhoto(by: Session.instance.token, ownerId: Session.instance.userId){
            print($0)
        }
        
        vkApi.getPhoto(by: Session.instance.token, ownerId: Session.instance.userId) {
            switch $0{
            case .success(let photoes):
                photoes.forEach{
                    $0.photo.forEach{
                        if $0.type == UserPhoto.Photo.PhotoType.p{
                             print($0)
                         }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
        vkApi.getUserGroup(by: Session.instance.token,ownerId: Session.instance.userId){
            switch $0{
            case .success(let group):
                print(group)
            case .failure(let error):
                print(error)
            }
        }
        vkApi.getSearchGroup(by: Session.instance.token,searchString: "Music"){
            switch $0{
            case .success(let group):
                print(group)
            case .failure(let error):
                print(error)
            }
        }
        decisionHandler(.cancel)
        
        
        
    }
}
