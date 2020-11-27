import UIKit
import Parchment

// This first thing we need to do is to create our own custom paging
// view and override the layout constraints. The default
// implementation positions the menu view above the page view
// controller, but we want to include a header view above the menu. We
// also create a layout constraint property that allows us to update
// the height of the header.
class HeaderPagingView: PagingView {
  
  static let HeaderHeight: CGFloat = 510
  
  var headerHeightConstraint: NSLayoutConstraint?
    var safeTopConstraint: NSLayoutConstraint?
    
   lazy var headerView: HeaderPowerView = {
    let view = HeaderPowerView.init()
    view.backgroundColor = .purple
    return view
  }()
    

  
  override func setupConstraints() {
    addSubview(headerView)
    
    pageView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    headerView.translatesAutoresizingMaskIntoConstraints = false
    
//    headerHeightConstraint = headerView.heightAnchor.constraint(
//      equalToConstant: HeaderPagingView.HeaderHeight
//    )
//    headerHeightConstraint?.isActive = true
    
    safeTopConstraint = headerView.topAnchor.constraint(equalTo: topAnchor, constant: 0)
    safeTopConstraint?.isActive = true
    
    NSLayoutConstraint.activate([
      collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      collectionView.heightAnchor.constraint(equalToConstant: options.menuHeight),
      collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
      
        headerView.heightAnchor.constraint(equalToConstant: 510),
//      headerView.topAnchor.constraint(equalTo: topAnchor),
      headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
      headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      pageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      pageView.trailingAnchor.constraint(equalTo: trailingAnchor),
      pageView.bottomAnchor.constraint(equalTo: bottomAnchor),
      pageView.topAnchor.constraint(equalTo: topAnchor)
    ])
    
  }
}

// Create a custom paging view controller and override the view with
// our own custom subclass.
class HeaderPagingViewController: PagingViewController {
    
  override func loadView() {

    view = HeaderPagingView(
      options: options,
      collectionView: collectionView,
      pageView: pageViewController.view
    )
  }
}

class GEProjectViewController: UIViewController {
  /// Cache the view controllers in an array to avoid re-creating them
  /// while swiping between pages. Since we only have three view
  /// controllers it's fine to keep them all in memory.
  private let viewControllers = [
    TableViewController(),
    TableViewController(),
    TableViewController(),
    TableViewController()
  ]
  
  private let pagingViewController = HeaderPagingViewController()
  
//  private var headerConstraint: NSLayoutConstraint {
//    let pagingView = pagingViewController.view as! HeaderPagingView
//    return pagingView.headerHeightConstraint!
//  }
    
    private let critical: CGFloat = 510 - 88
    private var topConstraint: NSLayoutConstraint {
        let pagingView = pagingViewController.view as! HeaderPagingView
        return pagingView.safeTopConstraint!
    }
    private var headerView : HeaderPowerView {
        let pagingView = pagingViewController.view as! HeaderPagingView
        return pagingView.headerView
    }
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    pagingViewController.menuItemSize = .sizeToFit(minWidth: 40, height: 40)
    // Add the paging view controller as a child view controller.
    addChild(pagingViewController)
    view.addSubview(pagingViewController.view)
    pagingViewController.didMove(toParent: self)
    
    // Customize the menu styling.
    pagingViewController.selectedTextColor = .red
    pagingViewController.indicatorColor = .red
    pagingViewController.indicatorOptions = .visible(
      height: 2,
      zIndex: Int.max,
      spacing: .zero,
      insets: .zero
    )
    
    // Contrain the paging view to all edges.
    pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      pagingViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
      pagingViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      pagingViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      pagingViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])
    
//    let ssview = UIView()
//    ssview.backgroundColor = .purple
//    view.addSubview(ssview)
//    ssview.translatesAutoresizingMaskIntoConstraints = false
//    NSLayoutConstraint.activate([
//        ssview.topAnchor.constraint(equalTo: pagingViewController.view.bottomAnchor),
//        ssview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//        ssview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//        ssview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//    ])
    
    // Set the data source for our view controllers
    pagingViewController.dataSource = self
    
  
    pagingViewController.delegate = self
    
    viewControllers.first?.tableView.delegate = self
//    if #available(iOS 11.0, *) {
//        viewControllers.first?.tableView.contentInsetAdjustmentBehavior = .never
//    }
  }
}

extension GEProjectViewController: PagingViewControllerDataSource {
  
  func pagingViewController(_: PagingViewController, viewControllerAt index: Int) -> UIViewController {
    let viewController = viewControllers[index]
    viewController.title = "View \(index)"
    
    let height = pagingViewController.options.menuHeight + HeaderPagingView.HeaderHeight
    let insets = UIEdgeInsets(top: height, left: 0, bottom: 0, right: 0)
    viewController.tableView.contentInset = insets
    viewController.tableView.scrollIndicatorInsets = insets
    
    
    return viewController
  }
  
  func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
    return PagingIndexItem(index: index, title: "View \(index)")
  }
  
  func numberOfViewControllers(in: PagingViewController) -> Int{
    return viewControllers.count
  }
  
}

extension GEProjectViewController: PagingViewControllerDelegate {
  
  func pagingViewController(_ pagingViewController: PagingViewController, didScrollToItem pagingItem: PagingItem, startingViewController: UIViewController?, destinationViewController: UIViewController, transitionSuccessful: Bool) {
    guard let startingViewController = startingViewController as? TableViewController else { return }
    guard let destinationViewController = destinationViewController as? TableViewController else { return }
    
    // Set the delegate on the currently selected view so that we can
    // listen to the scroll view delegate.
    if transitionSuccessful {
      startingViewController.tableView.delegate = nil
      destinationViewController.tableView.delegate = self
    }
  }
  
  func pagingViewController(_: PagingViewController, willScrollToItem pagingItem: PagingItem, startingViewController: UIViewController, destinationViewController: UIViewController) {
    guard let destinationViewController = destinationViewController as? TableViewController else { return }
    
    // Update the content offset based on the height of the header
    // view. This ensures that the content offset is correct if you
    // swipe to a new page while the header view is hidden.
    if let scrollView = destinationViewController.tableView {
//      let offset = headerConstraint.constant + pagingViewController.options.menuHeight
        let offset = topConstraint.constant + pagingViewController.options.menuHeight
      scrollView.contentOffset = CGPoint(x: 0, y: -offset)
        NSLog("\(offset)")
    updateScrollIndicatorInsets(in: scrollView)
    }
  }
}

extension GEProjectViewController: UITableViewDelegate {
  
  func updateScrollIndicatorInsets(in scrollView: UIScrollView) {
    let offset = min(0, scrollView.contentOffset.y) * -1
    let insetTop = max(pagingViewController.options.menuHeight, offset)
    let insets = UIEdgeInsets(top: insetTop+40, left: 0, bottom: 0, right: 0)
    scrollView.scrollIndicatorInsets = insets
  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    guard scrollView.contentOffset.y < 0 else {
      // Reset the header constraint in case we scrolled so fast that
      // the height was not set to zero before the content offset
      // became negative.
//      if headerConstraint.constant > 0 {
//        headerConstraint.constant = 0
//      }
        if topConstraint.constant < critical * -1 {
            topConstraint.constant = critical * -1
        }
      return
    }
    
    // Update the scroll indicator insets so they move alongside the
    // header view when scrolling.
    updateScrollIndicatorInsets(in: scrollView)
    
    // Update the height of the header view based on the content
    // offset of the currently selected view controller.
    let height = max(0, abs(scrollView.contentOffset.y) - pagingViewController.options.menuHeight)
//    headerConstraint.constant = height
    topConstraint.constant = height - 510
  }
  
}
