//
//  ViewController.swift
//  UIDeviceExample
//
//  Created by giftbot on 2020/01/28.
//  Copyright © 2020 giftbot. All rights reserved.
//

import UIKit

/***************************************************
 UIDevice
 - 디바이스 이름 / 모델 / 화면 방향 등
 - OS 이름 / 버전
 - 인터페이스 형식 (phone, pad, tv 등)
 - 배터리 정보
 - 근접 센서 정보
 - 멀티태스킹 지원 여부
 ***************************************************/


final class ViewController: UIViewController {
    
    @IBOutlet private weak var label: UILabel!
    let device = UIDevice.current // 싱글톤
    let notiCenter = NotificationCenter.default
    
    // MARK: 시스템 버전에 따라서 코딩을 달리해줘야 할 경우에 아래와 같이 version을 불러와서 조건문을 사용할 수 있음
    @IBAction private func systemVersion() {
        print("\n---------- [ System Version ] ----------\n")
        
        let systemVersion = UIDevice.current.systemVersion //13.3 등으로 표기됨
        let systemName = UIDevice.current.systemName // iOS로 표기됨.
        let systemSplitVersion = UIDevice.current.systemVersion.split(separator: ".").compactMap{Int($0)} //13.3.1 등으로 소수점자리까지 표기 됨.
        print(systemName)
        print(systemVersion)
        print(systemSplitVersion)
        
        //iOS의 여부를 판별하는 플래그들: Int타입으로 1이면 참 0이면 거짓
        if TARGET_OS_IOS == 1 {
            print("iOS")
        } else if TARGET_OS_MAC == 1 {
            print("Mac")
        } else if TARGET_OS_WATCH == 1 {
            print("Apple Watch")
        } else {
            print("Others")
        }
        
    }
    
    // MARK: 앱이 실행되는 환경이 어떤 것인지 구분할 때 사용(시뮬레이터인지, 휴대폰인지 등)
    @IBAction private func architecture() {
        print("\n---------- [ Architecture ] ----------\n")
        #if targetEnvironment(simulator)
        print("Simulator")
        #else
        print("Device")
        #endif
    }
    
    @IBAction private func deviceModel() {
        print("\n---------- [ Device Model ] ----------\n")
        print(device.name) //내 핸드폰에 설정한 이름. 시뮬레이터면 기기 이름
        print(device.model) // iPhone
        print(device.localizedModel) // 국가별로 다른 모델이 있는경우 모델명이 iPhone이 아닌 다른 것으로 나올 수도 있음.
        print(device.userInterfaceIdiom) //Phone, Pad, carplaym, tv, 확인불가 로 구분됨
        print(device.orientation) // 화면이 가로방향인지 세로 방향인지 표현
        print(device.isMultitaskingSupported) //Bool타입으로 요즘 기기들은 다 지원되고 있어서 별로 쓸일 없음.
        
        // MARK: Extension으로 UIDevice에 직접 코드로 추가한 명령어로 기기가 새로 출시 될 때마다 Extension내의 코드를 업데이트 해줘야 함.
        //iPhone 11의 경우 아래와 같이 입력할 경우 (extesion에 정의한 것:"iPhone12,1": "iPhone 11")
        print(device.identifier) // iPhone12,1로 나옴
        print(device.modelName) // iPhone 11 로 나옴
        
        print(device.simulatorModelName)
    }
    
    // MARK: - Battery
    
    @IBAction private func battery() {
        print("\n-------------------- [ Battery Info ] --------------------\n")
        //업데이트 등 할 때 베터리 잔량이 일정 수치 이상일 때만 작동하도록 할 때 사용
        print(device.batteryState) // 확인불가, 충전중, 충전중아님, 베터리 만땅 으로 구분됨
        /*
        public enum BatteryState : Int {
            case unknown
            case unplugged
            case charging
            case full
        }
        */
        print(device.batteryLevel) // 베터리 잔량 0 ~ 1 사이값을 가짐
        print(device.isBatteryMonitoringEnabled) //베터리 모니터링이 가능한지 여부 확인. 기본값은 false임. 이것을 true로 설정해 주어야 batteryLevel, batteryState를 확인할 수 있음.
    }
    
    @IBAction private func batteryMonitoring(_ sender: UIButton) {
        print("\n---------- [ batteryMonitoring ] ----------\n")
        sender.isSelected.toggle() // 아무 기능 아님. 무시
        device.isBatteryMonitoringEnabled = true
        
    }
    
    @objc func didChangeBatteryState(_ noti: Notification) {
        
    }
    
    
    // MARK: - Proximity State: 기본값 false. true로 하면 노치쪽에 뭔가 인식이 되면 화면이 꺼지고 물체가 다시 사라지면 화면이 다시 활성화 됨.(전화받을때 화면 꺼지는 것과 같은 기능임)
    
    @IBAction private func proximityMonitoring(_ sender: UIButton) {
        print("\n-------------------- [ Proximity Sensor ] --------------------\n")
        device.isProximityMonitoringEnabled.toggle()
        print( device.isProximityMonitoringEnabled)
    }
    
    @objc func didChangeProximityState(_ noti: Notification) {
    }
    
    
    // MARK: - Orientation Notification: 핸드폰의 방향을 탐지
    
    @IBAction private func beginOrientationNotification() {
        print(device.isGeneratingDeviceOrientationNotifications) // 탐지여부는 기본값이 true임.
        notiCenter.addObserver(self, selector: #selector(orientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    @objc func orientationDidChange(_ noti: Notification) {
        if let device = noti.object as? UIDevice {
            print(device.orientation)
        }
    }
    
    @IBAction private func endOrientationNotification() {
        device.endGeneratingDeviceOrientationNotifications() // 방향 탐지기능 끄기
        notiCenter.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }
}





