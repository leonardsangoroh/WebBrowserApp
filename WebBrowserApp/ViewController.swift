//
//  ViewController.swift
//  WebBrowserApp
//
//  Created by Lee Sangoroh on 10/05/2023.
//

import UIKit
import WebKit

//Extends UIViewController, adheres or conforms to protocols of WKNavigationDelegate
class ViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        //instance of WKWebView class
        webView = WKWebView()
        //Delegation - a programming pattern
        // A delegate is one thing acting in place of another, effectively answering questions and responding to actions on its behalf
        webView.navigationDelegate = self
        //make the view the view for the view controller
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
//
        //type URL - swift's way of storing location of files
        let url = URL(string:"https://github.com/leonardsangoroh")!
        //Wraps urls in a url request
        webView.load(URLRequest(url:url))
        //Enables a property of the webview - BackForward Navigation
        //Swipe left or right to move backwards or forwards
        webView.allowsBackForwardNavigationGestures = true
    }


}

