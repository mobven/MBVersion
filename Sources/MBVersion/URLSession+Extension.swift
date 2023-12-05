//
//  URLSession+Extension.swift
//  MBVersion
//
//  Created by Rashid Ramazanov on 5.12.2023.
//

import Foundation

extension URLSession {
    /// Swizzles URLSession.dataTask(with:completionHandler:) with call of `MBVersion.shared.show()`
    class func swizzleDataTask() {
        /*
         Swizzling should always be done in a dispatch_once,
         since GCD’s dispatch_once provides both atomicity (i.e. all or nothing)
         and guarantee that code will be executed exactly once, even across different threads.
         */
        DispatchQueue.once {
            let originalSelector = #selector(
                URLSession.dataTask(with:completionHandler:) as (URLSession) -> (
                    URLRequest, @escaping @Sendable (Data?, URLResponse?, Error?) -> Void
                ) -> URLSessionDataTask
            )
            let swizzledSelector = #selector(
                URLSession.dcDataTask(with:completionHandler:) as (URLSession) -> (
                    URLRequest, @escaping @Sendable (Data?, URLResponse?, Error?) -> Void
                ) -> URLSessionDataTask
            )

            guard let originalMethod = class_getInstanceMethod(self, originalSelector),
                  let swizzledMethod = class_getInstanceMethod(self, swizzledSelector) else { return }

            let didAddMethod = class_addMethod(
                self,
                originalSelector,
                method_getImplementation(swizzledMethod),
                method_getTypeEncoding(swizzledMethod)
            )

            if didAddMethod {
                class_replaceMethod(
                    self,
                    swizzledSelector,
                    method_getImplementation(originalMethod),
                    method_getTypeEncoding(originalMethod)
                )
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod)
            }
        }
    }

    // MARK: - Swizzled data task

    @objc func dcDataTask(
        with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {
        // Will call the original dcDataTask(:) method which is at this point swizzled
        dcDataTask(with: request, completionHandler: completionHandler)
    }
}
