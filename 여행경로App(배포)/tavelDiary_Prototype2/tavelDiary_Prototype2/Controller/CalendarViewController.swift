//
//  CalendarViewController.swift
//  tavelDiary_Prototype2
//
//  Created by 신용철 on 2020/03/09.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController, MonthViewDelegate {
    
    // MARK: coreData에 저장하기 위한 변수
   
    
    let layout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    let monthView = MonthView()
    let weekView = WeekdaysView()
    
    
    //달력 날짜 구성을 위한 변수들
    var numOfDaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    var currentMonthIndex = 0
    var currentYear = 0
    var presentMonthIndex = 0
    var presentYear = 0
    var todaysDate = 0
    var firstWeekDayOfMonth = 0 //일 ~ 토 : 1 ~ 7
    
    //일정잡기
    var selectedDate = ""
    var selectedDateInt = 0
    var selectedMonthInt = 0
    var selectedYearInt = 0
    //일정표시
    let dateLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.textColor = .black
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 18)
        return lbl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightBarButton = UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(didTouchSaveButton))
        navigationItem.rightBarButtonItem = rightBarButton
        
        view.backgroundColor = .white
        setupCollectionView()
        setupUI()
        
        currentMonthIndex = Calendar.current.component(.month, from: Date())
        currentYear = Calendar.current.component(.year, from: Date())
        todaysDate = Calendar.current.component(.day, from: Date())
        firstWeekDayOfMonth = getFirstWeekDay()
        
        presentMonthIndex = currentMonthIndex
        presentYear = currentYear
        
        //윤년인 경우 2월달의 일수를 29일로 조정
        if currentYear % 4 == 0 {
            numOfDaysInMonth[1] = 29
        } else {
            numOfDaysInMonth[1] = 28
        }
    }
    
    @objc func didTouchSaveButton(){
        //새 여행 작성 시 viewControllers[1]
        if let wcv = self.navigationController?.viewControllers[1] as? WriteViewController
        {
        if self.title == "여행 시작일을 선택하세요" {
            wcv.startingDate = self.selectedDate
            wcv.schedulStartButton.setTitle(self.selectedDate, for: .normal)
            wcv.schedulStartButton.setTitleColor(.black, for: .normal)
            wcv.startSelectedDateInt = self.selectedDateInt
            wcv.startselectedMonthInt = self.selectedMonthInt
            wcv.startselectedYearInt = self.selectedYearInt
            navigationController?.popViewController(animated: true)
        } else if self.title == "여행 종료일을 선택하세요" {
            wcv.endDate = self.selectedDate
            wcv.scheduleEndButton.setTitle(self.selectedDate, for: .normal)
            wcv.scheduleEndButton.setTitleColor(.black, for: .normal)
            wcv.endSelectedDateInt = self.selectedDateInt
            wcv.endSelectedMonthInt = self.selectedMonthInt
            wcv.endSelectedYearInt = self.selectedYearInt
            navigationController?.popViewController(animated: true)
        }
        //수정 시 viewControllers[2]
        } else if let wcv2 = self.navigationController?.viewControllers[2] as? WriteViewController {
        if self.title == "여행 시작일을 선택하세요" {
            wcv2.startingDate = self.selectedDate
            wcv2.schedulStartButton.setTitle(self.selectedDate, for: .normal)
            wcv2.schedulStartButton.setTitleColor(.black, for: .normal)
            wcv2.startSelectedDateInt = self.selectedDateInt
            wcv2.startselectedMonthInt = self.selectedMonthInt
            wcv2.startselectedYearInt = self.selectedYearInt
            navigationController?.popViewController(animated: true)
        } else if self.title == "여행 종료일을 선택하세요" {
            wcv2.endDate = self.selectedDate
            wcv2.scheduleEndButton.setTitle(self.selectedDate, for: .normal)
            wcv2.scheduleEndButton.setTitleColor(.black, for: .normal)
            wcv2.endSelectedDateInt = self.selectedDateInt
            wcv2.endSelectedMonthInt = self.selectedMonthInt
            wcv2.endSelectedYearInt = self.selectedYearInt
            navigationController?.popViewController(animated: true)
        }
        }
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func didChangeMonth(monthIndex: Int, year: Int) {
        currentMonthIndex = monthIndex + 1
        currentYear = year
        
        //윤년인 경우 2월달의 일수를 29일로 조정
        if monthIndex == 1 {
            if currentYear % 4 == 0 {
                numOfDaysInMonth[monthIndex] = 29
            } else {
                numOfDaysInMonth[monthIndex] = 28
            }
        }
        //end
        
        firstWeekDayOfMonth = getFirstWeekDay()
        collectionView.reloadData()
        monthView.btnLeft.isEnabled = !(currentMonthIndex == presentMonthIndex && currentYear == presentYear)
    }
    
    func getFirstWeekDay() -> Int{
        let day = ("\(currentYear)-\(currentMonthIndex)-01".date?.firstDayOfTheMonth.weekday)!
        //return day == 7 ? 1 : day
        return day
    }
}

extension CalendarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numOfDaysInMonth[currentMonthIndex - 1] + firstWeekDayOfMonth - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! dateCVCell
        cell.backgroundColor = .clear
        if indexPath.item <= firstWeekDayOfMonth - 2 {
            cell.isHidden=true
        } else {
            let calcDate = indexPath.row - firstWeekDayOfMonth + 2
            cell.isHidden=false
            cell.lbl.text="\(calcDate)"
            if calcDate < todaysDate && currentYear == presentYear && currentMonthIndex == presentMonthIndex {
                cell.isUserInteractionEnabled = false
                cell.lbl.textColor = .lightGray
            } else {
                cell.isUserInteractionEnabled = true
                cell.lbl.textColor = .black
            }
        }
        return cell
    }
}

extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = .red
        
        let lbl = cell?.subviews[1] as! UILabel
        lbl.textColor = .white
        //선택된 cell의 날짜가자오기
        //원리: 선택된 셀의 index 2개를 가져와서 오름차순 정렬 시킨후 0인덱스값의 날짜를 첫째, 1인덱스 값의 날짜를 둘째가 되도록 설정함.
        guard let index = collectionView.indexPathsForSelectedItems else { return }
        let firstDate = index[0].row - firstWeekDayOfMonth + 2
        self.selectedDate = "\(monthView.lblName.text!) \(firstDate)일"
        self.selectedDateInt = firstDate
        self.selectedYearInt = monthView.currentYear
        self.selectedMonthInt = monthView.currentMonth
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell=collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor=UIColor.clear
        let lbl = cell?.subviews[1] as! UILabel
        lbl.textColor = .black
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/7 - 8
//        let height: CGFloat = 40
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

// MARK: UI 구성
extension CalendarViewController {
    func setupUI(){
        view.addSubviews([monthView, weekView, collectionView, dateLabel])
        
        monthView.layout.top(constant: 15).leading(constant: 15).trailing(constant: -15)
        monthView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        monthView.delegate = self
        
        weekView.layout.top(equalTo: monthView.bottomAnchor, constant: 5).leading(equalTo: monthView.leadingAnchor).trailing(equalTo: monthView.trailingAnchor)
        weekView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
       
        collectionView.layout.top(equalTo: weekView.bottomAnchor).leading(equalTo: weekView.leadingAnchor, constant: 4).trailing(equalTo: weekView.trailingAnchor, constant: -4)
        collectionView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        
        //시작, 종료 날짜 오토레이아웃
        dateLabel.layout.top(equalTo: collectionView.bottomAnchor, constant: 30).leading(equalTo: collectionView.leadingAnchor)
        dateLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(dateCVCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = .clear
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.allowsMultipleSelection = false
    }
}


// MARK: get first day of the month
extension Date {
    
    var weekday: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    
    var firstDayOfTheMonth: Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
    }
}

// MARK: get date from string
extension String {
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var date: Date? {
        return String.dateFormatter.date(from: self)
    }
}
