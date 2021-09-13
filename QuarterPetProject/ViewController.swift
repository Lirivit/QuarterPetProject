//
//  ViewController.swift
//  QuarterPetProject
//
//  Created by Kirill Fokov on 12.09.2021.
//

import UIKit
import RealityKit
import SnapKit
import ARKit

class ViewController: UIViewController {
    
    private var arView: ARView = {
        let view = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
        return view
    }()

    private var playButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.addTarget(self, action: #selector(play), for: .touchUpInside)
        return button
    }()
    
    private var loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
       view.color = .white
       view.hidesWhenStopped = true
       return view
   }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        print(ARFaceTrackingConfiguration.isSupported)
        
        let arConfiguration = ARFaceTrackingConfiguration()
        arConfiguration.isLightEstimationEnabled = true
        
        arView.session.run(arConfiguration, options:[.resetTracking, .removeExistingAnchors])
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    private func setup() {
        
        view.addSubview(arView)
        arView.addSubview(playButton)
        arView.addSubview(loadingIndicator)
        
        arView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loadingIndicator.snp.makeConstraints { make in
            make.centerX.equalTo(arView)
            make.centerY.equalTo(arView)
        }
        
        playButton.snp.makeConstraints { make in
            make.centerX.equalTo(arView)
            make.bottom.equalTo(arView).offset(-10)
        }
        
        
    }
    
    @objc func play(sender: UIButton!) {
        self.arView.scene.anchors.removeAll()
        self.loadingIndicator.startAnimating()
        
        // If you want to test augment reality model change loadFaceTestAsync -> loadRobotAsync
        ProjectModelComposer.loadFaceTestAsync(completion: { result in
            do {
                let scene = try result.get()
                self.arView.scene.anchors.append(scene)
                self.loadingIndicator.stopAnimating()
            } catch {
                self.loadingIndicator.stopAnimating()
                print("Error while loading robot \(result)")
                let alert = UIAlertController(title: "Error", message: "Problem occured, during description updating.", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action:UIAlertAction) in
                    alert.dismiss(animated: true, completion: nil)
                }))
            }
        })
        }
}

