//
//  VersionConfig.swift
//  MBVersion
//
//  Created by Rasid Ramazanov on 29.01.2020.
//  Copyright © 2020 Mobven. All rights reserved.
//

import UIKit

/// Singleton class with helper functions to show version label in the application.
public final class MBVersion {
    
    private static var instance: MBVersion?
    /// `VersionConfig` singleton instance.
    public class var shared: MBVersion? {
        if instance == nil {
            instance = MBVersion()
        }
        return instance
    }
    
    public var versionLabel: UILabel
    
    private init?() {
        guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
              let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String else { return nil }
        UIViewController.swizzleDidAppear()
        versionLabel = UILabel()
        versionLabel.frame = CGRect(x: 0, y: 40, width: 250, height: 30)
        versionLabel.text = " v.\(version)(\(build)) "
        versionLabel.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        versionLabel.textColor = UIColor.white
        versionLabel.font = UIFont.boldSystemFont(ofSize: 16)
        versionLabel.sizeToFit()
        UIApplication.shared.delegate?.window??.addSubview(versionLabel)
    }
    
    /// Brings already created version label to the front of the current window.
    public func show() {
        UIApplication.shared.delegate?.window??.bringSubviewToFront(self.versionLabel)
    }
    
}
