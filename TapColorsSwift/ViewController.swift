//
//  ViewController.swift
//  TapColorsSwift
//
//  Created by Ken Tominaga on 6/28/14.
//  Copyright (c) 2014 Tommy. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    private var colorCombination = [UIColor]()
    private let colorPalletCombination: [UIColor] = [.redColor(), .blueColor(), .greenColor(), .yellowColor()]
    private var position: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        newGame()
    }
    
    // go next problem
    private func newGame() {
        position = 0
        colorCombination = produceColorCombination()
        makeLabelsFromArray(colorCombination)
    }
    
    private func makeLabelsFromArray(array: [UIColor]) {
        var x: CGFloat = 40
        let xSkip: CGFloat = 65
        let y: CGFloat = 60
        for (i, color) in array.enumerate() {
            let rect = CGRectMake(x, y, 60, 60);
            let label = UILabel(frame: rect)
            label.tag = i + 101
            label.backgroundColor = color
            view.addSubview(label)
            x += xSkip
            if i == 0 {
                label.layer.borderColor = UIColor.blackColor().CGColor
                label.layer.borderWidth = 5.0
            }
        }
    }
    
    private func produceColorCombination() -> [UIColor] {
        
        return Array(0 ..< 4).map {_ in colorPalletCombination[Int(arc4random_uniform(UInt32(4)))]}
    }
    
    @IBAction private func buttonPressed(button: UIButton) {
        // check color
        if colorCombination[position] == button.backgroundColor {
            let label = view.viewWithTag(position + 101) as! UILabel
            label.removeFromSuperview()
            
            position++
            
            if position < 4 {
                
                let targetLabel = view.viewWithTag(position + 101) as! UILabel
                targetLabel.layer.borderColor = UIColor.blackColor().CGColor
                targetLabel.layer.borderWidth = 5.0
            }
        }
        
        // if combination becomes empty, go next game
        if position == 4 {
            newGame()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
