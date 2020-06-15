//
//  ViewController.swift
//  WeatherForecast
//
//  Created by 신용철 on 2020/03/06.
//  Copyright © 2020 신용철 All rights reserved.
//

import UIKit
import CoreLocation

extension UIViewController {
    func showAlert(message: String){
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let oKAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(oKAction)
        present(alert, animated: true, completion: nil)
    }
}

class ViewController: UIViewController {
    
    let tempFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.minimumFractionDigits = 0 //소수점이 0이면 미출력
        f.maximumFractionDigits = 1 //소수점 최대 1자리 출력
        return f
    }()
    
    let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "Ko_kr")
        return f
    }()
    
    let backgroundImageView = UIImageView()
    let headerView = UIView()
    let dimmingView = UIView()
    let headerLabel = UILabel()
    let tableView = UITableView()
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews([backgroundImageView, dimmingView, headerView, tableView])
        headerView.addSubview(headerLabel)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none // 셀 구분 선 삭제
        tableView.showsVerticalScrollIndicator = false // 스크롤 삭제
        
        setupUI()
        autoLayout()
        
        locationManager.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FirstTableViewCell.self, forCellReuseIdentifier: "FirstCell")
        tableView.register(SecondTableViewCell.self, forCellReuseIdentifier: "SecondCell")
    }
    
    // MARK: 테이블뷰 첫번째 셀의 위쪽 여백 추가 하기
    //func viewDidLayoutSubviews()에 설정하는 이유: viewDidLoad()에서는 view가 형성되지 않기 때문에 tableView의 셀 높이에 접근할 수 없음.
    var trueFalse = true
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //trueFalse을 사용하는 이유: viewDidLayoutSubviews()은 실시간으로 계속 반영되기 때문에 최초 한번만 적용되게 하기 위함. 이를 하지 않을 경우 아래 heigt값이 스크롤 할 때마다 연속적으로 변경되어 고정되지 않고 아래로 사라짐.
        if trueFalse == true {
        let height = tableView.frame.height - (tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.frame.height ?? 0)//테이블뷰 전체 높이 - 첫번째 셀 높이
        tableView.contentInset = .init(top: height, left: 0, bottom: 0, right: 0)
            trueFalse = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        headerLabel.text = "업데이트 중..."
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .authorizedAlways, .authorizedWhenInUse:
                locationManager.startUpdatingLocation()
            default:
                showAlert(message: "위치정보 사용 권한 미설정")
            }
        } else {
            showAlert(message: "위치정보 사용할 수 없음")
        }
    }
}



extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
        return 1
        } else {
        return WeatherDataSource.shared.forcastList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell
        
        if indexPath.section == 0 {
            guard let firstCell = tableView.dequeueReusableCell(withIdentifier: "FirstCell", for: indexPath) as? FirstTableViewCell else { return UITableViewCell()}
            if let data = WeatherDataSource.shared.summary?.weather.minutely.first {
                firstCell.imgView.image = UIImage(named: data.sky.code)
                firstCell.status.text = data.sky.name
                
                let maxTemperature = tempFormatter.string(for: Double(data.temperature.tmax) ?? 0.0) ?? ""
                let minTemperature = tempFormatter.string(for: Double(data.temperature.tmin) ?? 0.0) ?? ""
                
                let currentTemperature = tempFormatter.string(for: Double(data.temperature.tc) ?? 0.0) ?? ""
                
                firstCell.subStatus.text = "최대\(maxTemperature)º/ 최소\(minTemperature)º"
                firstCell.temperature.text = "\(currentTemperature)º"
            }
           cell = firstCell
        
        } else {
            guard let secondCell = tableView.dequeueReusableCell(withIdentifier: "SecondCell", for: indexPath) as? SecondTableViewCell else { return UITableViewCell()}
                                                
           let target = WeatherDataSource.shared.forcastList[indexPath.row]
            
            self.dateFormatter.dateFormat = "M.d (E)"
            secondCell.subStatus.text = dateFormatter.string(for: target.date)
            
            self.dateFormatter.dateFormat = "HH:00"
            secondCell.totalStatus.text = dateFormatter.string(for: target.date)
            
            secondCell.imgView.image = UIImage(named: target.skyCode)
            
            secondCell.status.text = target.skyName
            
            secondCell.temperature.text = "\(tempFormatter.string(for: target.temperature) ?? "-")º"
            
            cell = secondCell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 180
        } else {
            return 80
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            CLGeocoder().reverseGeocodeLocation(location) { (placeMarks, error) in
                if let place = placeMarks?.first{
                    if let gu = place.locality,  let dong = place.subLocality {
                        self.headerLabel.text = "\(gu) \(dong)"
                    } else {
                        self.headerLabel.text = place.name
                    }
                }
            }
            WeatherDataSource.shared.fetch(location: location) {
                self.tableView.reloadData()
            }
        }
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        showAlert(message: error.localizedDescription)
        manager.stopUpdatingLocation()
    }
}

extension ViewController {
    
    func setupUI(){
        backgroundImageView.image = UIImage(named: "sunny")
        
        headerView.backgroundColor = .clear
        
        headerLabel.text = "Label"
        headerLabel.textColor = .white
        headerLabel.textAlignment = .center
        headerLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        dimmingView.backgroundColor = .black
        dimmingView.alpha = 0.4
    }
    
    func autoLayout(){
        backgroundImageView.layout.top(equalTo: view.topAnchor).bottom(equalTo: view.bottomAnchor).leading(equalTo: view.leadingAnchor).trailing(equalTo: view.trailingAnchor)
        
        headerView.layout.top().leading().trailing()
        headerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        headerLabel.layout.top().leading().trailing()
        
        tableView.layout.top(equalTo: headerView.bottomAnchor).bottom().leading().trailing()
        
        dimmingView.layout.top().top(equalTo: view.topAnchor).bottom(equalTo: view.bottomAnchor).leading(equalTo: view.leadingAnchor).trailing(equalTo: view.trailingAnchor)
    }
}


