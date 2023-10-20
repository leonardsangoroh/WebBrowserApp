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
    var progressView: UIProgressView!
    var websites = ["apple.com","github.com/leonardsangoroh"]
    
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        ///Create UIProgressView instance
        progressView = UIProgressView(progressViewStyle: .default)
        
        progressView.sizeToFit()
        /// Create new UIBarButtonItem using the customView parameter
        /// customView parameter is used to wrap the UIProgressView into UIBarButtonItem
        let progressButton = UIBarButtonItem(customView: progressView)
        
        ///Toolbar
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action:#selector(webView.reload))
        
        toolbarItems = [progressButton, spacer ,refresh]
        navigationController?.isToolbarHidden = false
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        //type URL - swift's way of storing location of files
        let url = URL(string:"https://" + websites[0])!
        //Wraps urls in a url request
        webView.load(URLRequest(url:url))
        //Enables a property of the webview - BackForward Navigation
        //Swipe left or right to move backwards or forwards
        webView.allowsBackForwardNavigationGestures = true
    }
    
    @objc func openTapped() {
        ///nil for the message since the alert does not need one
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        for website in websites {
            ///Handler method - used to respond to an event or user action in your application
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }

       
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        //Important for iPad as it tells the position or where to anchor it on the iPad
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction) {
        //force unwrap has been implemented twice
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url:url))
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    ///Decides whether to allow or cancel a navigation
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction:WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy)->Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host {
            for website in websites {
                if host.contains(website) {
                    decisionHandler(.allow)
                    return
                }
            }
        }
        decisionHandler(.cancel)
    }
}

