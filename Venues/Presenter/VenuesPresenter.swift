//
//  VenuesPresenter.swift
//  Venues
//
//  Created by Enas Ahmed Zaki on 25/05/2022.
//

import Foundation

// Presenter methods
protocol VenuesPresenter: AnyObject {
    init(view: VenuesView)
    func getAllVenues()
}

class VenuesViewPresenter: VenuesPresenter {
    
    weak var view: VenuesView?
    var allVenues: [VenueModel] = []
    let locationService = LocationManager()

    required init(view: VenuesView) {
        self.view = view
        self.locationService.delegate = self // Set self as delegate
        self.locationService.startUpdatingLocation()  // Requests start updating location
    }
    
    func getAllVenues() {
        self.view?.showLoader()
        // URL construction and adding query parameters
        if var urlComponents = URLComponents(string: API_URLs.PlacesSearch.rawValue) {
            urlComponents.queryItems = [
                URLQueryItem(name: "limit", value: placesSearchLimit),
                URLQueryItem(name: "sort", value: placesSearchCriteria),
                URLQueryItem(name: "ll", value: self.locationService.getCurrentLocation())
            ]
            
            let headers = [
                "Accept": "application/json",
                "Authorization": fourSquareAPIKey
            ]
            print(urlComponents)
            
            if let url = urlComponents.url {
                NetworkManager.get(requestURL: url, headers: headers, mapTo: ResultsModel.self) { [weak self] (result: Result<ResultsModel, Error>) in
                    DispatchQueue.main.async {
                        
                        self?.view?.hideLoader()
                        
                        switch result {
                        case .failure(let error):
                            if let error = error as? NetworkError {
                                switch error {
                                case .noData:
                                    self?.view?.presentAlert(title: "Error", description: error.localizedDescription)
                                // Incase of network error load Venues from CoreData
                                case .networkError:
                                    self?.allVenues = CoreDataManager.loadSavedData()
                                    self?.view?.onVenuesRetrieval()
                                    self?.view?.presentAlert(title: "Error", description: "There's no internet connection.\nLast retrieved data is shown!")

                                }
                            } else {
                                self?.view?.presentAlert(title: "Error", description: error.localizedDescription)
                            }
                        // Show retrieved data from API and save them in CoreData
                        case .success(let response):
                            self?.allVenues = response.results
                            self?.view?.onVenuesRetrieval()
                            if let allV = self?.allVenues, !allV.isEmpty {
                                CoreDataManager.saveContext(allVenues: allV)
                            }
                        }
                    }
                }
            }
        }
    }
}

extension VenuesViewPresenter: LocationManagerDelegate {
    func didUpdateLocation() {
        self.getAllVenues()
    }
    
    func enableLocationPermission() {
        DispatchQueue.main.async {
            self.view?.showLocationPermissionAlert()
        }
    }
    
}
