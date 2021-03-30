//
//  IndicatorView.swift
//  HeaderViewWithIndicator
//
//  Created by admin on 2021/3/29.
//

import UIKit

class IndicatorView: UIView {
    
    // MARK:  Initialization
    private let indicatorLayer = CALayer()
    private var fromValue: CGFloat = 0
    private var width: CGFloat!
    private var itemsCount: CGFloat!
    
    // MARK: Life cycle
    init(count: Int) {
        super.init(frame: .zero)
        self.itemsCount = CGFloat(count)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    // MARK: Configure UI
    override func draw(_ rect: CGRect) {
        let itemWidth: CGFloat = rect.width / itemsCount

        indicatorLayer.bounds = CGRect(x: 0, y: 0, width: itemWidth, height: rect.height)
        indicatorLayer.position = CGPoint(x: 0, y: 0)
        indicatorLayer.anchorPoint = .zero
        indicatorLayer.contentsGravity = .center
        indicatorLayer.backgroundColor = UIColor.blue.cgColor
        indicatorLayer.cornerRadius = 2
        indicatorLayer.shadowOffset = CGSize(width: 0, height: 1)
        indicatorLayer.allowsEdgeAntialiasing = true
        indicatorLayer.allowsGroupOpacity = true
        indicatorLayer.fillMode = .forwards
        indicatorLayer.cornerRadius = rect.height / 2
        
        self.layer.addSublayer(indicatorLayer)
    }
    
    // MARK: - Animation
    func animate(to item: Int) {
        let itemWidth = frame.width / itemsCount
        let toValue = CGFloat(item)  * itemWidth
        let positionXAnimation = CABasicAnimation()
        positionXAnimation.beginTime = self.layer.convertTime(CACurrentMediaTime(), from: nil) + 0.0001
        positionXAnimation.duration = 0.5
        positionXAnimation.fillMode = .forwards
        positionXAnimation.isRemovedOnCompletion = false
        positionXAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        positionXAnimation.keyPath = "position.x"
        positionXAnimation.fromValue = fromValue
        positionXAnimation.toValue = toValue
        indicatorLayer.add(positionXAnimation, forKey: "positionXAnimation")
        fromValue = toValue
    }
}
