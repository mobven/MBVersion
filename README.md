# MBVersion

MBVersion adds customizable tag to your application about the app version.

[![SwiftPM compatible](https://img.shields.io/badge/SwiftPM-compatible-brightgreen.svg)](https://swift.org/package-manager/)
[![codebeat badge](https://codebeat.co/badges/d84c4136-a8e6-4ef4-85a0-0d3690646043)](https://codebeat.co/projects/github-com-mobven-mbversion-main)

![MBVersion](https://github.com/mobven/MBVersion/blob/main/docs/scr_1.png)

## Requirements
* iOS 10.0+
* Xcode 11+
* Swift 5.2+

## Installation
MBVersion is distributed with [Swift Package Manager](https://swift.org/package-manager/) which is the only official distribution tool by Apple. You can add MBVersion to your project from Xcode's `File > Swift Packages > Add Package Dependency` menu with its github URL:
```
https://github.com/mobven/MBVersion.git
```

## Usage
MBVersion can be initialized and customized by accessing `MBVersion.shared`.

```swift
import UIKit
import MBVersion

struct VersionConfig {
    
    static func show() {
        // We're using Xcode configuration files to decide to show app label.
        // Implementation is up to app's logic.
        guard Bundle.main.boolForKey("VERSION_LABEL_ENABLED") else { return }
        MBVersion.shared?.show()
        MBVersion.shared?.versionLabel.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        MBVersion.shared?.versionLabel.textColor = UIColor.white
        MBVersion.shared?.versionLabel.font = UIFont.boldSystemFont(ofNewSize: 16)
        MBVersion.shared?.versionLabel.sizeToFit()
    }
    
}
```

---
Developed with 🖤 at [Mobven](https://mobven.com/)
