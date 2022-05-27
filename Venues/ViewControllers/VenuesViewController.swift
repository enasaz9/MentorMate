//
//  VenuesViewController.swift
//  Venues
//
//  Created by Enas Ahmed Zaki on 25/05/2022.
//

import UIKit

// View methods to be managed by the presenter
protocol VenuesView: AnyObject {
    func onVenuesRetrieval()
    func presentAlert(title: String, description: String)
    func showLoader()
    func hideLoader()
    func showLocationPermissionAlert()
}


class VenuesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var activityIndicator: UIActivityIndicatorView!
    var venuesViewPresenter: VenuesViewPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initialSetup()
        
    }
    
    // Method to setup the loading indicator, table view registering cell and preseneter instantiation
    func initialSetup() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        self.tableView.register(UINib(nibName: "VenueTableViewCell", bundle: nil), forCellReuseIdentifier: "VenueTableViewCell")
        
        venuesViewPresenter = VenuesViewPresenter.init(view: self)
    }
}

extension VenuesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.venuesViewPresenter?.allVenues.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "VenueTableViewCell") as? VenueTableViewCell, let venue = self.venuesViewPresenter?.allVenues[indexPath.row] {
            cell.setData(venue: venue)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension VenuesViewController: VenuesView {
    
    func onVenuesRetrieval() {
        self.tableView.reloadData()
    }
    
    func showLoader() {
        self.activityIndicator.startAnimating()
    }
    
    func hideLoader() {
        self.activityIndicator.stopAnimating()
    }
    
    func presentAlert(title: String, description: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showLocationPermissionAlert() {
        let alertController = UIAlertController(title: "Location Permission Required", message: "Please enable location permissions in settings.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
            //Redirect to Settings app
            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}
