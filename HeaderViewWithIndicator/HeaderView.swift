//
//  HeaderView.swift
//  HeaderViewWithIndicator
//
//  Created by admin on 2021/3/29.
//

import UIKit

protocol ButtonActionDelegate: class {
    func buttonTapped(_ sender: UIButton)
}

class HeaderView: UIView {
    
    weak var delegate: ButtonActionDelegate?
    lazy var allButtons = Array<UIButton>()
    
    //MARK: UI Elements
    var indicatorView: IndicatorView!
    private var headerHeight: CGFloat!
    private var indicatorHeight: CGFloat!
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "arkit")?.withTintColor(.orange)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    //MARK: Life Cycle
    convenience init(items: [String], headerHeight: CGFloat, indicatorHeight: CGFloat = 5) {
        self.init(frame: .zero)
        self.indicatorView = IndicatorView(count: items.count)
        self.headerHeight = headerHeight
        self.indicatorHeight = indicatorHeight
        createButtons(items: items)
        configureUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: Configure UI
    private func configureUI() {
        let stackView = UIStackView(arrangedSubviews: allButtons)
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        allButtons.first?.isSelected = true
        
        addSubview(imageView)
        addSubview(indicatorView)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: headerHeight - indicatorHeight),
            
            indicatorView.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            indicatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            indicatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            indicatorView.heightAnchor.constraint(equalToConstant: indicatorHeight),
            
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -indicatorHeight),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: headerHeight), // any constant
            
        ])
    }
    
    private func createButtons(items: [String]) {
        for (index, text) in items.enumerated() {
            let button = UIButton()
            button.setTitle(text, for: .normal)
            button.setTitleColor(.gray, for: .normal)
            button.setTitleColor(.black, for: .selected)
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            button.tag = index
            button.backgroundColor = .white
            allButtons.append(button)
        }
    }
    
    //MARK: Selectors
    @objc private func buttonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(sender)
        allButtons.forEach { (button) in
            button.isSelected = false
        }
        sender.isSelected = true
        indicatorView.animate(to: sender.tag)
    }
}
