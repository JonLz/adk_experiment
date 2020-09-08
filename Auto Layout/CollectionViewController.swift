//
//  CollectionViewController.swift
//  Sample
//
//  Created by Jonathan Lazar on 9/3/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import UIKit

final class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

  private let cellCount: Int
  private lazy var dataSource = CollectionViewDataSource(cellCount: cellCount)

  init(cellCount: Int) {
    self.cellCount = cellCount

    let size = NSCollectionLayoutSize(
        widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
        heightDimension: NSCollectionLayoutDimension.estimated(44)
    )
    let item = NSCollectionLayoutItem(layoutSize: size)
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)

    let section = NSCollectionLayoutSection(group: group)

    section.interGroupSpacing = 10

    let layout = UICollectionViewCompositionalLayout(section: section)

    super.init(collectionViewLayout: layout)

    collectionView.collectionViewLayout = layout
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    collectionView.backgroundColor = .systemBackground
    collectionView.dataSource = dataSource
    collectionView.delegate = self
    collectionView.register(cell: HeadlineSummaryCell.self)
    collectionView.register(cell: ThumbnailCell.self)
    collectionView.register(cell: CarouselCell.self)
  }
}

final private class CollectionViewDataSource: NSObject, UICollectionViewDataSource {

  private let cellCount: Int

  init(cellCount: Int) {
    self.cellCount = cellCount
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return cellCount
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let headline = ContentGenerator.words(min: 2,8)
    let summary = ContentGenerator.words(min: 20,40)

    let itemNumber = indexPath.row + 1

    if itemNumber % 5 == 0 {
      let cell: CarouselCell = collectionView.dequeue(for: indexPath)
      return cell
    } else if itemNumber % 4 == 0 {
      let cell: HeadlineSummaryCell = collectionView.dequeue(for: indexPath)
      cell.set(headline: headline, summary: summary)
      return cell
    } else {
      let cell: ThumbnailCell = collectionView.dequeue(for: indexPath)
      cell.set(headline: headline, summary: summary)
      return cell
    }
  }
}
