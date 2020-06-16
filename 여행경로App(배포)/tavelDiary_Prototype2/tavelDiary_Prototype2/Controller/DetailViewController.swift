//
//  DetailViewController.swift
//  tavelDiary_Prototype2
//
//  Created by 신용철 on 2020/02/24.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController, UITableViewDataSource {
    
    let mapView = UIView()
    let map = MKMapView()
    let toolBar = UIToolbar()
    let tableView = UITableView()
    
    //mainView에서 cell의 index에 해당하는 데이터를 저장
    var data: Data?
    var annotationArray: [MKPointAnnotation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        settupMap()
        setupToolbar()
        
    }
    
    // MARK: 수정버튼 클릭(right navigationBarButtonItem)
    @objc func didTouchFixButton(){
        
        guard let data = self.data else { return }
        let wcv = WriteViewController()
        
        defer {
            self.navigationController?.pushViewController(wcv, animated: true)
        }
        
        wcv.data = self.data
        
        //UI 세팅값 입력
        
        wcv.titelTextField.text = data.tripTitle
        
        if data.startingDate.isEmpty {
            wcv.schedulStartButton.setTitle("여행 시작일을 설정하세요!", for: .normal)
            wcv.schedulStartButton.setTitleColor(.lightGray, for: .normal)
        } else {
            wcv.schedulStartButton.setTitle(data.startingDate, for: .normal)
            wcv.schedulStartButton.setTitleColor(.black, for: .normal)
        }
        
        if data.endDate == "" {
            wcv.scheduleEndButton.setTitle("여행 종료일을 설정하세요!", for: .normal)
            wcv.scheduleEndButton.setTitleColor(.lightGray, for: .normal)
        } else {
            wcv.scheduleEndButton.setTitle(data.endDate, for: .normal)
            wcv.scheduleEndButton.setTitleColor(.black, for: .normal)
        }
        
        if data.navigationLabel == "" {
            wcv.pathContent.text = "여행경로를 설정하세요!"
            wcv.pathContent.textColor = .gray
//            wcv.pat.setTitle("여행경로를 설정하세요!", for: .normal)
//            wcv.pathButton.setTitleColor(.lightGray, for: .normal)
        } else {
            wcv.pathContent.text = data.navigationLabel
            wcv.pathContent.textColor = .black
            
//            wcv.pathButton.setTitle(data.navigationLabel, for: .normal)
//            wcv.pathButton.setTitleColor(.black, for: .normal)
        }
        
        //coreData 프로퍼티에 값 입력
        wcv.tripTitle = data.tripTitle
        wcv.startingDate = data.startingDate
        wcv.endDate = data.endDate
        wcv.distance = data.distance
        wcv.navigationPath = data.navigationLabel
        
        //for - in 에서 분리되어있던 annotation정보를 합쳐서 새로운 annotationArray 생성 후 writeView의 프로퍼티에 값 전달
        //여행 제목만 입력하는 등 일부 corData에 값이 없는 경우 out of index 에러 발생하기때문에 guard 설정
        guard data.titleArray != [] else { return }
        for index in 0...data.titleArray.count - 1 {
            let annotation = MKPointAnnotation()
            annotation.title = data.titleArray[index]
            annotation.coordinate.latitude = data.latitude[index]
            annotation.coordinate.longitude = data.longitude[index]
            self.annotationArray.append(annotation)
        }
        wcv.annotationArray = self.annotationArray
    }
    
    @objc func didSelectDeleteBarButton(){
        let alert = UIAlertController(title: "삭제확인", message: "정말 삭제하시겠습니까?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "삭제", style: .destructive){ (action) in
            DataBase.shared.deleteData(self.data)
            self.navigationController?.popToRootViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .default)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    @objc func didSelectSharingBarButton(){
       
        
        guard let data = self.data else { return }
        let plan = "안녕하세요. 여행계획을 공유 드립니다. \n 여행일정은\(data.startingDate) 부터 \(data.endDate)까지며, \n 여행코스는 [\(data.navigationLabel)] (총\(round((self.data?.distance ?? 0) / 1000))km) 입니다."
        let vc = UIActivityViewController(activityItems: [plan, takeScreenshot()], applicationActivities: nil)
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailViewCell
        if let data = self.data {
            cell.data = data
            cell.annotationArray = self.annotationArray
            cell.configure(data: data)
        }
        return cell
    }
    
   open func takeScreenshot(_ shouldSave: Bool = true) -> UIImage? {
       var screenshotImage :UIImage?
       let layer = UIApplication.shared.keyWindow!.layer
       let scale = UIScreen.main.scale
       UIGraphicsBeginImageContextWithOptions(view.frame.size, false, scale);
       guard let context = UIGraphicsGetCurrentContext() else {return nil}
       layer.render(in:context)
       screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
       UIGraphicsEndImageContext()
       if let image = screenshotImage, shouldSave {
           UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
       }
       return screenshotImage
   }
    
    func setupView(){
        view.addSubviews([toolBar, tableView, mapView])
        mapView.addSubview(map)
        map.layout.leading().trailing().bottom().top()
        self.tableView.dataSource = self
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.register(DetailViewCell.self, forCellReuseIdentifier: "cell")
        
        mapView.layout.top().leading().trailing().height(constant: view.frame.width)
        toolBar.layout.bottom().leading().trailing()
        tableView.layout.top(equalTo: mapView.bottomAnchor, constant: 20).leading().trailing().bottom(equalTo: toolBar.topAnchor)
    }
    
    func setupToolbar(){
        let removeBarButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didSelectDeleteBarButton))
        let sharingBarButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didSelectSharingBarButton))
        let flexibleSpacing = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        toolBar.setItems([flexibleSpacing, removeBarButton, flexibleSpacing, flexibleSpacing, sharingBarButton,flexibleSpacing], animated: true)
        let rightBarButton = UIBarButtonItem(title: "수정", style: .done, target: self, action: #selector(didTouchFixButton))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func settupMap(){
        map.showsTraffic = true
        map.showsScale = true
        map.showsBuildings = true
        map.delegate = self
        //        guard let annotation = self.data?.annotationArray else { return }
        addPolyLine()
    }
}

extension DetailViewController: MKMapViewDelegate {
    
    func addPolyLine(){
        guard let data = self.data else { return }
        //여행 제목만 입력하는 등 일부 corData에 값이 없는 경우 out of index 에러 발생하기때문에 guard 설정
        guard data.titleArray != [] else { return }
        var annotationArray: [MKPointAnnotation] = []
        for index in 0...data.titleArray.count - 1 {
            let anno = MKPointAnnotation()
            anno.title = data.titleArray[index]
            anno.coordinate.longitude = data.longitude[index]
            anno.coordinate.latitude = data.latitude[index]
            annotationArray.append(anno)
        }
        
        let coordinatePoint = CLLocationCoordinate2D(latitude: annotationArray[0].coordinate.latitude, longitude: annotationArray[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coordinatePoint, span: span)
        map.setRegion(region, animated: true)
        map.addAnnotations(annotationArray)
        
        let points = annotationArray.map { $0.coordinate }
        let polyLine = MKPolyline(coordinates: points, count: points.count)
        self.map.addOverlay(polyLine)
    }
    
    //기능: poly라인 커스터마이징
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polyLine = overlay as! MKPolyline
        let overlyaRenderer = MKPolylineRenderer(overlay: polyLine)
        overlyaRenderer.lineWidth = 1.5
        overlyaRenderer.strokeColor = .red
        return overlyaRenderer
    }
}

class DetailViewCell: UITableViewCell {
    
    var data: Data?
    var annotationArray: [MKPointAnnotation] = []
    
    let scheduleLabel2 = UILabel()
    let scheduleLabel = UILabel()
    let pathLabel = UILabel()
    let pathLabel2 = UILabel()
    let distanceLabel = UILabel()
    let distanceLabel2 = UILabel()
    let memoLabel = UILabel()
    let memoContent = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI() {
        addSubviews([scheduleLabel2, pathLabel2,distanceLabel2,scheduleLabel,pathLabel,distanceLabel, memoLabel, memoContent])
        
        scheduleLabel.layout.top(constant: 15).leading(constant: 10).width(constant: 70)
        
        scheduleLabel2.layout.centerY(equalTo: scheduleLabel.centerYAnchor).leading(equalTo: scheduleLabel.trailingAnchor, constant: 10).trailing(constant: -10)
        
        pathLabel.layout.top(equalTo:scheduleLabel2.bottomAnchor, constant: 20).leading(constant: 10).width(constant: 70)
        
        pathLabel2.layout.top(equalTo: pathLabel.topAnchor).leading(equalTo: pathLabel.trailingAnchor).trailing(constant: -10)
        
        distanceLabel.layout.top(equalTo:pathLabel2.bottomAnchor, constant: 25).leading(constant: 10).width(constant: 70)
        
        distanceLabel2.layout.top(equalTo: distanceLabel.topAnchor).leading(equalTo: distanceLabel.trailingAnchor).trailing(constant: -10)
        
        memoLabel.layout.top(equalTo:distanceLabel2.bottomAnchor, constant: 25).leading(constant: 10).width(constant: 70)
        
        memoContent.layout.top(equalTo:memoLabel.bottomAnchor, constant: 5).leading(constant: 20).bottom()
        
        [scheduleLabel, pathLabel,memoLabel, distanceLabel].forEach {
            addSubview($0)
            $0.textColor = .darkGray
            $0.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
            $0.setContentCompressionResistancePriority(.required, for: .horizontal)
            $0.setContentCompressionResistancePriority(.required, for: .vertical)
        }
        
        [scheduleLabel2, pathLabel2, memoContent,distanceLabel2 ].forEach {
            addSubview($0)
            $0.textColor = .black
            $0.lineBreakMode = .byWordWrapping
            $0.numberOfLines = 10
            $0.font = UIFont.systemFont(ofSize: 15, weight: .light)
            $0.setContentCompressionResistancePriority(.required, for: .horizontal)
            $0.setContentCompressionResistancePriority(.required, for: .vertical)
        }
        
        scheduleLabel.text = "여행일정:"
        scheduleLabel.font = UIFont.systemFont(ofSize: 18)
        pathLabel.text = "여행경로:"
        distanceLabel.text = "이동거리:"
        memoLabel.text = "메모"
    }
    
    func configure(data: Data){
        //        날짜가 없을 때 " ~ "가 표시되는 것을 막기 위함
        if !data.startingDate.isEmpty, !data.endDate.isEmpty {
            scheduleLabel2.text = "\(data.startingDate) ~ \(data.endDate)"
        }
        pathLabel2.text = data.navigationLabel
        distanceLabel2.text = "\(round((data.distance) / 1000))km"
        memoContent.text = data.memo
    }
}


