//
//  WelcomeViewController.swift
//  QuarterPetProject
//
//  Created by Kirill Fokov on 27.09.2021.
//

import Foundation
import UIKit

class WelcomeViewController: UIViewController {
    /// Initializing welcome view
    private lazy var welcomeView: WelcomeView = {
        let view = WelcomeView()
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
        
        view = welcomeView
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

extension WelcomeViewController: WelcomeViewDelegate {
    func didTapNextButton() {
        navigationController?.pushViewController(PickOptionViewController(), animated: true)
    }
}
