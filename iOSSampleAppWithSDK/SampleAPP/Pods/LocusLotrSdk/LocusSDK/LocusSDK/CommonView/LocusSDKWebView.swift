import Foundation
import SafariServices
import UIKit
import WebKit

class LocusSDKWebView: WKWebView, WKNavigationDelegate, SFSafariViewControllerDelegate {

    let web = WKWebView()
    let progressSpinner = UIActivityIndicatorView(style: .gray)

    func loadURL(url: String) {
        let myRequest = URLRequest(url: URL(string: url)!)
        web.load(myRequest)
    }

    func getWebView(withFrame frame: CGRect, andURL url: String) -> WKWebView {
        web.frame = frame
        web.autoresizingMask = .flexibleWidth
        progressSpinner.frame = CGRect(x: web.center.x, y: web.center.y, width: 30, height: 30)
        web.addSubview(progressSpinner)
        loadURL(url: url.trimmingCharacters(in: .whitespacesAndNewlines))
        return web
    }

    func loadWebView(withURL url: String, viewController: UIViewController? = UIApplication.topViewController()) {
        func openSafariVC(withURL urlToOpen: URL) {
            let safariVC = SFSafariViewController(url: urlToOpen)
            safariVC.delegate = self
            if #available(iOS 10.0, *) {
                safariVC.preferredBarTintColor = LocusSDK.tintColour
                safariVC.preferredControlTintColor = UIColor.white
            }
            viewController?.present(safariVC, animated: true) {}
        }

        if let urlToOpen = URL(string: (url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)?.trimmingCharacters(in: .whitespacesAndNewlines))!), let fullURL = URL(string: "\(TAXY_SERVER_URL)" + "/" + urlToOpen.absoluteString) {
            if UIApplication.shared.canOpenURL(urlToOpen) {
                openSafariVC(withURL: urlToOpen)
                return
            }
            if UIApplication.shared.canOpenURL(fullURL) {
                openSafariVC(withURL: fullURL)
                return
            }
        }
    }

    func webView(_: WKWebView, didStartProvisionalNavigation _: WKNavigation) {
        progressSpinner.startAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    func webView(_: WKWebView, didFinish _: WKNavigation) {
        progressSpinner.stopAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }

    func webView(webView _: WKWebView, navigation _: WKNavigation, withError _: NSError) {
        progressSpinner.stopAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }

    func safariViewController(_ controller: SFSafariViewController, initialLoadDidRedirectTo URL: URL) {
        if URL.absoluteString == "https://locus.sh/" {
            controller.dismiss(animated: true) {}
        }
    }

    func webView(_: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        let authMethod = challenge.protectionSpace.authenticationMethod

        if authMethod == NSURLAuthenticationMethodDefault || authMethod == NSURLAuthenticationMethodHTTPBasic || authMethod == NSURLAuthenticationMethodHTTPDigest {
            let credential = URLCredential(user: "", password: "", persistence: URLCredential.Persistence.none)
            completionHandler(URLSession.AuthChallengeDisposition.useCredential, credential)
        } else if authMethod == NSURLAuthenticationMethodServerTrust {
            completionHandler(URLSession.AuthChallengeDisposition.performDefaultHandling, nil)
        } else {
            completionHandler(URLSession.AuthChallengeDisposition.cancelAuthenticationChallenge, nil)
        }
    }
}
