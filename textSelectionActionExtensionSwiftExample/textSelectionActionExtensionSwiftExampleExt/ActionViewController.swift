//
//  ActionViewController.swift
//  textSelectionActionExtensionSwiftExampleExt
//
//  Created by Jaz Garewal on 8/7/14.
//  Copyright (c) 2014 Skinny Bones Productions. All rights reserved.
//

import UIKit
//import MobileCoreServices

class ActionViewController: UIViewController, UIWebViewDelegate {


    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if UIPasteboard.generalPasteboard().string {
            loadFromPasteBoard()
        }
        self.webView.delegate = self;
    }

    func loadFromPasteBoard() {
        weak var weakSearchTextField = self.searchTextField
        dispatch_async(dispatch_get_main_queue()) {
            if let searchTextField = weakSearchTextField {
                searchTextField.text = UIPasteboard.generalPasteboard().string
            }
        }
    }

    @IBAction func searchButtonTapped(sender: AnyObject) {
        let searchTextString = self.searchTextField.text.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        let urlString = "http://wikipedia.org/search-redirect.php?family=wikipedia&search=\(searchTextString)&language=en"
        loadRequest(urlString)
    }
    
    func loadRequest(urlString:String) {
        var url = NSURL.URLWithString(urlString)
        dispatch_async(dispatch_get_main_queue()) {
            self.webView.loadRequest(NSURLRequest(URL: url))
        }
        
    }

    @IBAction func done() {
        self.extensionContext.completeRequestReturningItems(nil, completionHandler: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
