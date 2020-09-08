//
//  CarouselCellView.swift
//  Sample
//
//  Created by Su, Wei-Lun on 9/8/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import UIKit

final class CarouselCellView: UIView {

  private lazy var collectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .horizontal
    flowLayout.itemSize = CGSize(width: 200, height: 300)
    flowLayout.minimumInteritemSpacing = 10
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    collectionView.backgroundColor = .white
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.register(LargeImageCell.self, forCellWithReuseIdentifier: "LargeImageCell")
    return collectionView
  }()

  var numberOfItems: Int = 0

  init(numberOfItems: Int) {
    self.numberOfItems = numberOfItems
    super.init(frame: .zero)
    collectionView.delegate = self
    collectionView.dataSource = self
    addSubview(collectionView)

    let bottomEdgeConstraint = collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
    bottomEdgeConstraint.priority = .defaultLow

    NSLayoutConstraint.activate([
      collectionView.heightAnchor.constraint(equalToConstant: 300.0),
      collectionView.topAnchor.constraint(equalTo: topAnchor),
      bottomEdgeConstraint,
      collectionView.leftAnchor.constraint(equalTo: leftAnchor),
      collectionView.rightAnchor.constraint(equalTo: rightAnchor)])
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
}

extension CarouselCellView: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return numberOfItems
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LargeImageCell", for: indexPath) as? LargeImageCell else { return UICollectionViewCell() }
    cell.updateUI(
      headline: "Miles Davis",
      summary: "Miles Dewey Davis III was an American jazz trumpeter, bandleader, and composer.",
      image: "miles.png"
    )
    return cell
  }
}
