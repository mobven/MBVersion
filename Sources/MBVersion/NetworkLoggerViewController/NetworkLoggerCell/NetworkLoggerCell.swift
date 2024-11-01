//
//  NetworkLoggerCell.swift
//  MBVersion
//
//  Created by Semih Ozsoy on 1.11.2024.
//

import UIKit

class NetworkLoggerCell: UITableViewCell {

    @IBOutlet weak var resultTypeView: UIView!
    
    @IBOutlet weak var requestTimeLabel: UILabel!
    
    @IBOutlet weak var urlLabel: UILabel!
    
    @IBOutlet weak var requestMethodLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(_ viewModel: NetworkLogViewModel) {
        resultTypeView.backgroundColor = viewModel.resultType == .success ? .green : .red
        requestTimeLabel.text = viewModel.requestTime
        urlLabel.text = viewModel.requestUrl
        requestMethodLabel.text = viewModel.requestMethod.rawValue
    }
}

struct NetworkLogViewModel {
    let resultType: ResultType
    let requestTime: String
    let requestUrl: String
    let requestMethod: RequestMethod
}

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}

enum ResultType {
    case success
    case failure
}
