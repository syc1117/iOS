//
//  CoordinatesAddressController.swift
//  googleMapExample
//
//  Created by 신용철 on 2020/02/06.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit
import GoogleMaps

class CoordinatesAddressController: UIViewController {
    
    private var mapView: GMSMapView?
    private var locationManager: CLLocationManager?
    private let coordinateAddressView = CoordinateAddressView(frame: .zero)
    private let defaultZoom: Float = 17
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Convert Coordinates to Address"
        
        configureLocationManager()
        configureGoogleMap()
        configureViews()
        configureCustomKeyboard()
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
    
    private func configureViews() {
        coordinateAddressView.delegate = self
        
        var coordinateAddressViewHeight: CGFloat = 0
        view.addSubview(coordinateAddressView)
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let windowHeight = appDelegate.window?.frame.height {
            coordinateAddressViewHeight = windowHeight
        }
        
        coordinateAddressView.translatesAutoresizingMaskIntoConstraints = false
        coordinateAddressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        coordinateAddressView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        coordinateAddressView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        coordinateAddressView.heightAnchor.constraint(equalToConstant: coordinateAddressViewHeight / 8).isActive = true
    }
    
    private func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestWhenInUseAuthorization()
    }
    
    private func setDefaultLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: defaultZoom)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        marker.title = "Default"
        marker.map = mapView
    }
    
    private func configureCustomKeyboard() {
        let toolBarKeyboard = UIToolbar()
        toolBarKeyboard.sizeToFit()
        let buttonflexBar = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let buttonDoneBar = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(keyboardDoneButtonClicked(_:)))
        toolBarKeyboard.items = [buttonflexBar, buttonDoneBar]
        toolBarKeyboard.tintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        coordinateAddressView.coordinateTextField.inputAccessoryView = toolBarKeyboard
    }
    
    @objc private func keyboardDoneButtonClicked(_ sender: Any) {
        self.view.endEditing(true)
    }
}

extension CoordinatesAddressController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation = locations[0].coordinate
        coordinateAddressView.coordinateTextField.text = "\(userLocation.latitude), \(userLocation.longitude)"
        manager.stopUpdatingLocation()
    }
}

extension CoordinatesAddressController: CoordinateAddressDelegate {
    func tappedLocationButton() {
        locationManager?.startUpdatingLocation()
    }
    
    func tappedSearch(text: String?) {
        guard let coordinates = convertTextToLocation(text: text) else { return }
        updateMap(coordinates: coordinates)
        view.endEditing(false)
    }
    
    private func convertTextToLocation(text: String?) -> CLLocationCoordinate2D? {
        
        guard
            let textArray = text?.replacingOccurrences(of: "", with: "").components(separatedBy: ","),
            let latitudeFloat = Float(textArray[0]),
            let longitudeFloat = Float(textArray[1]),
            let latitude = CLLocationDegrees(exactly: latitudeFloat),
            let longitude = CLLocationDegrees(exactly: longitudeFloat)
            else { return nil }
        
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    private func updateMap(coordinates: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: coordinates)
        mapView?.camera = GMSCameraPosition.camera(withLatitude: coordinates.latitude, longitude: coordinates.longitude, zoom: defaultZoom)
        marker.map = mapView
        
        let geoCoder = GMSGeocoder()
        geoCoder.reverseGeocodeCoordinate(coordinates) { (response, error) in
            if let address = response?.results()?.first {
                marker.title = "Latitude: \(address.coordinate.latitude.rounded()), Longitude: \(address.coordinate.longitude.rounded())"
                marker.snippet = address.thoroughfare
            }
        }
    }
}
