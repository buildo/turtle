//
//  AppDelegate.swift
//  WebAppShell
//
//  Created by Gabriele Petronella on 4/22/16.
//  Copyright © 2016 buildo. All rights reserved.
//

import UIKit
import EVURLCache
import Alamofire

class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    #if arch(i386) || arch(x86_64)
      let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
      NSLog("Document Path: %@", documentsPath)
    #endif
    
    EVURLCache.LOGGING = Config.cacheLogging
    EVURLCache.MAX_FILE_SIZE = Config.cacheMaxFileSize
    EVURLCache.MAX_CACHE_SIZE = Config.cacheMaxCacheSize
    EVURLCache.activate()
    
    // wait for window.rootViewController to instantiate
    delay(0) {
      self.navigateToURL(Config.baseURL)
    }
    
    // Register the supported interaction types.
    let settings = UIUserNotificationSettings(forTypes: [.Badge, .Alert, .Sound], categories: nil)
    application.registerUserNotificationSettings(settings)
    application.registerForRemoteNotifications()
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AppDelegate.deleteCache), name: "DeviceDidShake", object: nil)
    
    return true
  }
  
  func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
    let token = deviceToken.description
  
    let params = [
      Config.deviceTokenKey: token
    ]
    
    request(.POST, Config.tokenRegistrationURL, parameters: params, encoding: .JSON, headers: nil)
  }
  
  func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
    if let urlString = userInfo[Config.notificationURLKey] as? String {
      navigateToURL(urlString)
    }
  }
  
  func deleteCache() {
    let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
    let cachePath = documentsPath.stringByAppendingString("/Cache/")
    do {
      try NSFileManager.defaultManager().removeItemAtPath(cachePath)
      refreshURL()
    } catch {
      NSLog("Couldn't delete directory at path %@", cachePath)
      refreshURL()
    }
  }
  
  private func navigateToURL(urlString: String) {
    if let webVC = self.window?.rootViewController as? WebViewController,
      let url = NSURL(string: urlString) {
      NSLog("visiting %@", url)
      let request = NSMutableURLRequest(URL: url)
      webVC.webView.loadRequest(request)
    }
  }
  
  private func refreshURL() {
    if let webVC = self.window?.rootViewController as? WebViewController,
      let request = webVC.webView.request,
      let url = request.URL {
        NSLog("refreshing %@", url)
        webVC.webView.loadRequest(request)
    }
  }

}

