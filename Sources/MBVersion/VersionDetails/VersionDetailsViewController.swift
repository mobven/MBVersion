//
//  File.swift
//  
//
//  Created by Furkan MobBook on 15.12.2023.
//

import Foundation
import UIKit

enum SegmentType: Int, CaseIterable {
    case snapshot = 0
    case networkLogs
}

public class VersionDetailsViewController: UIViewController {

    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var containerView: UIView!

    public var snapshotViewController: SnapshotViewController?
    public var networkLogsViewController: NetworkLogsViewController?

    public var snapShot: UIImage?

    public override func viewDidLoad() {
        super.viewDidLoad()
        setSegmentedControl()
        displayViewController(forSegment: 0)
    }

    private func setSegmentedControl() {
        let segmentedControlSelector = #selector(segmentedControlValueChanged(_:))

        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: segmentedControlSelector, for: .valueChanged)
    }

    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        displayViewController(forSegment: selectedIndex)
    }

    private func displayViewController(forSegment segment: Int) {
        let segmentType = SegmentType(rawValue: segment)
        switch segmentType {
        case .snapshot:
            configureSnapshotViewController()
        case .networkLogs:
            configureNetworkLogsViewController()
        default:
            break
        }
    }

    private func configureSnapshotViewController() {
        guard let snapshotViewController else {
            let storyboard = UIStoryboard(name: "Snapshot", bundle: .module)

            snapshotViewController = storyboard.instantiateViewController(
                withIdentifier: "SnapshotViewController"
            ) as? SnapshotViewController

            snapshotViewController?.viewControllerName = String(
                describing: type(
                    of: UIApplication.shared.keyWindow?.rootViewController ?? UIViewController()
                )
            )
            snapshotViewController?.snapshot = snapShot

            showContentController(content: snapshotViewController)
            return
        }

        showContentController(content: snapshotViewController)
    }

    private func configureNetworkLogsViewController() {
        guard let networkLogsViewController else {
            let storyboard = UIStoryboard(name: "NetworkLogs", bundle: .module)

            networkLogsViewController = storyboard.instantiateViewController(
                withIdentifier: "NetworkLogsViewController"
            ) as? NetworkLogsViewController
            networkLogsViewController?.networkLogs = "Work In Progress"

            showContentController(content: networkLogsViewController)
            return
        }

        showContentController(content: networkLogsViewController)
    }

    private func showContentController(content: UIViewController?) {
        guard let content else { return }

        if content == snapshotViewController {
            networkLogsViewController?.removeFromParent()
            networkLogsViewController = nil
        } else {
            snapshotViewController?.removeFromParent()
            snapshotViewController = nil
        }

        for subview in containerView.subviews {
            subview.removeFromSuperview()
        }

        addChild(content)
        content.view.frame = containerView.bounds
        containerView.addSubview(content.view)
        content.didMove(toParent: self)
    }
}

