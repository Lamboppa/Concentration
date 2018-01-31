//
//  ConcentrationThemeChooserViewController.swift
//  concentration
//
//  Created by MonsterHulk on 2018-01-29.
//  Copyright © 2018 AmazingEric. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController {

    let themes = [
        "Emoji":"👻🎃🤖🤯🧟‍♂️🧛🏻‍♂️🦇🕸",
        "Animals":"🐱🐹🐼🐰🐻🐶🐷🐸",
        "Faces":"😃😆😍😇🤪😘😡😵",
        "Foods":"🥐🍔🍕🥪🍣🌭🍟🍜",
    ]
    
//    @IBAction func changeTheme(_ sender: Any) {
//        if let cvc = splitViewDetailConcentrationViewController {
//            if let theneName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
//                cvc.theme = theme
//            }
//        } else {
//        performSegue(withIdentifier: "Choose Theme", sender: sender)
//        }
//    }
//    
//    private var splitViewDetailConcentrationViewController: ConcentrationViewController? {
//        return splitViewController?.viewControllers.last as? ConcentrationViewController
//    }
    
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            //if let button = sender as? UIButton {
            //if let themeName = button.currentTitle
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                }
            }
        }
        
    }

}
