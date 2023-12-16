//
//  File.swift
//  
//
//  Created by Furkan MobBook on 15.12.2023.
//

import Foundation
import UIKit

public class VersionDetailsViewController: UIViewController {

    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var viewControllerName: UILabel!
    @IBOutlet var viewControllerSnapshot: UIImageView!
    @IBOutlet var currentPageView: UIView!
    @IBOutlet var networkLogsView: UIView!

    public var snapShot: UIImage?

    public override func viewDidLoad() {
        super.viewDidLoad()
        setSegmentedControl()
        setCurrentPageSegment()
    }

    private func setSegmentedControl() {
        let segmentedControlSelector = #selector(segmentedControlValueChanged(_:))

        segmentedControl.layer.borderWidth = 1
        segmentedControl.layer.borderColor = UIColor.white.cgColor
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: segmentedControlSelector, for: .valueChanged)
    }

    private func setCurrentPageSegment() {
        guard let snapShot else { return }
        currentPageView.isHidden = false
        networkLogsView.isHidden = true
        viewControllerName.text = String(
            describing: type(of: UIApplication.shared.keyWindow?.rootViewController ?? UIViewController())
        )
        viewControllerSnapshot.image = snapShot
        viewControllerSnapshot.contentMode = .scaleAspectFit
    }

    private func setNetworkLogs() {
        currentPageView.isHidden = true
        networkLogsView.isHidden = false

        networkLogsView.backgroundColor = UIColor.systemGreen
    }

    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        switch selectedIndex {
        case 0:
            setCurrentPageSegment()
        case 1:
            setNetworkLogs()
            // will be implemented
        default:
            break
        }
    }
}


