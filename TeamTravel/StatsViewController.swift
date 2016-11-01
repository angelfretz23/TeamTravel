//
//  StatsViewController.swift
//  TeamTravel
//
//  Created by Joseph Hansen on 11/1/16.
//  Copyright © 2016 Joseph Hansen. All rights reserved.
//

import UIKit

private let kLivelyGreenColor = UIColor(red: 8 / 255, green: 132 / 255, blue: 67 / 255, alpha: 1)

class StatsViewController: UIViewController {
    
    @IBOutlet weak var innerView: UIView!
    
    @IBOutlet weak var segmentedControl: SegmentedControl!
    
    

    
    
    //Programatic segues to UserStatsViewControllers
    
    //PointsView
    /*
    lazy var pointsViewController: PointsGraphViewController =  {
        let storyboard = UIStoryboard(name: "UserDetailView", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "pointsViewController") as! PointsGraphViewController
        return viewController
    }()
 */
    
    //BadgesView
    lazy var badgesViewController: BadgesCollectionViewController = {
        let storyboard = UIStoryboard(name: "UserDetailView", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "badgesViewController") as! BadgesCollectionViewController
        return viewController
    }()
    
    //LocationsView
    lazy var locationsVisitedTableViewController: LocationsVisitedTableViewController = {
        let storyboard = UIStoryboard(name: "UserDetailView", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "locationsVisitedViewController") as! LocationsVisitedTableViewController
        return viewController
    }()
    
    lazy var userDetailViewControllers: [UIViewController] = {
        return [self.badgesViewController, self.locationsVisitedTableViewController]
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    func setupViews() {
        for viewController in self.userDetailViewControllers {
            addViewControllerAsChild(viewController: viewController)
        }
    }
    
    func addViewControllerAsChild(viewController: UIViewController) {
        //add child view controller
        self.addChildViewController(viewController)
        // add child as subview
        self.innerView.addSubview(viewController.view)
        
        //configure child view
        
        viewController.view.frame = innerView.bounds
        //Notify Child ViewController
        viewController.didMove(toParentViewController: self)
    }
    
    

    
    
    
    
    
    
    
    
    //SegmentedController Functions
    
    fileprivate func setupUI() {
        configureSegmentedControl2()
    }
    
    fileprivate func configureSegmentedControl2() {
        let images = [#imageLiteral(resourceName: "pin"), #imageLiteral(resourceName: "pin"), #imageLiteral(resourceName: "pin") ]
        let selectedImages = [#imageLiteral(resourceName: "pin"), #imageLiteral(resourceName: "pin"), #imageLiteral(resourceName: "pin") ]
        
        segmentedControl.setImages(images, selectedImages: selectedImages)
        segmentedControl.delegate = self
        segmentedControl.selectionIndicatorStyle = .bottom
        segmentedControl.selectionIndicatorColor = kLivelyGreenColor
        segmentedControl.selectionIndicatorHeight = 3
        segmentedControl.selectionIndicatorEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func updateInnerView() {
        let index = segmentedControl.selectedIndex
        
        for viewController in self.userDetailViewControllers {
            viewController.view.isHidden = true
        }
        
        let selectedView = self.userDetailViewControllers[index]
        selectedView.view.isHidden = false
    }

}

//SegmentedControllerDelegate Functions

extension StatsViewController: SegmentedControlDelegate {
    func segmentedControl(_ segmentedControl: SegmentedControl, didSelectIndex selectedIndex: Int) {
        print("Did select index \(selectedIndex)")
        updateInnerView()
        switch segmentedControl.style {
        case .text:
            print("The title is “\(segmentedControl.titles[selectedIndex].string)”\n")
        case .image:
            print("The image is “\(segmentedControl.images[selectedIndex])”\n")
        }
    }
    
    func segmentedControl(_ segmentedControl: SegmentedControl, didLongPressIndex longPressIndex: Int) {
        print("Did long press index \(longPressIndex)")
        if UIDevice.current.userInterfaceIdiom == .pad {
            let viewController = UIViewController()
            viewController.modalPresentationStyle = .popover
            viewController.preferredContentSize = CGSize(width: 200, height: 300)
            if let popoverController = viewController.popoverPresentationController {
                popoverController.sourceView = view
                let yOffset: CGFloat = 10
                popoverController.sourceRect = view.convert(CGRect(origin: CGPoint(x: 70 * CGFloat(longPressIndex), y: yOffset), size: CGSize(width: 70, height: 30)), from: navigationItem.titleView)
                popoverController.permittedArrowDirections = .any
                present(viewController, animated: true, completion: nil)
            }
        } else {
            let message = segmentedControl.style == .text ? "Long press title “\(segmentedControl.titles[longPressIndex].string)”" : "Long press image “\(segmentedControl.images[longPressIndex])”"
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        }
    }
}
