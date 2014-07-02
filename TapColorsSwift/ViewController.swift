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
    
    var colorCombination: UIColor[] = UIColor[]()
    let colorPalletCombination: UIColor[] = [UIColor.redColor(), UIColor.blueColor(), UIColor.greenColor(), UIColor.yellowColor()]
    var position: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.newGame()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // go next problem
    func newGame() {
        position = 0
        colorCombination = self.produceColorCombination()
        self.makeLabelsFromArray(colorCombination)
    }
    
    func makeLabelsFromArray(array: Array<UIColor>) {
        var x: CGFloat = 40
        var y: CGFloat = 60
        for var i: Int = 0; i < array.count; i++ {
            let rect = CGRectMake(x, y, 60, 60);
            var label = UILabel(frame: rect)
            label.tag = i + 101
            label.backgroundColor = array[i]
            self.view.addSubview(label)
            x += 60 + 5
            if i == 0 {
                label.layer.borderColor = UIColor.blackColor().CGColor
                label.layer.borderWidth = 5.0
            }
        }
    }
    
    func produceColorCombination() -> UIColor[] {
        
        colorCombination = [UIColor(), UIColor(), UIColor(), UIColor()]
        
        for var i: Int = 0; i < 4; i++ {
            colorCombination[i] = colorPalletCombination[Int(arc4random_uniform(UInt32(4)))]
        }
        
        return colorCombination;
    }
    
    @IBAction func buttonPressed(button: UIButton) {
        // check color
        if colorCombination[position] == button.backgroundColor {
            let label: UILabel = self.view.viewWithTag(position + 101) as UILabel
            label.removeFromSuperview()
            
            if position < 3 {
                
                let targetLabel: UILabel = self.view.viewWithTag(position + 102) as UILabel
                targetLabel.layer.borderColor = UIColor.blackColor().CGColor
                targetLabel.layer.borderWidth = 5.0
            }
            
            position++
        }
        
        // if combination becomes empty, go next game
        if position == 4 {
            self.newGame()
        }
    }
}
