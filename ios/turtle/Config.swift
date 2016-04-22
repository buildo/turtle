//
//  Config.swift
//  WebAppShell
//
//  Created by Gabriele Petronella on 4/22/16.
//  Copyright © 2016 buildo. All rights reserved.
//

class Config {
  // App config
  static let baseURL = "http://www.oxway.co"
  
  // Push notifications config
  static let tokenRegistrationURL = "http://foo.bar.com/token" // TODO
  static let notificationURLKey = "url"
  static let deviceTokenKey = "registrationid"
  
  // EVURLCache config
  static let enableCaching = true
  #if DEBUG
    static let cacheLogging = true
  #else
    static let cacheLogging = false
  #endif
  
  static let cacheMaxFileSize = 26 // 2^26 = 64MB
  static let cacheMaxCacheSize = 30 // 2^30 = 1GB
  
}
