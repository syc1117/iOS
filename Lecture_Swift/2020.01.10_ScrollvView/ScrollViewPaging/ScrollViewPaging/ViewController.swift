//
//  ViewController.swift
//  ScrollViewPaging
//
//  Created by giftbot on 2020. 01. 05..
//  Copyright © 2020년 giftbot. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
  
  /***************************************************
   Frame 기반의 ScrollView 구현
   ***************************************************/
   
  private let pageControl = UIPageControl()
  private let scrollView = UIScrollView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  private func setupUI() {
    scrollView.frame = view.frame
    scrollView.delegate = self
    scrollView.isPagingEnabled = true
    view.addSubview(scrollView)
    
    let pageColors: [UIColor] = [.red, .blue, .gray, .magenta]
    for pageColor in pageColors {
      addPageToScrollView(with: pageColor)
    }
    
    pageControl.frame = CGRect(
      x: view.frame.midX, y: view.frame.height - 70, width: 0, height: 0
    )
    view.addSubview(pageControl)
  }
  
  private func addPageToScrollView(with color: UIColor) {
    let pageFrame = CGRect(
      origin: CGPoint(x: scrollView.contentSize.width, y: 0),
      size: scrollView.frame.size
    )
    print(scrollView.contentSize.width)
    let colorView = UIView(frame: pageFrame)
    colorView.backgroundColor = color.withAlphaComponent(0.6)
    scrollView.addSubview(colorView)
    
    scrollView.contentSize.width += view.frame.width
    pageControl.numberOfPages += 1
  }
}


// MARK: - UIScrollViewDelegate

extension ViewController: UIScrollViewDelegate {
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
    pageControl.currentPage = page
  }
}
