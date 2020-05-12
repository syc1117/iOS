//
//  ViewController.swift
//  ScrollViewExample
//
//  Created by giftbot on 2020. 01. 05..
//  Copyright © 2020년 giftbot. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var imageView: UIImageView!
    
    private var zoomScale: CGFloat = 1.0 {
        didSet {
            print("Current Zoom Scale :", String(format: "%.2f", zoomScale))
        }
    }
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateScrollViewZoomScale()
        scrollView.delegate = self
        // ScrollView에 딱 맞는 사이즈가 되어도 스크롤 가능, bounce 효과. 가로세로 별도
        scrollView.alwaysBounceVertical = true //alwaysBounce는 더이상 스크롤할게 없을때 바운스 효과를 주고 false로 하면 이러 바운스 효과가 없다.
        scrollView.alwaysBounceHorizontal = true
    }
    
    private func updateScrollViewZoomScale() {
        let widthScale = view.frame.width / imageView.bounds.width
        let heightScale = view.frame.height / imageView.bounds.height
        let minScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 3
        scrollView.zoomScale = 1 //?????
    }
    
    // MARK: Action Handler
    
    @IBAction private func fitToWidth(_ sender: Any) {
        print("\n---------- [ fitToWidth ] ----------")
        zoomScale = scrollView.frame.width / imageView.bounds.width //scrollView의 가로 사이즈를 이미지의 가로사이즈로 나누겠다. 예) 이지지가 스크롤뷰보다 3배 크다면은 여기서 는 0.3333이 된다.
        scrollView.setZoomScale(zoomScale, animated: true)
    }
    
    @IBAction private func scaleDouble(_ sender: Any) {
        print("\n---------- [ scaleDouble ] ----------")
        scrollView.setZoomScale(zoomScale * 2, animated: true)
        zoomScale = scrollView.zoomScale
        // 실제 값과 최종 scrollview의 zoomScale 값이 다르다
        // scrollView의 zoomscale은 maximum/minimumZoomScale에서 정한 값을 벗어나지 않는다
        
        // 특정 위치 rect 영역을 zoom해서 보여주기
        // zoom scale은 자동으로 설정
        let rectToVisible = CGRect(x: 100, y: 100, width: 200, height: 300)
        scrollView.zoom(to: rectToVisible, animated: true)
    }
    
    @IBAction private func moveContentToLeft(_ sender: Any) {
        print("\n---------- [ moveContentToLeft ] ----------")
        let newOffset = CGPoint(x: scrollView.contentOffset.x + 150,
                                y: scrollView.contentOffset.y)
        scrollView.setContentOffset(newOffset, animated: true)
    }
}

// MARK:- UIScrolLViewDelegate

extension ViewController: UIScrollViewDelegate {
    // Zoom할 view를 설정해 줘야 함
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 스크롤 할 때 마다 연속적으로 호출됨
    }
}
