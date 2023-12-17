//
//  NetworkLogsViewController.swift
//  
//
//  Created by Furkan MobBook on 16.12.2023.
//

import UIKit

final public class NetworkLogsViewController: UIViewController {

    @IBOutlet var networkLogsLabel: UILabel!

    var networkLogs: String?

    public override func viewDidLoad() {
        super.viewDidLoad()
        networkLogsLabel.text = networkLogs
    }
}
