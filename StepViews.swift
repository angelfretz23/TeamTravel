//
//  StepView.swift
//  TeamTravel
//
//  Created by Jairo Eli de Leon on 11/7/16.
//  Copyright © 2016 Joseph Hansen. All rights reserved.
//

import UIKit

class StepViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
}

class StepZeroViewController: StepViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
}

class StepTwoViewController: StepViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
}

class StepThreeViewController: StepViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
}

class StepFourViewController: StepViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
}

class StepFiveViewController: StepViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
}

class StepSixViewController: StepViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  

  @IBAction func getStarted(_ sender: UIButton) {
    
    let mainStoryboard = UIStoryboard(name: "MainMapView", bundle: nil)
    let homeVC = mainStoryboard.instantiateInitialViewController() as! UINavigationController
    
    let launchedBefore = UserDefaults.standard.bool(forKey: "firstLaunch")
    
    if launchedBefore {
      self.dismiss(animated: true, completion: nil)
      
    } else {
      
      UserDefaults.standard.set(true, forKey: "firstLaunch")
      
      let snapshot: UIView = self.view.window!.snapshotView(afterScreenUpdates: true)!
      
      homeVC.view.addSubview(snapshot)
      self.view.window?.rootViewController = homeVC
      
      UIView.animate(withDuration: 0.5, animations: {() in
        snapshot.layer.opacity = 0
      }, completion: {(completion) in
        snapshot.removeFromSuperview()
      })
    }
    
  }
  
}












