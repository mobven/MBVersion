//
//  NetworkLoggerDetailCell.swift
//  MBVersion
//
//  Created by Semih Ozsoy on 1.11.2024.
//

import UIKit

struct NetworkLoggerDetailItems {
    var rightText: String?
    var leftText: String?
}

class NetworkLoggerDetailCell: UITableViewCell {
    @IBOutlet weak var mainStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(_ items: [NetworkLoggerDetailItems]) {
        mainStackView.removeAllArrangedSubviews()
        for item in items {
            mainStackView.addArrangedSubview(prepareHorizontalStackView(item))
        }
    }
    
    func prepareHorizontalStackView(_ items: NetworkLoggerDetailItems) -> UIStackView {
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillProportionally
        horizontalStackView.alignment = .fill
        
        let rightLabel = UILabel()
        rightLabel.text = items.rightText
        let leftLabel = UILabel()
        leftLabel.text = items.leftText
        
        horizontalStackView.addArrangedSubview(rightLabel)
        horizontalStackView.addArrangedSubview(leftLabel)
        return horizontalStackView
    }
}

extension UIStackView {
    func removeAllArrangedSubviews() {
        let removedSubviews = arrangedSubviews.reduce([]) { allSubviews, subview -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }

        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap(\.constraints))

        // Remove the views from self
        removedSubviews.forEach { $0.removeFromSuperview() }
    }
}
