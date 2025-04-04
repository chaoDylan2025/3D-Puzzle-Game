//
//  LevelViewController.swift
//  3D-Puzzle-Game
//
//  Created by Luke B. Dykstra on 4/1/25.
//

import UIKit

class LevelViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func goToMainMenu(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MainMenu", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func goToLevel1(_ sender: Any) {
        self.present(GameViewController(), animated: true, completion: nil)
    }
}
