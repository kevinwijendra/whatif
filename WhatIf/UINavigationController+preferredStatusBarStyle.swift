//
//  UINavigationController+preferredStatusBarStyle.swift
//  WhatIf
//
//  Created by Kevin Wijendra on 12/5/17.
//  Copyright © 2017 Kevin Wijendra. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    open override var preferredStatusBarStyle: UIStatusBarStyle{
        return topViewController?.preferredStatusBarStyle ?? .default
    }
    
}
