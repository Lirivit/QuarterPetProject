//
//  MLViewController.swift
//  QuarterPetProject
//
//  Created by Kirill Fokov on 27.09.2021.
//

import UIKit
import AVKit
import Vision

class MLViewController: UIViewController {
    /// Initializing ml view
    private lazy var mlView: MLView = {
        let view = MLView()
        view.delegate = self
        return view
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view = mlView
    }
}

extension MLViewController: MLViewDelegate {
    func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
}
