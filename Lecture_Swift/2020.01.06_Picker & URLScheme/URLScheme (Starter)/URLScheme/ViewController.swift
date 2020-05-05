//
//  ViewController.swift
//  URLScheme
//
//  Created by giftbot on 2020. 1. 4..
//  Copyright © 2020년 giftbot. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
  
  @IBAction private func openSetting(_ sender: Any) {
    print("\n---------- [ openSettingApp ] ----------\n")
    //애플 설정창 열기
    guard let url = URL(string: UIApplication.openSettingsURLString),
        UIApplication.shared.canOpenURL(url)
        else { return }
    UIApplication.shared.open(url)
  }
  
  @IBAction private func openMail(_ sender: Any) {
    print("\n---------- [ openMail ] ----------\n")
    let scheme = "mailto:"
   // let scheme = "mailto:someone@mail.com, someone2@mail.com, someone3@mail.com" 특정 메일 검색
    // let scheme = "mailto:someone@mail.com?//참조cc=foo@bar.com&//제목subject=title&//내용body=MyText"
    guard let url = URL(string: scheme),
        UIApplication.shared.canOpenURL(url)
        else { return }
    UIApplication.shared.open(url)
  }

  @IBAction private func openMessage(_ sender: Any) {
    print("\n---------- [ openMessage ] ----------\n")
//    let finalURL = URL(string: "sms:010-9999-9999&body=Hello")!
    var urlComponents = URLComponents(string: "sms:010-9999-9999")!
    let a = URLQueryItem(name: "body", value: "안녕")
    urlComponents.queryItems?.append(a)
    let finalURL = urlComponents.url!
    
    guard UIApplication.shared.canOpenURL(finalURL) else { return }
    UIApplication.shared.open(finalURL)
  }
  
  @IBAction private func openWebsite(_ sender: Any) {
    print("\n---------- [ openWebsite ] ----------\n")
    let url = URL(string: "https://google.com")!
    guard UIApplication.shared.canOpenURL(url) else { return }
        
    UIApplication.shared.open(url)
  }
  
  @IBAction private func openFacebook(_ sender: Any) {
    print("\n---------- [ openFacebook ] ----------\n")
    //3rd파티 앱은 화이트리스트 등록이 필요함. 최초 1회 넘어갈 때 이동을 허락하면 이후부터는 바로 넘어감.
    
    /*화이트 리스트 등록 방법
     1. info.plist에서 마우스 오른쪽 클릭 -> Open As -> Source Code 들어가서
     2. 맨 아래 </dict> 위에 아래 내용 입력
     
    <key>LSApplicationQueriesSchemes</key>
    <array>
        <string>fb</string>
        <string>myApp</string>
    </array>
     
     3. 한 번 등록한 후 다른 것 추가는 inpo.plist에서 LSapplicationQueriesSchemes 클릭해서 + 버튼 누르고 이름 입력해주면 됨.
 */
    let url = URL(string: "fb:")!
    guard UIApplication.shared.canOpenURL(url) else { return } //이 코드문을 사용하지 않으면 화이트리스트 등록 없이 사용 가능
    UIApplication.shared.open(url)
  }
  
  @IBAction private func openMyApp(_ sender: Any) {
    print("\n---------- [ openMyApp ] ----------\n")
    
    
    
  }
}




