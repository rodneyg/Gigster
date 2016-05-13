
//  Original Code from: http://stackoverflow.com/questions/26578023/animate-drawing-of-a-circle

// Modified by Christian Hagel. All mistakes mine :-)
// Modified by Rodney :)

import UIKit

class CircleView: UIView {
    
    var circleLayer: CAShapeLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
        
        // Use UIBezierPath as an easy way to create the CGPath for the layer.
        // The path should be the entire circle.
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - 10)/2, startAngle: 0.0, endAngle: CGFloat(M_PI * 2.0), clockwise: true)
        
        // Setup the CAShapeLayer with the path, colors, and line width
        circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.CGPath
        circleLayer.fillColor = UIColor.clearColor().CGColor
        
        //I'm going to change this in the ViewController that uses this. Not the best way, I know but alas.
        circleLayer.strokeColor = UIColor.redColor().CGColor
        
        //You probably want to change this width
        circleLayer.lineWidth = 8.5;
        
        // Don't draw the circle initially
        circleLayer.strokeEnd = 0.0
        
        // Add the circleLayer to the view's layer's sublayers
        layer.addSublayer(circleLayer)
        
    }
    
    func setStrokeColor(color : CGColorRef) {
        circleLayer.strokeColor = color
    }
    
    // This is what you call if you want to draw a full circle.
    func animateCircle(duration: NSTimeInterval) {
        animateCircleTo(duration, fromValue: 0.0, toValue: 1.0)
    }
    
    // This is what you call to draw a partial circle.
    func animateCircleTo(duration: NSTimeInterval, fromValue: CGFloat, toValue: CGFloat){
        // We want to animate the strokeEnd property of the circleLayer
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        // Set the animation duration appropriately
        animation.duration = duration
        
        // Animate from 0 (no circle) to 1 (full circle)
        animation.fromValue = 0
        animation.toValue = toValue
        
        // Do an easeout. Don't know how to do a spring instead
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        // Set the circleLayer's strokeEnd property to 1.0 now so that it's the
        // right value when the animation ends.
        circleLayer.strokeEnd = toValue
        
        // Do the actual animation
        circleLayer.addAnimation(animation, forKey: "animateCircle")
    }
    
    
    // required function
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

