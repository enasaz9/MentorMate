//
//  MainViewController.swift
//  Venues
//
//  Created by Enas Ahmed Zaki on 25/05/2022.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var venuesContainerView: UIView!
    @IBOutlet weak var aboutUsContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    // SegmentedControl when value changed to manage container views apperance
    @IBAction func segementedControlTapped(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            UIView.animate(withDuration: 0.5, animations: {
                self.venuesContainerView.alpha = 1
                self.aboutUsContainerView.alpha = 0
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.venuesContainerView.alpha = 0
                self.aboutUsContainerView.alpha = 1
            })
        }
    }
    
}

