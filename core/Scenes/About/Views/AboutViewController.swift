//
//  AboutViewController.swift
//  core
//
//  Created by Doan Duy Phuong on 03/10/2021.
//

import UIKit

class AboutViewController: ViewController<AboutViewModel> {

    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var versionLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ColorPalette.background
        self.navigationTitle = "About"
        self.contentLbl.text = "All film related metadata used in our application, including movie credits, director, actor, release dates, trailer and poster art is supplied by TMDb. Our application uses TMDb APIs but is not endorsed or certified by TMDb."
        self.contentLbl.numberOfLines = 0
        
        let backButton = LumiKitBackButton.init(frame: .zero)
        let leftBarButton = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = leftBarButton
        backButton.addTarget(self,
                             action: #selector(AboutViewController.backAction),
                             for: .touchUpInside)
        
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        var fullText = "Version: " + (version ?? "")
        fullText += "\n\n @ Copyright by DoanPhuong 2021"
        self.versionLbl.text = fullText
        self.versionLbl.numberOfLines = 0
    }
    
    @objc private func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
