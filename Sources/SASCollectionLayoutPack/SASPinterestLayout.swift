

import UIKit
import SASLogger

protocol PinterestLayoutDelegate: AnyObject {}

extension PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForDifferentCellsAtIndexPath indexPath: IndexPath) -> CGFloat {
        return 0
    }
}



public class SASPinterestLayout: UICollectionViewLayout {
  
  weak var delegate: PinterestLayoutDelegate?
  public var numberOfColumns = 2
  public var cellPadding: CGFloat = 3
  public var cache: [UICollectionViewLayoutAttributes] = []
  public var contentHeight: CGFloat = 0
  public var staticCellHeight: CGFloat = 0
  public var collectionViewWidth: CGFloat?
    
  private var contentWidth: CGFloat {
    guard let collectionView = collectionView else { return 0 }
    
    let insets = collectionView.contentInset
    Logger.p("SASCollWidth -fromPac- insets = \(insets)")
    Logger.p("SASCollWidth -fromPac- collectionViewWidth  = \(collectionViewWidth )")
    
    if let customWidth = collectionViewWidth {
        return customWidth - (insets.left + insets.right)
    }
    
     return collectionView.bounds.width - (insets.left + insets.right)
    
  }

  override public var collectionViewContentSize: CGSize {
   
    return CGSize(width: contentWidth, height: contentHeight)
  }
  
  override public func prepare() {

    guard cache.isEmpty, let collectionView = collectionView else {return}
    
    let columnWidth = contentWidth / CGFloat(numberOfColumns)
    
    var xOffset: [CGFloat] = []
    
    for column in 0..<numberOfColumns {
      xOffset.append(CGFloat(column) * columnWidth)
    }
    
    var column = 0
    var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)
    
    for item in 0..<collectionView.numberOfItems(inSection: 0) {

      let indexPath = IndexPath(item: item, section: 0)
    
//      let cellHeight = delegate?.collectionView(collectionView, heightForDifferentCellsAtIndexPath: indexPath) ?? staticCellHeight
        
      let height = cellPadding * 2 + columnWidth + staticCellHeight
        
      let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)

      let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
        
      let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      attributes.frame = insetFrame
      cache.append(attributes)
      contentHeight = max(contentHeight, frame.maxY)
      
      
      yOffset[column] = yOffset[column] + height

      column = column < (numberOfColumns - 1) ? (column + 1) : 0
        
    }

  }
  
  override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

    var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []

    for attributes in cache {
      if attributes.frame.intersects(rect) {
        visibleLayoutAttributes.append(attributes)
      }
    }

    return visibleLayoutAttributes
    
  }
  
  override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return cache[indexPath.item]
  }

}
