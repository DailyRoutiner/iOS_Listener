//
//  HomeContentView.swift
//  Listener
//  Seongjun Choi
//

import UIKit

class HomeContentView: UIView {

    var internalController: ViewController
    required init?(coder: NSCoder) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        internalController = vc
        
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        let view = internalController.view
        view?.frame = .init(x: 0, y: -88, width: self.frame.width, height: self.frame.height)
        self.addSubview(view!)
    }
}
