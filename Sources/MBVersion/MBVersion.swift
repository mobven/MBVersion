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
    
    /// `MBVersion` singleton instance.
    public static let shared: MBVersion = MBVersion()
    
    lazy var versionLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 20,
                             width: UIScreen.main.bounds.width, height: 20)
        label.backgroundColor = UIColor(red: .zero, green: 115/255, blue: 239/255, alpha: 1)
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()

    private init() {
        UIViewController.swizzleWillAppear()
        UIApplication.shared.keyWindow?.addSubview(versionLabel)
        setVersionLabelText()
    }

    private func setVersionLabelText() {
        guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
              let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String else { return }
        if #available(iOS 11.0, *) {
            if (UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0) > 0 {
                versionLabel.text = "         v.\(version)(\(build))"
                versionLabel.textAlignment = .left
            } else {
                versionLabel.text = " v.\(version)(\(build))"
                versionLabel.textAlignment = .center
            }
        } else {
            versionLabel.text = " v.\(version)(\(build))"
            versionLabel.textAlignment = .center
        }
    }

    /// Brings already created version label to the front of the current window.
    public func show() {
        UIApplication.shared.keyWindow?.bringSubviewToFront(self.versionLabel)
        UIApplication.shared.keyWindow?.frame = CGRect(
            origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 20)
        )
    }

}
