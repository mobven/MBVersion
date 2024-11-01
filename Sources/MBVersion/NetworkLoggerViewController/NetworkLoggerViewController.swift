//
//  File.swift
//  MBVersion
//
//  Created by Semih Ozsoy on 1.11.2024.
//

import UIKit

final class NetworkLoggerViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    public var viewModel: [NetworkLogViewModel] = [
        .init(resultType: .success, requestTime: "16:49", requestUrl: "https://github.com/Rashidium", requestMethod: .get),
        .init(resultType: .success, requestTime: "16:48", requestUrl: "https://github.com/semihozsoy", requestMethod: .get),
        .init(resultType: .success, requestTime: "16:47", requestUrl: "https://github.com/arducumutcan", requestMethod: .post),
        .init(resultType: .failure, requestTime: "16:46", requestUrl: "https://github.com/gulerhasan", requestMethod: .delete),
        .init(resultType: .success, requestTime: "16:45", requestUrl: "https://github.com/cemeke1", requestMethod: .put)
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "NetworkLoggerCell", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: "NetworkLoggerCell")
    }
}

extension NetworkLoggerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "NetworkLoggerCell", for: indexPath) as? NetworkLoggerCell else {
            return UITableViewCell()
        }
        cell.configureCell(viewModel[indexPath.row])
        return cell
    }
}

extension NetworkLoggerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "NetworkLoggerDetailViewController", bundle: nil)
        let detailVC = storyBoard.instantiateViewController(withIdentifier: "NetworkLoggerDetailVC") as! NetworkLoggerDetailViewController
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
