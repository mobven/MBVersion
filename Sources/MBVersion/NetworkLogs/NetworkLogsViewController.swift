//
//  NetworkLogsViewController.swift
//  MBVersion
//
//  Created by Furkan MobBook on 16.12.2023.
//

import UIKit

public final class NetworkLogsViewController: UIViewController {
    @IBOutlet var networkLogsLabel: UILabel!

    var networkLogs: String?

    override public func viewDidLoad() {
        super.viewDidLoad()
        networkLogsLabel.text = networkLogs
    }
}
