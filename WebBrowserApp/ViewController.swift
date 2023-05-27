//
//  ViewController.swift
//  WebBrowserApp
//
//  Created by Lee Sangoroh on 10/05/2023.
//

import UIKit
import WebKit

//Extends UIViewController, adheres to protocols of WKNavigationDelegate
class ViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        //instance of WKWebView class
        webView = WKWebView()
        //Delegation - a programming pattern
        // A delegate is one thing acting in place of another, effectively answering questions and responding to actions on its behalf
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //type URL - swift's way of storing location of files
        let url = URL(string:"https://github.com/leonardsangoroh")!
        //Wraps urls in a url request
        webView.load(URLRequest(url:url))
        //Enables a property of the webview - BackForward Navigation
        webView.allowsBackForwardNavigationGestures = true
    }


}

