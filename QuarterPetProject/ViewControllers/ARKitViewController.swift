//
//  ARKitViewController.swift
//  QuarterPetProject
//
//  Created by Kirill Fokov on 27.09.2021.
//

import UIKit

class ARKitViewController: UIViewController {
    /// Initializing ARKit view
    private lazy var arKitView: ARKitView = {
        let view = ARKitView()
        view.delegate = self
        return view
    }()
    /// Model to show type
    private var modelType: ARKitModel
    /// Init
    init(type: ARKitModel) {
        self.modelType = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view = arKitView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ARKitViewController: ARKitViewDelegate {
    func didTapPlayButton() {
        self.arKitView.arView.scene.anchors.removeAll()
        self.arKitView.loadingIndicator.startAnimating()
        
        if self.modelType == .robot {
            ProjectModelComposer.loadRobotAsync(completion: { result in
                do {
                    let scene = try result.get()
                    self.arKitView.arView.scene.anchors.append(scene)
                    self.arKitView.loadingIndicator.stopAnimating()
                } catch {
                    self.arKitView.loadingIndicator.stopAnimating()
                    print("Error while loading robot \(result)")
                    let alert = UIAlertController(title: "Error", message: "Problem occured, during description updating.", preferredStyle: UIAlertController.Style.alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action:UIAlertAction) in
                        alert.dismiss(animated: true, completion: nil)
                    }))
                }
            })
        } else if self.modelType == .drummer {
            ProjectModelComposer.loadDrummerAsync(completion: { result in
                do {
                    let scene = try result.get()
                    self.arKitView.arView.scene.anchors.append(scene)
                    self.arKitView.loadingIndicator.stopAnimating()
                } catch {
                    self.arKitView.loadingIndicator.stopAnimating()
                    print("Error while loading robot \(result)")
                    let alert = UIAlertController(title: "Error", message: "Problem occured, during description updating.", preferredStyle: UIAlertController.Style.alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action:UIAlertAction) in
                        alert.dismiss(animated: true, completion: nil)
                    }))
                }
            })
        } else {
            ProjectModelComposer.loadOrphanAsync(completion: { result in
                do {
                    let scene = try result.get()
                    self.arKitView.arView.scene.anchors.append(scene)
                    self.arKitView.loadingIndicator.stopAnimating()
                } catch {
                    self.arKitView.loadingIndicator.stopAnimating()
                    print("Error while loading robot \(result)")
                    let alert = UIAlertController(title: "Error", message: "Problem occured, during description updating.", preferredStyle: UIAlertController.Style.alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action:UIAlertAction) in
                        alert.dismiss(animated: true, completion: nil)
                    }))
                }
            })
        }
//        switch self.modelType {
//        case .robot:
//
//        case .drummer:
//
//        case .gromophone:
//
//        }
    }
    
    func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
}
