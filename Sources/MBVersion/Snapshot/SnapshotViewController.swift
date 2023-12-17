//
//  SnapshotViewController.swift
//  
//
//  Created by Furkan MobBook on 16.12.2023.
//

import UIKit

final public class SnapshotViewController: UIViewController {

    @IBOutlet var viewControllerNameLabel: UILabel!
    @IBOutlet var viewControllerSnapshotImageView: UIImageView!

    var viewControllerName: String?
    var snapshot: UIImage?

    public override func viewDidLoad() {
        super.viewDidLoad()
        viewControllerNameLabel.text = viewControllerName
        viewControllerSnapshotImageView.image = snapshot
    }
}
