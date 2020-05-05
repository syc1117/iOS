//
//  MyLocationViewController.swift
//  MapKitExample
//
//  Created by giftbot on 2020. 1. 5..
//  Copyright © 2020년 giftbot. All rights reserved.
//


/*기본 세팅
 1. import MapKit
 2. CLLocationManagerDelegate 채택 및 연결
 3. info.plist에 권한 부여 메세지 세팅 설정 3가지: AlwaysAndWhenInUse, Always, WhenInUse
 */

/* 작업 순서
 1. 권한 있는지 여부 확인 및 권한별 작업 내용 정의: checkAuthorizationStatus
 - 권한 부여 없으면 부여, 부여되어있으면 업데이트 실시
 2. 권한 변동 시 작업 내용 정의: didChangeAuthorization(델리게이트)
 3. 업데이트 실행: startUpdatingLocation
 4. 업데이트 된 정보 활용: didUpdateLocations (델리게이트)
 5. 기타 기능 구현
  1) 방향정보 모니터링: mornitoringHeading(가능여부 확인 및 실행) + didUpdateHeading(실행된 값 가져와서 활용, delegate)
  2) 이동 자취 표기: addAnnotation(location: CLLocation)
 */

/* 과제
 1. 내 위치를 표시해 주는 지도앱 만들고
 2. 내가 이동하는 경로의 자취를 화면상에 기록되도록 할 것 */
import MapKit
import UIKit

final class MyLocationViewController: UIViewController {
    
    @IBOutlet private weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        checkAuthorizationStatus()
        mapView.showsUserLocation = true // 현재 유저의 위치를 표시해줌. 이 명령문이 없으면 지도만 나옴.
       // 지도의 모드 변경. 기본값은 그림
    }
    
    //권한 부여 여부 확인
    func checkAuthorizationStatus() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined: //권한 확인 한번도 안한경우: when in use or always 권한 획득 하라고 코딩
            locationManager.requestWhenInUseAuthorization()
        //        locationManager.requestAlwaysAuthorization()
        case .restricted, .denied: break //비행기 모드 혹은 사용자가 권한 거부할 경우 중지
        case .authorizedWhenInUse: fallthrough
        case .authorizedAlways: startUpdatingLocation() //권한이 있는 경우 위치정보 업데이트 시행
        @unknown default: break
        }
    }
    
    func startUpdatingLocation() {
        let status = CLLocationManager.authorizationStatus()
        guard status == .authorizedAlways || status == .authorizedWhenInUse else { return }
        guard CLLocationManager.locationServicesEnabled() else { return }
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //정밀도 설정
        locationManager.distanceFilter = 10
        //10m 마다 정보 업데이트
        locationManager.startUpdatingLocation()
    }
    
    //방향정보 받아오기: delegate의 didUpdateHeading 함수와 함께 사용
    @IBAction func mornitoringHeading(_ sender: Any) {
        //Heading이 가능한지 확인 후 실행
        guard CLLocationManager.headingAvailable() else { return }
        locationManager.startUpdatingHeading()
    }
    //방향정보업데이트 종료
    @IBAction func stopMornitoring(_ sender: Any) {
        //locationManager.stopUpdatingLocation()는 일반위치정보 업데이트 종료시 사용
        locationManager.stopUpdatingHeading()
    }
}

extension MyLocationViewController: CLLocationManagerDelegate {
    //권한에 관련하여 변동사항이 있을 경우 뭘 해야할지 코딩
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("권한있음")
        default:
            print("권한없음")
        }
    }
    //업데이트 된 정보를 활용
    //startUpdatingLocation()을 하면 아래 함수의 locations: [CLLocation] 파라미터에 위치값(CLLocation)이 배열로 들어감.
    //이 파라미터를 통해 위치값을 활용하여 연산이 가능
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        let current = locations.last! //반드시 하나의 값을 들고 있기 때문에 강제바인딩해도 상관 없음
        if (abs(current.timestamp.timeIntervalSinceNow) < 10 ) {
            let coordinate = current.coordinate
        
        // span단위는 1도 (경도 1도는 약 111km)
        let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001) //숫자가 크면 큰범위를 다루고 작으면 작은 범위를 다룸. 즉, 작아야 크게 보임.
        let region = MKCoordinateRegion(center: coordinate, span: span) //어떤 지역을 보여줄 것인가. 여기서는 현재 위치 정보를 span의 크기로 보여주겠다.
        self.mapView.setRegion(region, animated: true)
        //이동하는 자취 남기는 함수
        addAnnotation(location: current)
        }
    }
    
    func addAnnotation(location: CLLocation) {
        let annotation = MKPointAnnotation()
        annotation.title = "MyLocation"
        annotation.coordinate = location.coordinate
        mapView.addAnnotation(annotation)
    }
    //아래 정보를 어떻게 활용 할지는 알아서 판단
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        print("trueHeading:", newHeading.trueHeading) // 실제 북쪽
        print("magneticHeading:", newHeading.trueHeading) // 나침반 북쪽
        print("values: \(newHeading.x),\(newHeading.y),\(newHeading.z)")
    }
}
