//
//  ShakeDetectorApplication.swift
//  turtle
//
//  Created by Gabriele Petronella on 4/22/16.
//  Copyright © 2016 buildo. All rights reserved.
//

import UIKit

class ShakeDetectorApplication: UIApplication {
  
  override func sendEvent(event: UIEvent) {
    if event.subtype == .MotionShake {
      NSNotificationCenter.defaultCenter().postNotificationName("DeviceDidShake", object: nil)
    } else {
      super.sendEvent(event)
    }
  }
  
}