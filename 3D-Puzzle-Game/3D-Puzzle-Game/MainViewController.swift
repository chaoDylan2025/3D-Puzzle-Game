//
//  MainViewController.swift
//  3D-Puzzle-Game
//
//  Created by Luke B. Dykstra on 4/1/25.
//

import UIKit

class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func OnPlayButtonTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "LevelSelection", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LevelViewController")
        self.present(vc, animated: true, completion: nil)
    }
}
