//
//  RendererOverlayViewController.swift
//  MapKitExample
//
//  Created by giftbot on 2020. 1. 5..
//  Copyright © 2020년 giftbot. All rights reserved.
//

import MapKit
import UIKit
//맵 위에 원하는 표식을 남기는 것
final class RendererOverlayViewController: UIViewController {
  
  @IBOutlet private weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }
    
  //mapView의 중앙에 지름 40000의 원을 표기
  //MKMapViewDelegate의 rendererFor overlay 함수에서 MKCircleRenderer로 커스터마이징 한 후 반환해야 표기됨
  @IBAction func addCircle(_ sender: Any) {
    let center = mapView.centerCoordinate
    let circle = MKCircle(center: center, radius: 40000)
    mapView.addOverlay(circle)
  }
  //mapView에 원하는 그림을 만들어서 배치하기
  //포인트들을 설정해서 MKPolyline으로 이어주는 방식
  //MKMapViewDelegate의 rendererFor overlay 함수에서 MKPolylineRenderer로 커스터마이징 한 후 반환해야 표기됨
  @IBAction func addStar(_ sender: Any) {
    let center = mapView.centerCoordinate
    var point1 = center; point1.latitude += 0.65
    var point2 = center; point2.longitude += 0.4;   point2.latitude -= 0.15
    var point3 = center; point3.longitude -= 0.45;  point3.latitude += 0.4
    var point4 = center; point4.longitude += 0.45;  point4.latitude += 0.4
    var point5 = center; point5.longitude -= 0.4;   point5.latitude -= 0.15
    let points: [CLLocationCoordinate2D] = [point1, point2, point3, point4, point5, point1]
    let polyline = MKPolyline(coordinates: points, count: points.count)
    mapView.addOverlay(polyline)
  }
  
  @IBAction private func removeOverlays(_ sender: Any) {
    mapView.removeOverlays(mapView.overlays)
  }
}

extension RendererOverlayViewController: MKMapViewDelegate {
    //overlay 디자인해주는 delegate 함수
    //addCircle()에서 mapView.addOverlay(circle)를 하면 overlay 파라미터로 circle이 들어옴.
    //overlay를 circle 타입으로 캐스팅 한 후 편집사용
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let circle = overlay as? MKCircle {
            let renderer = MKCircleRenderer(overlay: circle)
            renderer.strokeColor = UIColor.black
            renderer.lineWidth = 2
            return renderer
        }
        
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(overlay: polyline)
            renderer.strokeColor = .red
            renderer.lineWidth = 2
            return renderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
}
