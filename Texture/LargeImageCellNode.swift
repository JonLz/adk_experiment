//
//  LargeImageCellNode.swift
//  Sample
//
//  Created by Craig Howarth on 10/20/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

import AsyncDisplayKit
import UIKit

final class LargeImageCellNode: ASCellNode {
  var headlineNode = ASTextNode()
  var summaryNode = ASTextNode()
  var kickerNode = ASTextNode()
  var creditNode = ASTextNode()
  var imageNode = ASImageNode()
  var footerNode = FooterNode()
  var aspectRatio: CGFloat = 0.0

  convenience init(headline: String, summary: String, kicker: String, credit: String, crop: Crop) {
    self.init()

    aspectRatio = crop.size.height / crop.size.width
    imageNode.image = UIImage(named: crop.imageFilename)
    imageNode.contentMode = .scaleAspectFill

    if !credit.isEmpty {
      creditNode.attributedText = NSAttributedString(
        string: credit,
        attributes: [
          NSAttributedString.Key.font: UIFont.systemFont(ofSize: 9),
          NSAttributedString.Key.foregroundColor: UIColor.lightGray
        ])
    }

    if !kicker.isEmpty {
      kickerNode.attributedText = NSAttributedString(
        string: kicker,
        attributes: [
          NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
          NSAttributedString.Key.foregroundColor: UIColor.black
        ])
    }

    headlineNode.attributedText = NSAttributedString(
      string: headline,
      attributes: [
        NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),
        NSAttributedString.Key.foregroundColor: UIColor.black
      ])
    
    summaryNode.attributedText = NSAttributedString(
      string: summary,
      attributes: [
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
        NSAttributedString.Key.foregroundColor: UIColor.darkGray
      ])

    addSubnode(imageNode)
    addSubnode(creditNode)
    addSubnode(kickerNode)
    addSubnode(headlineNode)
    addSubnode(summaryNode)
    addSubnode(footerNode)
  }
  
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let imageSpec = ASRatioLayoutSpec(ratio: aspectRatio, child: imageNode)
    
    let imageStackSpec = ASStackLayoutSpec.vertical()
    if creditNode.attributedText != nil {
      imageStackSpec.children = [ imageSpec, creditNode ]
    } else {
      imageStackSpec.children = [ imageSpec ]
    }
    imageStackSpec.spacing = 2.0

    let kickerHeadlineStackSpec = ASStackLayoutSpec.vertical()
    if kickerNode.attributedText != nil {
      kickerHeadlineStackSpec.children = [ kickerNode, headlineNode ]
    } else {
      kickerHeadlineStackSpec.children = [ headlineNode ]
    }
    kickerHeadlineStackSpec.spacing = 2.0

    let verticalStackSpec = ASStackLayoutSpec.vertical()
    verticalStackSpec.children = [ imageStackSpec, kickerHeadlineStackSpec, summaryNode, footerNode ]
    verticalStackSpec.spacing = 10.0
    
    let insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    let insetSpec = ASInsetLayoutSpec(insets: insets, child: verticalStackSpec)
    
    return insetSpec
  }
}
