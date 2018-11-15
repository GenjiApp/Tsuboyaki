//
//  ViewController.swift
//  Tsuboyaki
//
//  Created by Genji on 2018/11/15.
//  Copyright © 2018 Genji App. All rights reserved.
//

import Cocoa
import WebKit

class ViewController: NSViewController, WKNavigationDelegate {

  @IBOutlet weak var webView: WKWebView!

  let twitterURL = URL(string: "https://mobile.twitter.com/home")!

  override func viewDidLoad() {
    super.viewDidLoad()

    self.webView.navigationDelegate = self
    self.webView.customUserAgent = "Mozilla/5.0 (iPad; CPU iPhone OS 11_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/11.0 Mobile/15E148 Safari/604.1"

    if let urlForContentRule = Bundle.main.url(forResource: "ContentRule", withExtension: "json") {
      do {
        let stringForContentRule = try String(contentsOf: urlForContentRule)
        WKContentRuleListStore.default()?.compileContentRuleList(forIdentifier: "ContentRule", encodedContentRuleList: stringForContentRule, completionHandler: { (contentRuleList, error) in
          if let contentRuleList = contentRuleList {
            self.webView.configuration.userContentController.add(contentRuleList)
          }
        })
      }
      catch {

      }
    }

    let urlRequest = URLRequest(url: twitterURL)
    self.webView.load(urlRequest)
  }

  override var representedObject: Any? {
    didSet {
    // Update the view, if already loaded.
    }
  }

  // MARK: - WKNavigatoinDelegate
  func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    if let url = navigationAction.request.url, url.host != twitterURL.host {
      NSWorkspace.shared.open(url)
      decisionHandler(.cancel)
    }
    else {
      decisionHandler(.allow)
    }
  }

}

