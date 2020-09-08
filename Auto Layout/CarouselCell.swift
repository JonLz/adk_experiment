//
//  CarouselCell.swift
//  Sample
//
//  Created by Su, Wei-Lun on 9/8/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import UIKit

final class CarouselCell: BottomSeparatorCell {
  private let view = CarouselCellView(numberOfItems: 10)

  override init (frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(view)
    view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
      view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
    ])
  }
}
