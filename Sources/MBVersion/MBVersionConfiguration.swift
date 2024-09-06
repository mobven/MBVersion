//
//  MBVersionConfiguration.swift
//  MBVersion
//
//  Created by Eser Kucuker on 5.09.2024.
//

import Foundation
import UIKit

/// The `MBVersionConfigurable` protocol defines a set of properties that can be used to configure the appearance of a
/// MBVersion.
public protocol MBVersionConfigurable{
    var textFont: UIFont { get set }
    var textColor: UIColor { get set }
    var bacgroundColor: UIColor { get set }
}

/// `MBVersionConfig` is a struct that implements the `MBVersionConfigurable` protocol, providing default values for
/// MBVersion configuration properties.
public struct MBVersionConfig: MBVersionConfigurable {
    ///  The font used for the version  text.
    public var textFont: UIFont
    /// The color of the version text.
    public var textColor: UIColor
    /// The background color of the version label.
    public var bacgroundColor: UIColor

    /// Initializes `MBVersion` with specified configurations.
    /// - Parameters:
    ///   - textFont: The font used for the version  text.
    ///   - textColor: The color of the version text.
    ///   - bacgroundColor: The background color of the version label
    public init(
        textFont: UIFont = UIFont.boldSystemFont(ofSize: 13),
        textColor: UIColor = UIColor.white,
        bacgroundColor: UIColor = UIColor(red: .zero, green: 115 / 255, blue: 239 / 255, alpha: 1)
    ) {
        self.textFont = textFont
        self.textColor = textColor
        self.bacgroundColor = bacgroundColor
    }
}
