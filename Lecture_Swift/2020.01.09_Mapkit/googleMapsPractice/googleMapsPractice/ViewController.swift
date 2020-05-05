//
//  ViewController.swift
//  googleMapsPractice
//
//  Created by 신용철 on 2020/02/06.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps
import GooglePlaces

class ViewController: UIViewController {
    
    var camera = GMSCameraPosition(latitude:  -33.86, longitude: 151.20, zoom: 6)
    lazy var mapView = GMSMapView(frame: view.frame, camera: camera)
    var placesClient = GMSPlacesClient.shared()
    let nameOfPlace = UILabel()
    let addressLabel = UILabel()
    let locationManager = CLLocationManager()
    let button = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews([mapView,nameOfPlace,addressLabel,button])
        checkAuthorizationStatus()
        settingMark()
        
        nameOfPlace.layout.centerX().centerY()
        addressLabel.layout.centerX().centerY(constant: 20)
        button.layout.centerX().centerY(constant: 40)
        
        nameOfPlace.textColor = .black
        nameOfPlace.backgroundColor = .white
        addressLabel.textColor = .red
        addressLabel.backgroundColor = .white
        
        button.setTitle("내주소 가져오기", for: .normal)
        button.addTarget(self, action: #selector(getCurrentPace), for: .touchUpInside)
    }
    func checkAuthorizationStatus() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined: //권한 확인 한번도 안한경우: when in use or always 권한 획득 하라고 코딩
            locationManager.requestWhenInUseAuthorization()
        //        locationManager.requestAlwaysAuthorization()
        case .restricted, .denied: break //비행기 모드 혹은 사용자가 권한 거부할 경우 중지
        case .authorizedWhenInUse: fallthrough
        case .authorizedAlways: print("권한있음") //권한이 있는 경우 위치정보 업데이트 시행
        @unknown default: break
        }
    }
    
    func settingMark(){
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
    
    @objc func getCurrentPace(){
        placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
            if let error = error {
                print("Current Place error: \(error.localizedDescription)")
                return
            }
            
            self.nameOfPlace.text = "No current place"
            self.addressLabel.text = ""
            
            if let placeLikelihoodList = placeLikelihoodList {
                let place = placeLikelihoodList.likelihoods.first?.place
                if let place = place {
                    self.nameOfPlace.text = place.name
                    self.addressLabel.text = place.formattedAddress?.components(separatedBy: ", ")
                        .joined(separator: "\n")
                    
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
                    marker.title = "\(String(describing: place.name))"
                    marker.snippet = "\(String(describing: place.name))"
                    marker.map = self.mapView
                    
                    
                }
            }
        })
    }
}







