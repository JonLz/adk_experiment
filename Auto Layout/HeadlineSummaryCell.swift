//
//  HeadlineSummaryCell.swift
//  Sample
//
//  Created by Zev Eisenberg on 9/4/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import UIKit

final class HeadlineSummaryCell: UICollectionViewCell, Reusable {

  private lazy var headlineView: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    return label
  }()

  private lazy var summaryView: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    return label
  }()

  private let footerView = FooterView()

  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = .white

    let stackView = UIStackView(arrangedSubviews: [headlineView, summaryView, footerView])
    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.spacing = 5

    contentView.addSubview(stackView)

    stackView.pinEdges(to: contentView)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func set(headline: String, summary: String) {
    headlineView.attributedText = NSAttributedString(
      string: headline,
      attributes: [
        NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),
        NSAttributedString.Key.foregroundColor: UIColor.black
      ]
    )

    summaryView.attributedText = NSAttributedString(
      string: summary,
      attributes: [
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
        NSAttributedString.Key.foregroundColor: UIColor.darkGray
      ]
    )
  }
}
