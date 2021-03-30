//
//  ViewController.swift
//  HeaderViewWithIndicator
//
//  Created by admin on 2021/3/29.
//

import UIKit

class ViewController: UIViewController, ButtonActionDelegate {
    
    private var headerIsOpen: Bool = false
    private let headerHeight: CGFloat = 50
    private lazy var headerConstraint = header.heightAnchor.constraint(equalToConstant: headerHeight)
    
    // MARK: UI Elements
    private lazy var header: HeaderView = {
        let view = HeaderView(items: ["First", "Last", "Third", "Fourth"], headerHeight: headerHeight)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var segmentControl: UISegmentedControl = {
        let items = ["First", "Second"]
        let segment = UISegmentedControl(items: items)
        segment.selectedSegmentIndex = 1
        segment.translatesAutoresizingMaskIntoConstraints = false
        return segment
    }()
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        configureHeader()
    }
    //MARK: Configure UI
    func configureHeader() {
        
        header.delegate = self
        
        view.addSubview(header)
        view.addSubview(segmentControl)
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            header.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            headerConstraint,
            
            segmentControl.topAnchor.constraint(equalTo: header.bottomAnchor),
            segmentControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            segmentControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            segmentControl.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    //MARK: Selectors
    func buttonTapped(_ sender: UIButton) {
        if sender.tag == 3 {
            headerIsOpen = true
        } else {
            headerIsOpen = false
        }
        headerConstraint.constant = headerIsOpen ? headerHeight * 2 : headerHeight
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
}
