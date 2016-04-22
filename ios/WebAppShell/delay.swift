//
//  delay.swift
//  WebAppShell
//
//  Created by Gabriele Petronella on 4/22/16.
//  Copyright © 2016 buildo. All rights reserved.
//

import Foundation

func delay(delay:Double, closure:()->()) {
  dispatch_after(
    dispatch_time(
      DISPATCH_TIME_NOW,
      Int64(delay * Double(NSEC_PER_SEC))
    ),
    dispatch_get_main_queue(), closure)
}