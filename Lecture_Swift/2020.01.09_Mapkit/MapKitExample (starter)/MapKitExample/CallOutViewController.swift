//
//  CallOutViewController.swift
//  MapKitExample
//
//  Created by 신용철 on 2020/01/20.
//  Copyright © 2020 giftbot. All rights reserved.
//

import SafariServices //사파리 인터넷 화면 띄우는 기능 제공
import UIKit
import MapKit

final class MuseumInfo: MKPointAnnotation {
    var exhibition: [String]!
    var phoneNumber: String!
    var url: URL!
}

class CallOutViewController: UIViewController {
    @IBOutlet private weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAnnotations()
        setRegion()
        mapView.delegate = self
    }
    func setRegion(){
        let coordinate = CLLocationCoordinate2DMake(37.5514, 126.9880)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
    }
    func setAnnotations(){
        let museum1 = MuseumInfo()
        museum1.title = "국립중앙박물관"
        museum1.coordinate = CLLocationCoordinate2DMake(37.523984, 126.980355)
        museum1.phoneNumber = "02-2077-9008"
        museum1.exhibition = ["고려건국 1100주년", "칸의 제국 몽골", "외규장각 의궤"]
        museum1.url = URL(string: "http://www.museum.go.kr")!
        
        let museum2 = MuseumInfo()
        museum2.title = "세종문화회관"
        museum2.coordinate = CLLocationCoordinate2DMake(37.572618, 126.975203)
        museum2.phoneNumber = "02-399-1000"
        museum2.exhibition = ["2018그랜드 Summer Classic", "사랑의 묘약"]
        museum2.url = URL(string: "http://www.sejongpac.or.kr")!
        
        mapView.addAnnotations([museum1, museum2])
    }
}

extension CallOutViewController: MKMapViewDelegate {
    //annotationView 디자인(tableViewCell CellForRowAt 과 같은기능)
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotaion = annotation as? MuseumInfo else { return nil}
        
        //annotation 파라미터: annotation관련한 정보들
        //MKAnnotationView : annotation정보들이 표현되는 객체(view)
        var annotationView: MKAnnotationView
        //정의된annotaionView가 있으면 재사용. 없으면 만들어라.tableViewCell하고 같은 개념
        if let reusable = mapView.dequeueReusableAnnotationView(withIdentifier: "MuseumID") {
            annotationView = reusable
        } else {
            annotationView = MKAnnotationView(annotation: annotaion, reuseIdentifier: "MuseumID")
        }
        annotationView.image = UIImage(named: "museum")
        //canShowCallout: annotationView를 클릭시 추가정보를 표시해줄지 말지
        annotationView.canShowCallout = true
        
        let infoButton = UIButton(type: .infoDark)
        //rightCalloutAccessoryView: 오른쪽에 추가
        annotationView.rightCalloutAccessoryView = infoButton
        infoButton.tag = 1
        
        
        let addButton = UIButton(type: .contactAdd)
        annotationView.leftCalloutAccessoryView = addButton
        addButton.tag = 0
        
        
        annotationView.frame.size.width += 25
        annotationView.frame.size.height += 25
        
        return annotationView
    }
    //annotationView를 클릭했을때 호출되는 함수.(tableView의 didselect랑 같은기능)
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation as? MuseumInfo else { return }
        print("\(annotation.title)")
    }
    
    // annotationView의 calloutAccessory 클릭했을 때 실행되는 함수
    // calloutAccessory: (annotationView클릭할때 위에 나타나는 말풍선)
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation as? MuseumInfo else { return }
        //버튼이 여러개일 경우 tag를 가지고 작업을 분리시키면 됨
        if control.tag == 1 {
        let safariVC = SFSafariViewController(url: annotation.url)
        present(safariVC, animated: true)
        }
    }
}
