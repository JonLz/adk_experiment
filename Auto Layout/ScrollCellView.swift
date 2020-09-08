//
//  ScrollCellView.swift
//  Sample
//
//  Created by Su, Wei-Lun on 9/8/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import UIKit

final class CarouselCell: BottomSeparatorCell {
  private let cellView = CarouselCellView(numberOfItems: 10)

  override init (frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(cellView)
    cellView.pinEdges(to: contentView)
  }

  func configure() {
    cellView.updateUI()
  }
}

final class CarouselCellView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {

  private lazy var collectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .horizontal
    flowLayout.itemSize = CGSize(width: 200, height: 300)
    flowLayout.minimumInteritemSpacing = 10
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.register(LargeImageCell.self, forCellWithReuseIdentifier: "LargeImageCell")
    collectionView.backgroundColor = .red
    return collectionView
  }()

  var numberOfItems: Int = 0

  init(numberOfItems: Int) {
      self.numberOfItems = numberOfItems
      super.init(frame: .zero)
      setupSubviews()
      setupConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }

  private func setupSubviews() {
      collectionView.delegate = self
      collectionView.dataSource = self

      [collectionView].forEach { addSubview($0) }
  }

  func updateUI() {
      //self.items = items
  }

  private func setupConstraints() {
      NSLayoutConstraint.activate([
          widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width),
          collectionView.heightAnchor.constraint(equalToConstant: 300.0),
          collectionView.topAnchor.constraint(equalTo: topAnchor),
          collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
          collectionView.leftAnchor.constraint(equalTo: leftAnchor),
          collectionView.rightAnchor.constraint(equalTo: rightAnchor)])
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return numberOfItems
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LargeImageCell", for: indexPath) as? LargeImageCell else { return UICollectionViewCell() }
    return cell
  }
}
