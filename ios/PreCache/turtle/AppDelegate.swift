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

@UIApplicationMain
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
    
    return true
  }
  
  func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
    let token = NSString(data: deviceToken, encoding: NSUTF8StringEncoding)!
  
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
  
  private func navigateToURL(urlString: String) {
    if let webVC = self.window?.rootViewController as? WebViewController,
      let url = NSURL(string: urlString) {
      webVC.webView.loadRequest(NSURLRequest(URL: url))
    }
  }


}
