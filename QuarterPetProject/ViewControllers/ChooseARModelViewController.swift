//
//  ChooseARModelViewController.swift
//  QuarterPetProject
//
//  Created by Kirill Fokov on 27.09.2021.
//

import UIKit

/// Reality kir models types
enum ARKitModel {
    case robot
    case drummer
    case gromophone
}

class ChooseARModelViewController: UIViewController {
    /// Initializing  view
    private lazy var chooseARModelView: ChooseARModelView = {
        let view = ChooseARModelView()
        view.delegate = self
        return view
    }()
    override func loadView() {
        super.loadView()
        
        view = chooseARModelView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ChooseARModelViewController: ChooseARModelViewDelegate {
    func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func didTapRobotModelButton() {
        navigationController?.pushViewController(ARKitViewController(type: .robot), animated: true)
    }
    
    func didTapGramophoneButton() {
        navigationController?.pushViewController(ARKitViewController(type: .gromophone), animated: true)
    }
    
    func didTapDrummerButton() {
        navigationController?.pushViewController(ARKitViewController(type: .drummer), animated: true)
    }
}
