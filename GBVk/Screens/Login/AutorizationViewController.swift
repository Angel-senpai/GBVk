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
    let vkAPI = vkApi()
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
                                       "scope": "270342",
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
                loadingViews.isHidden = true
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
                loadingViews.isHidden = false
                return dict
        }
        decisionHandler(.cancel)
        
        Session.instance.token = params["access_token"]!
        Session.instance.userId = params["user_id"]!
        print(Session.instance.token)
        print(Session.instance.userId)
        
 
        
        
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "TabBar") as! UITabBarController
        self.navigationController?.pushViewController(viewController, animated: false)
        
    }
}
