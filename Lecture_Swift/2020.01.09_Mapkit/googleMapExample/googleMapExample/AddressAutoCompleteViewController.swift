//
//  AddressAutoCompleteViewController.swift
//  googleMapExample
//
//  Created by 신용철 on 2020/02/06.
//  Copyright © 2020 신용철. All rights reserved.
//


import UIKit
import GoogleMaps
import GooglePlaces

class AddressAutocompleteViewController: UIViewController {
    
    private var mapView: GMSMapView?
    private var locationManager: CLLocationManager?
    private let defaultZoom: Float = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Address Autocomplete"
        
        configureNaviItem()
        configureGoogleMap()
    }
    
    private func updateLocation(place: GMSPlace) {
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: defaultZoom)
        mapView?.camera = camera
        
        let marker = GMSMarker(position: place.coordinate)
        marker.title = place.name
        marker.snippet = place.formattedAddress
        marker.map = mapView
    }
    
    private func configureNaviItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchLocation))
    }
    
    private func setDefaultLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: defaultZoom)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        marker.title = "Default"
        marker.map = mapView
    }
    
    private func configureGoogleMap() {
        setDefaultLocation(latitude: 37.497, longitude: 127.0254)
        
        guard let gestureRecognizers = mapView?.gestureRecognizers else { return }
        for (index, gesture) in gestureRecognizers.enumerated() {
            if index == 0 {
                mapView?.removeGestureRecognizer(gesture)
            }
        }
    }
    
    @objc private func searchLocation() {
        let viewController = GMSAutocompleteViewController()
        viewController.delegate = self
        present(viewController, animated: true, completion: nil)
    }
}

extension AddressAutocompleteViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        updateLocation(place: place)
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        
        print(error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
