//
//  NetworkLoggerDetailViewController.swift
//  MBVersion
//
//  Created by Semih Ozsoy on 1.11.2024.
//

import UIKit

enum NetwortLoggerSections {
    case overview
    case request
    case response
}

final class NetworkLoggerDetailViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    typealias Sections = NetwortLoggerSections
    var tableArray: [[Sections]] = [[.overview]]
    
    public var viewModel: [NetworkLoggerDetailItems] = [
        .init(rightText: "URL", leftText: "https://mobiltest.ziraatpay.com.tr/mCampaignChances"),
        .init(rightText: "Method", leftText: "POST"),
        .init(rightText: "Status", leftText: "Success"),
        .init(rightText: "Response", leftText: ""),
        .init(rightText: "SSL", leftText: "Yes"),
        .init(rightText: "Request Time", leftText: "1.11.2024"),
        .init(rightText: "Response Time", leftText: "1.11.2024"),
        .init(rightText: "Request Size", leftText: "26B"),
        .init(rightText: "Response Size", leftText: "26B")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "NetworkLoggerDetailCell", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: "NetworkLoggerDetailCell")
    }
    
    @IBAction func didSegmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            break
        case 1:
            tableArray.removeAll()
            tableArray.append([.request])
            tableView.reloadData()
        case 2:
            tableArray.removeAll()
            tableArray.append([.response])
            tableView.reloadData()
        default:
            break
        }
    }
}

extension NetworkLoggerDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = tableArray[indexPath.section][indexPath.row]
        switch item {
        case .overview:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "NetworkLoggerDetailCell", for: indexPath) as? NetworkLoggerDetailCell else {
                return  UITableViewCell()
            }
            cell.configureCell(viewModel)
            return cell
        case .request:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "NetworkLoggerDetailCell", for: indexPath) as? NetworkLoggerDetailCell else {
                return  UITableViewCell()
            }
            cell.configureCell(viewModel)
            return cell
        case .response:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "NetworkLoggerDetailCell", for: indexPath) as? NetworkLoggerDetailCell else {
                return  UITableViewCell()
            }
            cell.configureCell(viewModel)
            return cell
        }
    }
}

extension NetworkLoggerDetailViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
