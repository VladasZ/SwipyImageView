//
//  SwipyImageView.swift
//  SwipyImageView
//
//  Created by Vladas Zakrevskis on 2/13/17.
//  Copyright © 2017 Vladas Zakrevskis. All rights reserved.
//

import UIKit

let DOTS_SPACING:CGFloat = 9
let DOT_SIZE:CGFloat = 8
let UNSELECTED_DOT_ALPHA:CGFloat = 0.32

public class SwipyImageView : UIView, UIScrollViewDelegate {
    
    static var fromNib:SwipyImageView {
        
        return viewNamed("SwipyImageView") as! SwipyImageView
    }
    
    //MARK: - Outlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackViewWidth: NSLayoutConstraint!
    @IBOutlet weak var stackView: UIStackView!
    
    //MARK: - Variables
    
    private var dots = [UIView]()
    private var imageViews = [UIImageView]()
    
    private var expectedIndex:Int {
        get {
            return Int(scrollView.contentOffset.x / frame.size.width)
        }
    }
    
    var images:[UIImage]! = nil {
        didSet {
            
            scrollView.contentSize = CGSize(width: frame.size.width * CGFloat(images.count), height: 0)
            
            for i in 0...images.count - 1 {
                
                let dot = newDot
                
                stackView.addArrangedSubview(dot)
                dots.append(dot)
                
                let imageView = UIImageView(frame: CGRect(x: 0,
                                                          y: 0,
                                                          width: self.frame.size.width,
                                                          height: self.frame.size.height))
                
                imageView.contentMode = .scaleAspectFit
                imageView.image = images[i]
                imageView.frame.origin.x = self.frame.size.width * CGFloat(i)
                imageViews.append(imageView)
                
                scrollView.addSubview(imageView)
            }
            
            dots.first!.alpha = 1
            
            stackViewWidth.constant = calculateStackWidth()
        }
    }
    
    private func calculateStackWidth() -> CGFloat {
        
        let dotsSpacing = DOTS_SPACING * CGFloat(images.count - 1)
        let dotsSize    = DOT_SIZE     * CGFloat(images.count)
        return dotsSpacing + dotsSize
    }
    
    private var newDot:UIView {
        
        let dot = UIView(frame: CGRect(x:0, y:0, width: DOT_SIZE, height: DOT_SIZE))
        dot.circle()
        dot.backgroundColor = UIColor.black
        dot.alpha = UNSELECTED_DOT_ALPHA
        
        return dot
    }
    
    //MARK: - Layout
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollView.frame = self.frame
        
        scrollView.contentSize = CGSize(width: self.frame.size.width * CGFloat(images.count),
                                        height: 0)
        
        for i in 0...images.count - 1 {
            
            imageViews[i].frame = CGRect(x:self.frame.size.width * CGFloat(i),
                                         y:0,
                                         width:self.frame.size.width,
                                         height:self.frame.size.height)
        }
    }
    
    //MARK: - UIScrollViewDelegate
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        dots.forEach { dot in dot.alpha = UNSELECTED_DOT_ALPHA }
        dots[expectedIndex].alpha = 1
    }
    
}
