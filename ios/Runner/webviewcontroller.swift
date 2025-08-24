//
//  webviewcontroller.swift
//  Runner
//
//  Created by Parameshwaran on 03/08/23.
//

import Flutter
import UIKit
import SafariServices

class WebViewController: NSObject, FlutterPlugin, SFSafariViewControllerDelegate {
    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "com.demo.webview_channel", binaryMessenger: registrar.messenger())
        let instance = WebViewController()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    private var safariViewController: SFSafariViewController?
    private var flutterResult: FlutterResult?

    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "openWebView" {
            guard let arguments = call.arguments as? [String: Any],
                  let urlString = arguments["url"] as? String,
                  let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? urlString) else {
                result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid URL", details: nil))
                return
            }
            openWebView(url: url, flutterResult: result)
        } else if call.method == "closeWebView" {
            closeWebView(result)
        } else {
            result(FlutterMethodNotImplemented)
        }
    }

    private func openWebView(url: URL, flutterResult: @escaping FlutterResult) {
        DispatchQueue.main.async {
            self.flutterResult = flutterResult

            self.safariViewController = SFSafariViewController(url: url)
            self.safariViewController?.delegate = self

            if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
                rootViewController.present(self.safariViewController!, animated: true, completion: nil)
            }
        }
    }

    private func closeWebView(_ result: @escaping FlutterResult) {
        DispatchQueue.main.async {
            if let rootViewController = UIApplication.shared.keyWindow?.rootViewController,
               let safariViewController = self.safariViewController {
                rootViewController.dismiss(animated: true) {
                    self.safariViewController = nil
                    result(nil)
                }
            } else {
                result(FlutterError(code: "WEBVIEW_NOT_FOUND", message: "WebView not found or already closed.", details: nil))
            }
        }
    }

    // SFSafariViewControllerDelegate method to detect initial URL changes
    func safariViewController(_ controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {
        // Handle initial load completion if needed
    }
}
