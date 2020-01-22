//
//  BarChartView.swift
//  BarChart
//
//  Created by Bunty on 21/01/20.
//  Copyright © 2020 Bunty. All rights reserved.
//

import Foundation
import UIKit

class BarChartView: UIView {
    
    // bar colors
    public var bottomColor = UIColor.init(red: 255/255.0, green: 162/255.0, blue: 23/255.0, alpha: 1)
    public var topColor = UIColor.init(red: 0/255.0, green: 153/255.0, blue: 255/255.0, alpha: 1)
    public var gridBGColor = UIColor(white: 240/255.0, alpha: 0.3)
    
    // bar
    public var topGap = 15.0
    public var barWidth = 25.0
    public var barGap = 14.0
    
    // grid lines
    public var showGridLines = true
    public var gridLineColor = UIColor.lightGray
    
    // x label
    public var xLabelHeight = 30.0
    public var xLabelWidth = 28.0
    public var xLabelFont = UIFont(name: "Helvetica", size: 9)
    public var xLabelColor = UIColor.lightGray
    
    // y label
    public var yLabelHeight = 30.0
    public var yLabelWidth = 38.0
    public var yLabelGap = 12.0
    public var yLabelPrefix = "$"
    public var yLabelDecimalPlaces = 2
    public var yLabelFont = UIFont(name: "Helvetica", size: 9)
    public var yLabelColor = UIColor.lightGray
    
    // animation
    public var animateDuration = 0.5
    public var animateDelay = 0.1
    
    // data
    private var arrData: [[String:Any]] = []
    
    private var maxValueData = 0.0
    private var spacerColor = UIColor.init(white: 0, alpha: 0)
    private var arrBars: Array<Any> = []

    
    // Process the data and find the maximum value
    func maxValueInData() -> Double {
        var max = 0.0;
        for i in 0..<self.arrData.count {
            let dct = self.arrData[i];
            let v1 = dct["v1"] as? Double ?? 0
            let v2 = dct["v2"] as? Double ?? 0
            let total = v1 + v2
            if (total > max) {
                max = total;
            }
        }
        
        return max;
    }
    
    // Add the lables on Y axis
    func addLeftLabels()  {
        
        let numberOfParts = 8.0;
        var value = 0.0;
        let scale: Double = maxValueData/numberOfParts;
        
        let tx = 4.0;
        let gapBetweenYLabelAndLines = 1;
        let txLine = tx + yLabelWidth + Double(gapBetweenYLabelAndLines);
        
        let tempHeight = Double(self.frame.size.height)
        let vH = (tempHeight-topGap) - xLabelHeight; //frame.size.height -= topGap;
        let tyGap = vH / numberOfParts;

        var tyLine = vH + topGap; // frame.origin.y = topGap;
        var ty = tyLine - (yLabelHeight*0.5);

        // line width
        var frame = self.frame;
        frame.size.width -= 45 + 8;
        
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = yLabelDecimalPlaces
        numberFormatter.minimumFractionDigits = yLabelDecimalPlaces
        
        for _ in 0..<Int(numberOfParts+1)
        {
            let lblTitle = UILabel(frame: CGRect(x: tx, y: ty, width: yLabelWidth, height: yLabelHeight))
            lblTitle.font = yLabelFont
            lblTitle.text = String(format: "%@%@",
                                   yLabelPrefix,
                                   numberFormatter.string(from: NSNumber(value: value)) ?? "")
            
            lblTitle.textAlignment = .left;
            lblTitle.textColor = yLabelColor
            lblTitle.numberOfLines = 0;
            self.addSubview(lblTitle)
            
            // add the grid lines
            if (showGridLines) {
                let v = UIView(frame: CGRect(x: txLine, y: tyLine,
                                             width: Double(frame.size.width),
                                             height: Double(1/UIScreen.main.scale)))
                v.backgroundColor = gridLineColor
                self.addSubview(v)
            }
            
            
            ty -= tyGap;
            //tyLine -= (yLabelHeight + yLabelGap);
            tyLine -= tyGap;
            value += scale;
        }
    }

    // Add the vertical bars
    func addBars(vBars: UIScrollView) {
        
        let colors = [
            spacerColor,
            topColor,
            bottomColor
        ]
        
        let frame = vBars.frame
        let vH = Double(frame.size.height) - xLabelHeight
        if (maxValueData == 0) {
            maxValueData = 1
        }
        var ratio = Double(vH/maxValueData);
        //NSLog(@"maxValueData = %.2f vH = %.2f ratio = %f", _maxValueData, vH, ratio);
        //NSLog(@"height = %f", self.frame.size.height);
        
        if ratio == 0 {
            ratio = 1
        }
        
        let fullWidth = Double(frame.size.width)
        var totalBarsWidth = Double(self.arrData.count) * barWidth
        totalBarsWidth += Double(self.arrData.count-1) * barGap;
        var tx = (fullWidth - Double(totalBarsWidth)) * 0.5;
        
        if (tx < 0) {
            tx = 0;
        }
        
        let halfGap = (barWidth - xLabelWidth)*0.5;
        
        for i in 0..<self.arrData.count
        {
            let dct = self.arrData[i]
            let v1 = dct["v1"] as? Double ?? 0
            let v2 = dct["v2"] as? Double ?? 0
            let total = v1 + v2
            let v0 = maxValueData - total
            let heights = [v0, v2, v1]
            var ty = vH - (maxValueData*ratio)
            
            // Container of 3 vertical bars
            let vBar = UIView(frame: CGRect(x: tx, y: ty, width: barWidth, height: maxValueData * ratio))
            //vBar.backgroundColor = UIColor.green
            vBar.clipsToBounds = true;
            vBars.addSubview(vBar)
            self.arrBars.append(vBar)
            
            // add 3 vertical bars of different colors
            for j in 0..<3 {
                let actualH = heights[j] * ratio;
                let v = UIView(frame: CGRect(x: 0, y: ty, width: barWidth, height: actualH))
                v.backgroundColor = colors[j]
                vBar.addSubview(v)
                
                ty += actualH;
            }
            
            // Add the lables on X axis
            let lblTitle = UILabel(frame: CGRect(x: tx+halfGap, y: ty, width: xLabelWidth, height: xLabelHeight))
            lblTitle.font = xLabelFont
            //lblTitle.backgroundColor = UIColor.green
            lblTitle.text = dct["label"] as? String ?? ""
            lblTitle.textAlignment = .center;
            lblTitle.textColor = xLabelColor
            lblTitle.numberOfLines = 0;
            vBars.addSubview(lblTitle)
            
            tx += barWidth + barGap;
        }
        
        vBars.contentSize = CGSize(width: tx + 45, height: 0)
    }

    // Do clean up before rendering the chart again
    func cleanUp() {
        self.arrData.removeAll()
        self.arrBars.removeAll()
        
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
    
    // Start showing the vertical bars for given data
    func show(arrData: [[String:Any]]) {
        
        self.cleanUp()
        self.arrData = arrData
        maxValueData = self.maxValueInData()
        self.addLeftLabels()
            
        var frame = self.frame
        frame.origin.x = 45
        frame.origin.y = CGFloat(topGap)
        frame.size.height -= CGFloat(topGap)
        frame.size.width -= frame.origin.x + 10
        //frame.size.height -= xLabelHeight
            
        let vBars = UIScrollView(frame: frame)
        vBars.backgroundColor  = gridBGColor
        //vBars.backgroundColor = UIColor.red
        vBars.clipsToBounds = true
        self.addSubview(vBars)
            
        self.addBars(vBars: vBars)
            
        // show bars with animation
        for vBar in self.arrBars as! [UIView] {
            frame = vBar.frame
            let height = frame.size.height
            frame.origin.y = frame.size.height
            frame.size.height = 0
            vBar.frame = frame
    
            UIView.animate(withDuration: animateDuration, delay: animateDelay, options: .curveEaseInOut, animations: {
                var frame = vBar.frame;
                frame.origin.y = 0;
                frame.size.height = height;
                vBar.frame = frame;
            }) { (_) in
                
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
  
    private func setupView() {
        
    }
}


