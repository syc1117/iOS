//
//  BasicAnnotationViewController.swift
//  MapKitExample
//
//  Created by giftbot on 2020. 1. 5..
//  Copyright © 2020년 giftbot. All rights reserved.
//

import MapKit
import UIKit
/*학습목표
 1. 맵뷰에 핀을 설치 할 수 있다. addAnnotation()
 2. 맵뷰에 설치된 핀들 중 랜덤으로 이동할 수 있다. moveToRandomPin()
 3. 맵뷰에 설치된 핀들을 일괄 제거 할 수 있다. removeAnnotation()
 4. 특정 위치에 mapCamera로 확대정도와 보여지는 각도를 조정할 수 있다. setupCamera()
 */
final class BasicAnnotationViewController: UIViewController {
  
  @IBOutlet private weak var mapView: MKMapView!
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    let center = CLLocationCoordinate2DMake(37.566308, 126.977948)
    setRegion(coordinate: center)
  }
  
  func setRegion(coordinate: CLLocationCoordinate2D) {
    let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    let region = MKCoordinateRegion(center: coordinate, span: span)
    mapView.setRegion(region, animated: true)
  }
  //특정 위경도에 핀 설치
  @IBAction private func addAnnotation(_ sender: Any) {
    let cityHall = MKPointAnnotation()
    cityHall.title = "시청"
    cityHall.subtitle = "서울특별시" //핀 클릭시에 추가로 표기됨
    cityHall.coordinate = CLLocationCoordinate2DMake(37.566308, 126.977948)
    mapView.addAnnotation(cityHall)
    let namsan = MKPointAnnotation()
    namsan.title = "남산"
    namsan.coordinate = CLLocationCoordinate2DMake(37.551416, 126.988194)
    mapView.addAnnotation(namsan)
    let gimpoAirport = MKPointAnnotation()
    gimpoAirport.title = "김포공항"
    gimpoAirport.coordinate = CLLocationCoordinate2DMake(37.559670, 126.794320)
    mapView.addAnnotation(gimpoAirport)
    let gangnam = MKPointAnnotation()
    gangnam.title = "강남역"
    gangnam.coordinate = CLLocationCoordinate2DMake(37.498149, 127.027623)
    mapView.addAnnotation(gangnam)
  }
  //설정된 핀 중에 랜덤으로 이동
  @IBAction private func moveToRandomPin(_ sender: Any) {
    guard !mapView.annotations.isEmpty else { return }
    //Int.random(in: ): in 안의 범주에서 랜덤한 Int값을 리턴
    let random = Int.random(in: 0..<mapView.annotations.count)
    let annotation = mapView.annotations[random]
    setRegion(coordinate: annotation.coordinate)
  }
  //설정한 핀 제거
  @IBAction private func removeAnnotation(_ sender: Any) {
    mapView.removeAnnotations(mapView.annotations)
  }
  //mapCamera: 지도에 보여지는 각도와 확대정도 설정
  @IBAction private func setupCamera(_ sender: Any) {
    let camera = MKMapCamera()
    camera.centerCoordinate = CLLocationCoordinate2DMake(37.498149, 127.027623)
    // 고도 (미터 단위)
    camera.altitude = 200
    // 카메라 각도(0일 때 수직으로 내려다보는 형태)
    camera.pitch = 70
    // 바라보는 각도(값이 올라갈 수록 시계 방향으로 값만큼 회전)
    camera.heading = 0
    mapView.setCamera(camera, animated: true)
  }
}
