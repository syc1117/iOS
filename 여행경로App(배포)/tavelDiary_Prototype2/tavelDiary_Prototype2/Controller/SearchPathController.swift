//
//  SearchPathController.swift
//  tavelDiary_Prototype2
//
//  Created by 신용철 on 2020/03/09.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit
import MapKit

class SearchPathController: UIViewController {
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("여행경로  추가", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.lightGray, for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(didTouchAddButton), for: .touchUpInside)
        button.backgroundColor = #colorLiteral(red: 0.03751464561, green: 0.6536889672, blue: 0.0321896784, alpha: 0.5249625428)
        button.isHidden = true
        return button
    }()
    
    let resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("여행경로  초기화", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.lightGray, for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(didTouchResetButton), for: .touchUpInside)
        button.backgroundColor = #colorLiteral(red: 0.7423688467, green: 0.03026711286, blue: 0.1217629781, alpha: 0.4517069777)
        button.isHidden = true
        return button
    }()
    
    var mapView = MKMapView()
    var searchResults:[MKLocalSearchCompletion] = []
    var searchCompleter = MKLocalSearchCompleter()
    
    let distanceLabel = UILabel()
    let navigationLabel = UILabel()
    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    //맵에서 다른 목적지 검색할 때 사라지는 용도.
    let presentAnnotation = MKPointAnnotation()
    
    // MARK: coreData에 저장할 프로퍼티
    
    //경로 추가버튼 누르면 해당 annotation을 배열에 추가
    var annotationArray: [MKPointAnnotation] = []
    //annotation간 거리
    var distance: Double = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        let rightBarButton = UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(didTouchSaveButton))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    // MARK: 여행경로 초기화 버튼 구현 기능: data가 들어간 property 및 모든 오브젝트의 값 초기화
    @objc func didTouchResetButton(){
        
        let alert = UIAlertController(title: "여행경로 초기화", message: "여행경로를 초기화 하시겠습니까?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .default, handler: nil)
        let ok = UIAlertAction(title: "초기화", style: .destructive){ (action) in
            //화면에 표시되는 모든 객체들의 값 초기화
            self.distanceLabel.text = ""
            self.navigationLabel.text = ""
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.mapView.removeOverlays(self.mapView.overlays)
            
            //coreData에 저장하기 위해 생성한 프로퍼티에 저장된 값들 모두 초기화
            self.annotationArray = []
            self.distance = 0.0
            self.searchBar.text = nil
            
            //여행경로 추가, 초기화 버튼 숨김
            self.resetButton.isHidden = true
            self.addButton.isHidden = true
            
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    //기능: 코어데이터에 최종값 저장, 화면 dismiss
    @objc func didTouchSaveButton(){
        // 새 여행 작성시 viewControllers[1]
        if let wcv = self.navigationController?.viewControllers[1] as? WriteViewController
        {
            //coreData에 저장할 값들 이전화면 변수에 담기
            wcv.distance = self.distance
            wcv.annotationArray = self.annotationArray
            wcv.navigationPath = self.navigationLabel.text ?? ""
            
            wcv.pathContent.text = self.navigationLabel.text ?? ""
            wcv.pathContent.textColor = .black
            
            // 수정시 viewControllers[2]
        } else if let wcv2 = self.navigationController?.viewControllers[2] as? WriteViewController {
            wcv2.distance = self.distance
            wcv2.annotationArray = self.annotationArray
            wcv2.navigationPath = self.navigationLabel.text ?? ""
            
            //
            wcv2.pathContent.text = self.navigationLabel.text ?? ""
            wcv2.pathContent.textColor = .black
            
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    /*특정 두 지점 간 거리를 계산하는 방법,
     1. 사용 타입: CLLocation(위도, 경도)
     2. 공식: 뒤.distance(from:앞)
     3. for - in 반목을 사용해서, (index + 1).distance(from: index)
     */
    func calculateDistance(){
        guard self.annotationArray.count > 1 else { return }
        for index in 0...(self.annotationArray.count - 2) {
            let previous = CLLocation(latitude: self.annotationArray[index].coordinate.latitude, longitude: self.annotationArray[index].coordinate.longitude)
            let next = CLLocation(latitude: self.annotationArray[index + 1].coordinate.latitude, longitude: self.annotationArray[index + 1].coordinate.longitude)
            let distance = next.distance(from: previous)
            self.distance += distance
        }
    }
    /*기능:
     1. 현재 annotation을 유지
     2. 해당 annotation을 배열에 저장
     3. 거리계산
     4. label에 경로 표시
     5. polyLine 연결
     */
    @objc func didTouchAddButton(){
        
        guard let title = self.presentAnnotation.title else { return }
        let alert = UIAlertController(title: "여행경로 추가", message: "\(title)을 경로에 추가하시겠습니까?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "추가", style: .default){ (action) in
            
            //현재 annotation을 유지
            let annotation = MKPointAnnotation()
            annotation.title = self.presentAnnotation.title
            annotation.coordinate = self.presentAnnotation.coordinate
            self.mapView.addAnnotation(annotation)
            
            //추가한 annotation을 배열에 추가 -> 코어데이터 저장 + 폴리라인 생성 + 거리계산
            self.annotationArray.append(annotation)
            
            //label에 경로 표시
            self.navigationLabel.isHidden = false
            self.navigationLabel.text! += " ➤ \(title)"
            
            //polyLine 생성
            self.addPolyLine()
            
            //거리 계산
            self.calculateDistance()
            
            //서치바 초기화
            self.searchBar.text = nil
            
            //거리 표시 label 표시: 저장값이 2개이상일 경우
            if self.annotationArray.count > 1 {
                self.distanceLabel.text = "총 거리: \(round(self.distance / 1000))km"
                self.distanceLabel.isHidden = false
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .destructive, handler: nil)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}

extension SearchPathController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            self.tableView.isHidden = false
            searchCompleter.queryFragment = searchText
        } else {
            self.tableView.isHidden = true
        }
    }
}

extension SearchPathController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.searchResults = completer.results
        self.tableView.reloadData()
    }
}

extension SearchPathController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        if let reusalbeCell = tableView.dequeueReusableCell(withIdentifier: "cell")  {
            cell = reusalbeCell
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        
        cell.textLabel?.text = searchResults[indexPath.row].title  //장소명
        cell.detailTextLabel?.text = searchResults[indexPath.row].subtitle //상세주소
        
        return cell
    }
}

/*기능: 클릭시 해당 장소로 이동: 좌표값 필요
 줌 땡기고, annotation찍고, 테이블뷰 숨기고, 키보드 내려가고*/
extension SearchPathController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searching(searchResult: self.searchResults[indexPath.row])
        self.tableView.isHidden = true
        addButton.isHidden = false
        self.resetButton.isHidden = false
        
        searchBar.resignFirstResponder()
    }
    
    func searching(searchResult: MKLocalSearchCompletion ){
        let request = MKLocalSearch.Request(completion: searchResult) //굳이 비유하자면, URL
        let search = MKLocalSearch(request: request) // 굳이 비유하자면, DataTask
        search.start { [weak self] (response, error) in
            
            guard let strongSelf = self else { return }
            
            guard error == nil else { print("클라이언트 오류"); return }
            guard let placeMark = response?.mapItems[0].placemark else { print("서버통신 오류"); return }
            let coordinatePoint = placeMark.coordinate
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: coordinatePoint, span: span)
            strongSelf.mapView.setRegion(region, animated: true)
            
            strongSelf.presentAnnotation.coordinate = coordinatePoint
            strongSelf.presentAnnotation.title = searchResult.title
            strongSelf.mapView.addAnnotation(strongSelf.presentAnnotation)
        }
    }
}

//폴리라인 기능구현
extension SearchPathController: MKMapViewDelegate {
    
    func addPolyLine(){
        let points = annotationArray.map { $0.coordinate }
        let polyLine = MKPolyline(coordinates: points, count: points.count)
        self.mapView.addOverlay(polyLine)
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

extension SearchPathController {
    func setupUI(){
        view.backgroundColor = .white
        self.title = "여행경로 검색"
        mapView.delegate = self
        mapView.showsTraffic = true
        mapView.showsScale = true
        mapView.showsBuildings = true
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        searchCompleter.delegate = self
        //        searchCompleter.filterType = .locationsOnly
        view.addSubviews([searchBar, mapView, addButton,resetButton, distanceLabel, navigationLabel, tableView])
        
        tableView.isHidden = true
        tableView.layout.top(equalTo: searchBar.bottomAnchor).leading().trailing()
        tableView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        searchBar.layout.top().leading().trailing()
        searchBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
        mapView.layout.leading().trailing().bottom().top(equalTo: searchBar.bottomAnchor)
        addButton.layout.leading().bottom()
        addButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        resetButton.layout.leading(equalTo: addButton.trailingAnchor).bottom().trailing()
        resetButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        self.distanceLabel.text = ""
        distanceLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        distanceLabel.textColor = .black
        distanceLabel.layout.leading(equalTo: nil, constant: 10).bottom(equalTo: addButton.topAnchor, constant: -20)
        
        self.navigationLabel.text = ""
        navigationLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        navigationLabel.backgroundColor = .white
        navigationLabel.textColor = .black
        
        navigationLabel.isHidden = true
        navigationLabel.layout.leading().trailing().top(equalTo: searchBar.bottomAnchor, constant: 0)
        //        navigationLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        navigationLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        navigationLabel.numberOfLines = 10
        navigationLabel.lineBreakMode = .byWordWrapping
        
        searchBar.placeholder = "여행지를 검색하세요!"
    }
}
