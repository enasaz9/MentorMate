//
//  AboutUsViewController.swift
//  Venues
//
//  Created by Enas Ahmed Zaki on 25/05/2022.
//

import UIKit

class AboutUsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
// Open MentorMate about us page in Safari
    @IBAction func openAboutUs(_ sender: Any) {
        if let url = URL(string: "https://mentormate.com/about/") {
            UIApplication.shared.open(url)
        }
    }
}
