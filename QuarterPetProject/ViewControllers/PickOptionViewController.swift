//
//  PickOptionViewController.swift
//  QuarterPetProject
//
//  Created by Kirill Fokov on 27.09.2021.
//

import UIKit

class PickOptionViewController: UIViewController {
    /// Initializing pick option view
    private lazy var pickOptionView: PickOptionView = {
        let view = PickOptionView()
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
        
        view = pickOptionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

extension PickOptionViewController: PickOptionViewDelegate {
    func didTapARButton() {
        navigationController?.pushViewController(ChooseARModelViewController(), animated: true)
    }
    
    func didTapMLButton() {
        navigationController?.pushViewController(MLViewController(), animated: true)
    }
}
