//
//  SnapshotViewController.swift
//  MBVersion
//
//  Created by Furkan MobBook on 16.12.2023.
//

import UIKit

public final class SnapshotViewController: UIViewController {
    @IBOutlet var viewControllerNameLabel: UILabel!
    @IBOutlet var viewControllerSnapshotImageView: UIImageView!

    var viewControllerName: String?
    var snapshot: UIImage?

    override public func viewDidLoad() {
        super.viewDidLoad()
        viewControllerNameLabel.text = viewControllerName
        viewControllerSnapshotImageView.image = snapshot
    }
}
