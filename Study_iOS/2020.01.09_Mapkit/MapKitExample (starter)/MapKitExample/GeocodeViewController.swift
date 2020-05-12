//
//  GeocodeViewController.swift
//  MapKitExample
//
//  Created by giftbot on 2020. 1. 5..
//  Copyright © 2020년 giftbot. All rights reserved.
//

/* 학습목표
 1. UITapGestureRecognizer 를 활용하여 touchPoint를 mapView상의 좌표로 변환할 수 있다
 2. CLGeocoder의 사용법을 안다.
   - 좌표 -> 위경도 -> 주소변환
   - 주소 -> 위경도 변환
 */

/* 과제
1. mapView위를 클릭 했을 때 해당 지역의 주소를 인쇄.
  - UITapGestureRecognizer 사용
  - CLGeocoder().reverseGeocodeLocation 사용
2. 주소값을 위경도로 변환.*/

import MapKit
import UIKit

final class GeocodeViewController: UIViewController {

  @IBOutlet private weak var mapView: MKMapView!
  
  @IBAction func recognizeTap(gesture: UITapGestureRecognizer) {
    //mapView위에 UITapGestureRecognizer 올려놓고 맵을 탭하는 좌표를 지도상 좌표로 변환
    //변환된 지도상 좌표를 지표명으로 변환: CLGeocoder, reverseGeocodeLocation 활용
    let touchPoint = gesture.location(in: gesture.view)//터치포인트
    let coordinatePoint = mapView.convert(touchPoint, toCoordinateFrom: mapView)//터치포인트를 지도상 좌표로 변환(CLLocationCoordinate2D)
    let location = CLLocation(latitude: coordinatePoint.latitude, longitude: coordinatePoint.longitude) //지도상 좌표를 CLLocation정보로 변환
    reverseGeocode(location)
  }
    func reverseGeocode(_ location: CLLocation){
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { (placeMark, error) in
            print("위경도 주소") //???location파라미터는 CLLocation을 한개 받는데 여기에 들어있는 placeMark는 [CLPlacemark]? 타입. 한개의 CLLocation에 여러개의 CLPlacemark가 들어오는것 같은데 이게 무슨 경우?
            if error != nil {
                return print(error!.localizedDescription)
            }
            
            //국가별로 주소체계에 따라 다른 값을 가지기 때문에 아래 guard문에서 없는 값이 있을 경우 특정 나라는 클릭해도 정보가 print되지 않을 수 있음.
            guard let address = placeMark?.first, //placeMark:[CLPlacemark]?
                let country = address.country,
                let administrativeArea = address.administrativeArea,
                let locality = address.locality,
                let name = address.name else { return }
             let addr = "\(country) \(administrativeArea) \(locality) \(name)"
              print(addr)
        }
    }
    //주소 -> 위경도
    func geocodeAddressString(_ addressString: String) {
     print("\n---------- [ 주소 -> 위경도 ] ----------")
     let geocoder = CLGeocoder()
     geocoder.geocodeAddressString(addressString) { (placeMark, error) in
      if error != nil {
       return print(error!.localizedDescription)
      }
      guard let place = placeMark?.first else { return }
      print(place)
       
      // 위경도값 가져오기
      print(place.location?.coordinate)
     }
    }
}
