//
//  ViewController.swift
//  Silly Song
//
//  Created by Kim Wayne on 5/23/17.
//  Copyright © 2017 Kim Wayne. All rights reserved.
//

import UIKit
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
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
        nameField.text?.capitalized
    }
    @IBAction func displayLyrics(_ sender: Any) {
        if nameField.text != "" {
            lyricsView.text = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: nameField.text!)
        }
    }

}

func shortNameFromName(_ name: String) -> String {
    var lowercaseName = name.lowercased()
    lowercaseName = lowercaseName.folding(options: .diacriticInsensitive, locale: nil)
    let vowelSet = CharacterSet(charactersIn: "AEIOUaeiou")
    
    if let firstVowelRange = name.rangeOfCharacter(from: vowelSet, options: .caseInsensitive) {
        return lowercaseName.substring(from: firstVowelRange.lowerBound)
    }
    
    // no vowels = return the full name
    return lowercaseName
}



func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    
    
    let shortName = shortNameFromName(fullName)
    
    let lyrics = lyricsTemplate
        .replacingOccurrences(of: "<FULL_NAME>", with: fullName)
        .replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
    
    return lyrics
    
}

//lyricsForName(lyricsTemplate: String, fullName: "Juliette")

// join an array of strings into a single template string:
let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joined(separator: "\n")
