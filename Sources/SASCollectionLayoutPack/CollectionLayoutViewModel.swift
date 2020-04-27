/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit
import SASLogger

public class CollectionLayoutViewModel: NSObject {
  
  public var pinLayout: SASPinterestLayout?
 // public var horizontallayout: SASPinterestLayoutHorizontal?
  public var collectionView: UICollectionView?
  public var numberOfColumns: Int = 2
  public var staticCellHeight: CGFloat = 0
  public var collectionViewWidth: CGFloat?
    public static let shared = CollectionLayoutViewModel()
    
    public var sectionInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
    
    public override init() {}
    
    public init(collectionView: UICollectionView, numberOfColumns: Int, staticCellHeight: CGFloat, top: CGFloat = 3, left: CGFloat = 3, bottom: CGFloat = 3, right: CGFloat = 3, collectionViewWidth: CGFloat? = nil ) {
        self.collectionView = collectionView
        self.numberOfColumns = numberOfColumns
        self.staticCellHeight = staticCellHeight
        self.collectionViewWidth = collectionViewWidth
        sectionInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
  
    public func collectionViewFlowLayoutSetUp() {
        NotificationCenter.default.addObserver(self, selector: #selector(orientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
        collectionView?.contentInset = sectionInsets
        if let layout = collectionView?.collectionViewLayout as? SASPinterestLayout {
            layout.numberOfColumns = self.numberOfColumns
            Logger.p("SASCollWidth -fromPac- collectionViewWidth  = \(collectionViewWidth)")
            layout.staticCellHeight = staticCellHeight
            layout.collectionViewWidth = collectionViewWidth
            pinLayout = layout
        }
    }
    
  
    @objc func orientationDidChange(notification: NSNotification) {

        clearingLayout()
    }

    public func clearingLayout() {
        pinLayout?.cache.removeAll()
        pinLayout?.contentHeight = 0
        collectionView!.collectionViewLayout.invalidateLayout()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
