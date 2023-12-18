//
//  MBVersion.swift
//  MBVersion
//
//  Created by Rasid Ramazanov on 29.01.2020.
//  Copyright © 2020 Mobven. All rights reserved.
//

import UIKit

/// Singleton class with helper functions to show version label in the application.
public final class MBVersion {
    /// `MBVersion` singleton instance.
    public static let shared = MBVersion()

    private init() {
        DispatchQueue.main.async {
            UIViewController.swizzleWillAppear()
            UIApplication.shared.keyWindow?.addSubview(self.versionLabel)
            self.setVersionLabelText()
            self.versionLabel.addGestureRecognizer(self.addGesture())
        }
    }

    private lazy var versionLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(
            x: 0,
            y: UIScreen.main.bounds.height - 20,
            width: UIScreen.main.bounds.width,
            height: 20
        )
        label.backgroundColor = UIColor(red: .zero, green: 115 / 255, blue: 239 / 255, alpha: 1)
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.isUserInteractionEnabled = true
        return label
    }()

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
        UIApplication.shared.keyWindow?.bringSubviewToFront(versionLabel)
        UIApplication.shared.keyWindow?.frame = CGRect(
            origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 20)
        )
    }
}

extension MBVersion {
    private func addGesture() -> UITapGestureRecognizer {
        let versionLabelGestureSelector = #selector(onTapVersionLabel(_:))

        let gesture = UITapGestureRecognizer(target: self, action: versionLabelGestureSelector)
        return gesture
    }

    @objc func onTapVersionLabel(_ sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "VersionDetails", bundle: .module)
        guard let controller = storyboard.instantiateViewController(
            withIdentifier: "VersionDetailsViewController"
        ) as? VersionDetailsViewController else { return }
        controller.snapShot = takeScreenshot()
        UIApplication.shared.keyWindow?.rootViewController?.present(controller, animated: true)
    }
}

extension MBVersion {
    func takeScreenshot() -> UIImage? {
        guard let window = UIApplication.shared.windows.first else { return nil }

        let renderer = UIGraphicsImageRenderer(size: window.bounds.size)
        let snapshot = renderer.image { _ in
            window.drawHierarchy(in: window.bounds, afterScreenUpdates: true)
        }

        return snapshot
    }
}
