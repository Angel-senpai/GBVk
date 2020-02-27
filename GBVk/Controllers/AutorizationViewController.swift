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
    

    let privateKay = "7305836"
    
    
    var webView: WKWebView!
    let vkApi = VKApi()
    var loadingViews: LoadingView!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadingViews = LoadingView(frame: CGRect(x: 0,
                                                 y: 0,
                                                 width: view.frame.width * 0.25,
                                                 height: view.frame.height * 0.125))
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
        loadingViews.center.x = view.frame.width / 2
        loadingViews.center.y = view.frame.height / 2
        view = webView
        webView.addSubview(loadingViews)


        
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
        decisionHandler(.cancel)
        
        Session.instance.token = params["access_token"]!
        Session.instance.userId = params["user_id"]!
        print(Session.instance.token)
        print(Session.instance.userId)
        
        let queque = DispatchQueue.global(qos: .background)
        queque.async {
            self.vkApi.getFriendList(by: Session.instance.token, hundler: {
                switch $0{
                case .success(let users):
                    let userRep = UsersRepositoryRealm()
                    users.forEach{ user in
                        self.vkApi.getProfilePhoto(by: Session.instance.token, ownerId: Session.instance.userId){ response in
                            switch response{
                            case .success(let strURL):
                                let temp = URL(string: strURL)
                                userRep.addUser(id: user.id,
                                                firstName: user.firstName,
                                                lastName: user.lastName,
                                                city: user.cityName,
                                                photoURL: temp)
                            case .failure:
                                break;
                            }
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            })
            /*
            self.vkApi.getProfilePhoto(by: Session.instance.token, ownerId: Session.instance.userId){ _ in
               // print($0)
            }
            
            self.vkApi.getPhoto(by: Session.instance.token, ownerId: Session.instance.userId) {
                switch $0{
                case .success(let photoes):
                    photoes.forEach{
                        $0.photo.forEach{
                            if $0.type == .p{
                                 print($0)
                             }
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }*/
            self.vkApi.getUserGroup(by: Session.instance.token,ownerId: Session.instance.userId){
                switch $0{
                case .success(let group):
                    print("success")
                    break
                case .failure(let error):
                   print(error)
                }
            }
            /*
            self.vkApi.getSearchGroup(by: Session.instance.token,searchString: "Music"){
                switch $0{
                case .success(let group):
                    print("success")
                   break
                case .failure(let error):
                    print(error)
                }
            }*/
        }

        //print(vkApi.getPhoto(by: Session.instance.token,ownerId: Session.instance.userId))
    
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "TabBar") as! UITabBarController
        self.navigationController?.pushViewController(viewController, animated: false)
        
    }
}
