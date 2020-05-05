//
//  TableViewAccessoryType.swift
//  TableViewPractice
//
//  Created by giftbot on 2019/12/05.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

final class TableViewAccessoryType: UIViewController {
  
  /***************************************************
   - 미리 정해진 동물의 이미지와 텍스트를 테이블뷰에 표현
   - 각 셀의 크기는 80
   - 셀을 선택하면 체크박스가 나타나고 다시 선택하면 체크표시가 해제되도록 구현
   
   도전 과제)
   테이블뷰의 각 셀을 위아래로 스크롤 했다가 다시 나타낼 때, 체크 표시가 기존에 했던 곳에 정확히 다시 나타나도록 구현
   ***************************************************/
  
 override var description: String { "Task 2 - AccessoryType" }
    
    let animals = [
      "bear", "buffalo", "camel", "dog", "elephant",
      "koala", "llama", "panda", "lion", "horse",
      "guinea_pig", "koala", "whale_shark", "whale", "duck",
      "seagull", "black_swan", "peacock", "giraffe"
    ]
    var checked: [Bool] = []
    
    override func viewDidLoad() {
      super.viewDidLoad()
      checked = Array<Bool>(repeating: false, count: animals.count)
      
      let tableView = UITableView(frame: view.frame)
      tableView.dataSource = self
      tableView.delegate = self
      tableView.rowHeight = 80
      tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellID")
      view.addSubview(tableView)
    }
  }


  extension TableViewAccessoryType: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let animal = animals[indexPath.row]
      
      let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath)
      cell.textLabel?.text = animal
      cell.imageView?.image = UIImage(named: animal)
      cell.accessoryType = checked[indexPath.row] ? .checkmark : .none
      return cell
    }
  }


  extension TableViewAccessoryType: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      guard let cell = tableView.cellForRow(at: indexPath) else { return }
      cell.accessoryType = (cell.accessoryType == .checkmark) ? .none : .checkmark
        
      checked[indexPath.row].toggle()
    }
  }
