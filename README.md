# SASCollectionLayoutPack
## Steps to integrate

1)  First import "SASCollectionLayoutPack" to the VC Class

2)  First Drag the collection view into the view controller and create an IBOutlet for CollectionView
### Eg: @IBOutlet weak var collectionView: UICollectionView!

3) In the ViewController assign a variable to "CollectionLayoutViewModel". 
### Eg: 

COPY THIS ->  var collectionViewModel: CollectionLayoutViewModel? 

4) Assign the intantiate the collectionViewModel at the viewDidLoad().
### Eg: 

COPY THIS in viewDidLoad() ->
collectionViewModel = CollectionLayoutViewModel(collectionView: collectionView, numberOfColumns: 2, staticCellHeight: 250)

    collectionView -> this is the collectionView to assign
    numberOfColumns -> number of columns to to show in the collection View layout
    staticCellHeight -> the cell height that has to set. Can change the cell height at you desire. There is also dynamic cell height to display it according to the content size.
    
### if you want to have a dynamic cell height, assgin the class with "PinterestLayoutDelegate"  and add the extention and in the extension method give the dynamic height.

### Eg:
extension ViewController: PinterestLayoutDelegate {
  func collectionView( _ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
    return Data[indexPath.item].image.size.height
  }
}


5) in Storyboard select the collectionView and in the Attributes inspector set the Layout to "Custom" and assign "SASPinterestLayout" and Module to "SASCollectionLayoutPack"

