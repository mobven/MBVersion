//
//  UIViewController+Extension.swift
//  MBVersion
//
//  Created by Rashid Ramazanov on 22.01.2021.
//

import Foundation
import UIKit

/// `UIViewController` extensions for method swizzlings.
/// Used only in circumstances where store application will not swizzle this methods.
/// eg. viewWillAppear swizzling is called only for "VERSION_LABEL_ENABLED" builds.
extension UIViewController {
    
    /// Swizzles UIViewController.viewWillAppear(_:) to call `VersionConfig.shared?.show()`
    internal class func swizzleWillAppear() {
        /*
         Swizzling should always be done in a dispatch_once,
         since GCD’s dispatch_once provides both atomicity (i.e. all or nothing)
         and guarantee that code will be executed exactly once, even across different threads.
         */
        DispatchQueue.once {
            let originalSelector = #selector(UIViewController.viewWillAppear(_:))
            let swizzledSelector = #selector(UIViewController.dcViewWillAppear(_:))
            
            guard let originalMethod = class_getInstanceMethod(self, originalSelector),
                  let swizzledMethod = class_getInstanceMethod(self, swizzledSelector) else { return }
            
            let didAddMethod = class_addMethod(self, originalSelector,
                                               method_getImplementation(swizzledMethod),
                                               method_getTypeEncoding(swizzledMethod))
            
            if didAddMethod {
                class_replaceMethod(self, swizzledSelector,
                                    method_getImplementation(originalMethod),
                                    method_getTypeEncoding(originalMethod))
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod)
            }
        }
    }
    
    // MARK: - Method Swizzling
    @objc func dcViewWillAppear(_ animated: Bool) {
        // Will call the original viewWillAppear(:) method which is at this point swizzled
        self.dcViewWillAppear(animated)
        MBVersion.shared.show()
    }
    
}
