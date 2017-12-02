//
//  ViewController.swift
//  Silly Song
//
//  Created by Trevor Lindsay on 11/30/17.
//  Copyright © 2017 Trevor Lindsay. All rights reserved.
//

import UIKit
import Foundation


let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joined(separator: "\n")


func shortNameFromName(name: String) -> String {
    let vowels = CharacterSet(charactersIn: "aeiou")
    let name = name.lowercased().folding(options: .diacriticInsensitive, locale: .current)
    
    if let range = name.rangeOfCharacter(from: vowels) {
        let shortName = String(name.characters.suffix(from: range.lowerBound))
        return shortName
    } else {
        return ""
    }
}


func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    let shortName = shortNameFromName(name: fullName)
    
    let lyrics = lyricsTemplate
        .replacingOccurrences(of: "<FULL_NAME>", with: fullName)
        .replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
    
    return lyrics
}

class ViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
    }
    
    @IBAction func displayLyrics(_ sender: Any) {
        if (nameField.text != "") {
            lyricsView.text = lyricsForName(
                lyricsTemplate: bananaFanaTemplate,
                fullName: nameField.text!)
        }
    }
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

