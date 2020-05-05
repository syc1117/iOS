import UIKit
final class ReorderingViewController: UIViewController {
   
  var parkImages = ParkManager.imageNames(of: .nationalPark)
   
  let layout = UICollectionViewFlowLayout()
  lazy var collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
//  lazy var collectionView: UICollectionView = {
//    let cv = UICollectionView(frame: view.)
//  }()
   
   
  // MARK: - View Lifecycle
   
  override func viewDidLoad() {
    super.viewDidLoad()
    setupFlowLayout()
    view.addSubview(collectionView)
    collectionView.backgroundColor = .white
    collectionView.dataSource = self
    collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "customcell")
    setupLong()
  }
   
   
  // MARK: Setup FlowLayout
   
  func setupFlowLayout() {
    let itemInLine: CGFloat = 4
    let spacing: CGFloat = 10
    let insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    let cvWidth = collectionView.bounds.width
    let contentSize = cvWidth - insets.left - insets.right - (spacing * itemInLine - 1)
    let itemSize = (contentSize / itemInLine).rounded(.down) // 소수점으로 나올 수 있어서 소수점은 버림해줌!
     
    layout.minimumLineSpacing = spacing
    layout.minimumInteritemSpacing = spacing
    layout.sectionInset = insets
    layout.itemSize = CGSize(width: itemSize, height: itemSize)
  }
   
  // MARK: Setup Gesture
  func setupLong() {
    let gesture = UILongPressGestureRecognizer(
      target: self,
      action: #selector(reorderCollectionViewItem(_:))
    )
    gesture.minimumPressDuration = 0.5
    collectionView.addGestureRecognizer(gesture)
  }
   
  // MARK: - Action
  @objc private func reorderCollectionViewItem(_ sender: UILongPressGestureRecognizer) {
    let location = sender.location(in: collectionView)
    switch sender.state {
    case .began:
      guard let indexPath = collectionView.indexPathForItem(at: location) else { break }
      collectionView.beginInteractiveMovementForItem(at: indexPath)
    case .changed:
      collectionView.updateInteractiveMovementTargetPosition(location)
    case .cancelled:
      collectionView.cancelInteractiveMovement()
    case .ended:
      collectionView.endInteractiveMovement()
    default:
      break
    }
  }
}
// MARK: - UICollectionViewDataSource
extension ReorderingViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return parkImages.count
  }
   
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: "customcell", for: indexPath
      ) as! CustomCell
    
    let item = indexPath.item
    let park = parkImages[item]
    cell.configure(park)
    cell.backgroundColor = .black
    return cell
  }
   
  func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    guard sourceIndexPath != destinationIndexPath else { return }
    let source = sourceIndexPath.item
    let destination = destinationIndexPath.item
    print("source :", source, "dest :", destination)
     
    let element = parkImages.remove(at: sourceIndexPath.item)
    parkImages.insert(element, at: destinationIndexPath.item)
  }
}
