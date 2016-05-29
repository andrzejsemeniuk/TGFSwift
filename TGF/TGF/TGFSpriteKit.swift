//
//  TGFSwiftSpriteKit.swift
//  TGFFrankenbots
//
//  Created by andrzej semeniuk on 5/1/16.
//  Copyright © 2016 Tiny Game Factory LLC. All rights reserved.
//

import Foundation
import SpriteKit



typealias CGxy              = (x:CGFloat,y:CGFloat)





public struct CGProportion
{
    public var value:CGFloat = 0
    
    public func of      (length length:CGFloat) -> CGFloat              { return value * length }
    public func lerp    (from from:CGFloat,to:CGFloat) -> CGFloat       { return from + value * (to - from) }
    public func lerp01  (from from:CGFloat,to:CGFloat) -> CGFloat       { return min(1,max(0,from + value * (to - from))) }

    public func lerp    (from from:CGFloat,length:CGFloat) -> CGFloat   { return lerp(from:from,to:from + length) }
    public func lerp01  (from from:CGFloat,length:CGFloat) -> CGFloat   { return lerp01(from:from,to:from + length) }
}

public struct CGRatio
{
    public var h:CGFloat = 0
    public var v:CGFloat = 0

    func __conversion() -> (CGFloat, CGFloat)               { return (h, v) }
}

public func CGDegrees2Radians(angle:CGFloat) -> CGFloat     { return angle / 180.0 * Math.PI }
public func CGRadians2Degrees(angle:CGFloat) -> CGFloat     { return angle / Math.PI * 180.0 }

public func CGDegreesToRadians(angle:CGFloat) -> CGFloat    { return CGDegrees2Radians(angle) }
public func CGRadiansToDegrees(angle:CGFloat) -> CGFloat    { return CGRadians2Degrees(angle) }

public struct CGDegrees
{
    public let angle:CGFloat
    
    public init(angle:CGFloat) {
        self.angle = angle
    }
    public func toRadians   () -> CGFloat           { return CGDegrees2Radians(angle) }
    public func asCGRadians () -> CGRadians         { return CGRadians(angle:toRadians()) }
}

public struct CGRadians
{
    public let angle:CGFloat
    
    public init(angle:CGFloat) {
        self.angle = angle
    }
    public func toDegrees   ()  -> CGFloat          { return CGRadians2Degrees(angle) }
    public func asCGDegrees ()  -> CGDegrees        { return CGDegrees(angle:toDegrees()) }
}

public struct CGAngle
{
    private var angle:CGFloat
    
    public      init(degrees angle:CGFloat)         { self.angle = CGDegrees2Radians(angle) }
    public      init(radians angle:CGFloat)         { self.angle = angle }
    
    public func toDegrees   ()  -> CGFloat          { return CGRadians2Degrees(angle) }
    public func toRadians   ()  -> CGFloat          { return angle }
    
    public func asCGDegrees ()  -> CGDegrees        { return CGDegrees(angle:toDegrees()) }
    public func asCGRadians ()  -> CGRadians        { return CGRadians(angle:angle) }
}

extension CGPoint
{
    // NOTE: USE __conversion TO CONVERT TO TYPES
    func __conversion() -> (CGFloat, CGFloat)           { return (x, y) }
}

extension CGRect
{
    var midpoint            :CGPoint                { return pointFromRatio(0.5,0.5) }
    
    var tl:CGPoint      { return pointFromRatio(0,1) }
    var tr:CGPoint      { return pointFromRatio(1,1) }
    var bl:CGPoint      { return pointFromRatio(0,0) }
    var br:CGPoint      { return pointFromRatio(1,0) }
    var c:CGPoint       { return midpoint }
    
    var center:CGPoint  { return midpoint }
    
    var top     :CGFloat    { return origin.y + height }
    var left    :CGFloat    { return origin.x }
    var bottom  :CGFloat    { return origin.y }
    var right   :CGFloat    { return origin.x + width }

    func pointFromRatio         (x:CGFloat, _ y:CGFloat)    -> CGPoint { return CGPointMake(origin.x + width * x, origin.y + height * y) }
    func pointFromRatio         (ratio:CGxy)                -> CGPoint { return pointFromRatio(ratio.x,ratio.y) }
    
    func ratioFromPoint         (point:CGPoint)             -> CGPoint { return CGPointMake(width != 0.0 ? ((point.x - origin.x) / width) : 0.0, height != 0.0 ? ((point.y - origin.y) / height) : 0.0 ) }
}

extension CGSize
{
    var midpoint:CGPoint {
        return pointFromRatio(0.5,0.5)
    }
    
    var tl:CGPoint      { return pointFromRatio(0,1) }
    var tr:CGPoint      { return pointFromRatio(1,1) }
    var bl:CGPoint      { return pointFromRatio(0,0) }
    var br:CGPoint      { return pointFromRatio(1,0) }
    var c:CGPoint       { return midpoint }

    var center:CGPoint  { return midpoint }
    
    var top     :CGFloat    { return height }
    var left    :CGFloat    { return 0 }
    var bottom  :CGFloat    { return 0 }
    var right   :CGFloat    { return width }

    func pointFromRatio         (x:CGFloat, _ y:CGFloat)    -> CGPoint { return CGPointMake(width * x, height * y) }
    func pointFromRatio         (ratio:CGxy)                -> CGPoint { return pointFromRatio(ratio.x, ratio.y) }
    
    func ratioFromPoint         (point:CGPoint)             -> CGPoint { return CGPointMake(width != 0.0 ? (point.x / width) : 0.0, height != 0.0 ? (point.y / height) : 0.0 ) }
}

func UIScreenGetCenter() -> CGPoint {
    
    return CGPoint(x:UIScreen.mainScreen().bounds.width/2.0,
                   y:UIScreen.mainScreen().bounds.height/2.0)
}


struct CGScreen
{
    static var bounds:CGRect = CGRect(x:UIScreen.mainScreen().bounds.origin.x,
                                        y:UIScreen.mainScreen().bounds.origin.y,
                                        width:UIScreen.mainScreen().bounds.width * UIScreen.mainScreen().scale,
                                        height:UIScreen.mainScreen().bounds.height * UIScreen.mainScreen().scale)
    
    static var origin                                                   :CGPoint    { return bounds.origin }
    static var size                                                     :CGSize     { return bounds.size }
    static var width                                                    :CGFloat    { return size.width }
    static var height                                                   :CGFloat    { return size.height }
    static var scale                                                    :CGFloat    { return UIScreen.mainScreen().scale }
    
    
    static func diagonal                (fraction:CGFloat = 1.0)        -> CGFloat  { return TGF.Environment.Screen.diagonal(fraction) }

    static func pointFromRatio          (x:CGFloat, _ y:CGFloat)        -> CGPoint  { return bounds.pointFromRatio(x,y) }
    static func pointFromRatio          (ratio:CGxy)                    -> CGPoint  { return pointFromRatio(ratio.x,ratio.y) }
    
    static func ratioFromPoint          (point:CGPoint)                 -> CGPoint  { return bounds.ratioFromPoint(point) }
}

// From GitHub: ldesroziers/CGRect+OperatorsAdditions

/**
 // Usage without these operators :
 var preferredContentSize = myFlowLayout.itemSize
 preferredContentSize.width *= 1.5
 preferredContentSize.height *= 1.5
 myOtherViewController.preferredContentSize = preferredContentSize
 
 
 // Usage with these operators :
 myOtherViewController.preferredContentSize = myFlowLayout.itemSize * 1.5
 
 Et voilà!
 */


func += (inout rect: CGRect, size: CGSize) {
    rect.size += size
}
func -= (inout rect: CGRect, size: CGSize) {
    rect.size -= size
}
func *= (inout rect: CGRect, size: CGSize) {
    rect.size *= size
}
func /= (inout rect: CGRect, size: CGSize) {
    rect.size /= size
}
func += (inout rect: CGRect, origin: CGPoint) {
    rect.origin += origin
}
func -= (inout rect: CGRect, origin: CGPoint) {
    rect.origin -= origin
}
func *= (inout rect: CGRect, origin: CGPoint) {
    rect.origin *= origin
}
func /= (inout rect: CGRect, origin: CGPoint) {
    rect.origin /= origin
}


/** CGSize+OperatorsAdditions */
func += (inout size: CGSize, right: CGFloat) {
    size.width += right
    size.height += right
}
func -= (inout size: CGSize, right: CGFloat) {
    size.width -= right
    size.height -= right
}
func *= (inout size: CGSize, right: CGFloat) {
    size.width *= right
    size.height *= right
}
func /= (inout size: CGSize, right: CGFloat) {
    size.width /= right
    size.height /= right
}

func += (inout left: CGSize, right: CGSize) {
    left.width += right.width
    left.height += right.height
}
func -= (inout left: CGSize, right: CGSize) {
    left.width -= right.width
    left.height -= right.height
}
func *= (inout left: CGSize, right: CGSize) {
    left.width *= right.width
    left.height *= right.height
}
func /= (inout left: CGSize, right: CGSize) {
    left.width /= right.width
    left.height /= right.height
}

func + (size: CGSize, right: CGFloat) -> CGSize {
    return CGSize(width: size.width + right, height: size.height + right)
}
func - (size: CGSize, right: CGFloat) -> CGSize {
    return CGSize(width: size.width - right, height: size.height - right)
}
func * (size: CGSize, right: CGFloat) -> CGSize {
    return CGSize(width: size.width * right, height: size.height * right)
}
func / (size: CGSize, right: CGFloat) -> CGSize {
    return CGSize(width: size.width / right, height: size.height / right)
}

func + (left: CGSize, right: CGSize) -> CGSize {
    return CGSize(width: left.width + right.width, height: left.height + right.height)
}
func - (left: CGSize, right: CGSize) -> CGSize {
    return CGSize(width: left.width - right.width, height: left.height - right.height)
}
func * (left: CGSize, right: CGSize) -> CGSize {
    return CGSize(width: left.width * right.width, height: left.height * right.height)
}
func / (left: CGSize, right: CGSize) -> CGSize {
    return CGSize(width: left.width / right.width, height: left.height / right.height)
}



/** CGPoint+OperatorsAdditions */
func += (inout point: CGPoint, right: CGFloat) {
    point.x += right
    point.y += right
}
func -= (inout point: CGPoint, right: CGFloat) {
    point.x -= right
    point.y -= right
}
func *= (inout point: CGPoint, right: CGFloat) {
    point.x *= right
    point.y *= right
}
func /= (inout point: CGPoint, right: CGFloat) {
    point.x /= right
    point.y /= right
}

func += (inout left: CGPoint, right: CGPoint) {
    left.x += right.x
    left.y += right.y
}
func -= (inout left: CGPoint, right: CGPoint) {
    left.x -= right.x
    left.y -= right.y
}
func *= (inout left: CGPoint, right: CGPoint) {
    left.x *= right.x
    left.y *= right.y
}
func /= (inout left: CGPoint, right: CGPoint) {
    left.x /= right.x
    left.y /= right.y
}

func + (point: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: point.x + right, y: point.y + right)
}
func - (point: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: point.x - right, y: point.y - right)
}
func * (point: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * right, y: point.y * right)
}
func / (point: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / right, y: point.y / right)
}

func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}
func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}
func * (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x * right.x, y: left.y * right.y)
}
func / (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x / right.x, y: left.y / right.y)
}



extension SKNode
{
    var width   :CGFloat                                                                    { return 0 }
    var height  :CGFloat                                                                    { return 0 }
    
    func hFromRatio             (ratio:CGFloat)                                 -> CGFloat  { return self.width * ratio }
    func vFromRatio             (ratio:CGFloat)                                 -> CGFloat  { return self.height * ratio }
    
    func xFromRatio             (ratio:CGFloat)                                 -> CGFloat  { return self.position.x + hFromRatio(ratio) }
    func yFromRatio             (ratio:CGFloat)                                 -> CGFloat  { return self.position.y + vFromRatio(ratio) }
    
    func ratioFromH             (h:CGFloat)                                     -> CGFloat  { return h / (width != 0 ? width : 1.0) }
    func ratioFromV             (v:CGFloat)                                     -> CGFloat  { return v / (height != 0 ? height : 1.0) }
    
    func ratioFromX             (x:CGFloat)                                     -> CGFloat  { return (x - position.x) / (width != 0 ? width : 1.0) }
    func ratioFromY             (y:CGFloat)                                     -> CGFloat  { return (y - position.y) / (height != 0 ? height : 1.0) }
    
    func pointFromRatio         (ratio:CGPoint)                                 -> CGPoint  { return CGPointMake(hFromRatio(ratio.x), vFromRatio(ratio.y)) }
    func pointFromRatio         (h:CGFloat, _ v:CGFloat)                        -> CGPoint  { return CGPointMake(hFromRatio(h),vFromRatio(v)) }
    
    func positionFromRatio      (x:CGFloat, _ y:CGFloat)                        -> CGPoint  { return position + pointFromRatio(x,y) }

    
    public var z:CGFloat {
        get {
            return zPosition
        }
        set {
            zPosition = newValue
        }
    }
    
    
    class func resolveResourceImageName(name:String, suffix:String = ".png") -> String {
        
        // if has .suffix
        // if is suffixed with ~5
        // if not has .suffix

        if TGF.Environment.DeviceType.IPHONE5 {
            return name + (name.hasSuffix("~5") ? "" : "~5") + suffix
        }
        if TGF.Environment.DeviceType.IPHONE6 {
            return name + (name.hasSuffix("~6") ? "" : "~6") + suffix
        }
        if TGF.Environment.DeviceType.IPHONE6p {
            return name + (name.hasSuffix("~6+") ? "" : "~6+") + suffix
        }
        
        return name
    }
    
    func addChild               (sprite sprite:SKSpriteNode)                    -> SKSpriteNode
    {
        addChild(sprite)
        return sprite
    }

    func addChildSprite         (imageNamed imageNamed:String, suffix:String = ".png")                  -> SKSpriteNode
    {
        let name = SKNode.resolveResourceImageName(imageNamed,suffix:suffix)
        let node = SKSpriteNode(imageNamed:name)
        addChild(node)
        node.anchorPoint = CGPointMake(0.5,0.5)
        return node
    }
    
    func addChildSpriteEmpty    ()                                              -> SKSpriteNode
    {
        let node = SKSpriteNode()
        addChild(node)
        node.anchorPoint = CGPointMake(0.5,0.5)
        return node
    }
    
    
    

    func withNodeName                   (name:String)                               -> SKNode
    {
        self.name = name
        return self
    }
    
    func withNodeZRotation              (rotation:CGFloat)                          -> SKNode
    {
        self.zRotation = rotation
        return self
    }

    func withNodeScaleX                 (scale:CGFloat)                             -> SKNode
    {
        self.xScale = scale
        return self
    }

    func withNodeScaleY                 (scale:CGFloat)                             -> SKNode
    {
        self.yScale = scale
        return self
    }
    
    func withNodeScale                  (scale:CGFloat)                             -> SKNode
    {
        self.xScale = scale
        self.yScale = scale
        return self
    }
    
    func withNodeScale                  (x:CGFloat, _ y:CGFloat)                    -> SKNode
    {
        self.xScale = x
        self.yScale = y
        return self
    }
    
    func withNodeAlpha                  (alpha:CGFloat)                             -> SKNode
    {
        self.alpha = alpha
        return self
    }

    func withNodePositionX              (v:CGFloat)                                 -> SKNode
    {
        self.position.x = v
        return self
    }
    
    func withNodePositionY              (v:CGFloat)                                 -> SKNode
    {
        self.position.y = v
        return self
    }
    
    func withNodePosition               (position:CGPoint)                          -> SKNode
    {
        self.position = position
        return self
    }

    func withNodeZPosition              (p:CGFloat)                                 -> SKNode
    {
        self.zPosition = p
        return self
    }

    
    

    func positionFromScreenRatio  (to:CGxy)
    {
        if let parent = self.scene
        {
            let position = parent.position + CGScreen.pointFromRatio(to)
//            print("positionFromScreen(\(to))=\(position),screen=\(CGScreen.bounds)")
            self.position = (self.parent?.convertPoint(position,fromNode:parent))!
        }
    }
    
    func positionFromScreenRatio          (x:CGFloat,_ y:CGFloat)
    {
        positionFromScreenRatio(CGxy(x,y))
    }
    
    
    
    
    func positionFromSceneRatio  (to:CGxy)
    {
        if let parent = self.scene
        {
            self.position.x = parent.xFromRatio(to.x)
            self.position.y = parent.yFromRatio(to.y)
            
            self.position = (self.parent?.convertPoint(position,fromNode:parent))!
        }
    }
    
    func positionFromSceneRatio          (x:CGFloat,_ y:CGFloat)
    {
        positionFromSceneRatio(CGxy(x,y))
    }

    
    
    
    func positionFromParentRatio  (to:CGxy)
    {
        if let parent = self.parent as? SKSpriteNode {
            self.position.x = parent.xFromRatio(to.x - parent.anchorPoint.x)
            self.position.y = parent.yFromRatio(to.y - parent.anchorPoint.y)
        }
        else if let parent = self.parent as? SKScene {
            self.position.x = parent.xFromRatio(to.x)
            self.position.y = parent.yFromRatio(to.y)
        }
    }
    
    func positionFromParentRatio          (x:CGFloat,_ y:CGFloat)
    {
        positionFromParentRatio(CGxy(x,y))
    }
    
    func positionFromParentCenter ()
    {
        positionFromParentRatio((0.5,0.5))
    }
    
    
    
    
    func withNodePositionToParentRatio  (to:CGxy)                                    -> SKNode
    {
        positionFromParentRatio(to)
        return self
    }
    
    func withNodePositionToParentCenter ()                                              -> SKNode
    {
        return withNodePositionToParentRatio((0.5,0.5))
    }

    
    
}





extension SKScene
{
    override var  width   :CGFloat                                                                    { return self.size.width }
    override var  height  :CGFloat                                                                    { return self.size.height }

    // NOTE: NEED TO OVERRIDE position TO FIX BUG IN SpriteKit
    override public var  position:CGPoint {
        get {
            return self.frame.origin
        }
        set {
        }
    }
}




extension SKLightNode
{
    
}



extension SKShapeNode
{
    
}



extension SKSpriteNode
{

    override var  width   :CGFloat                                                                    { return self.size.width }
    override var  height  :CGFloat                                                                    { return self.size.height }
    

    
    
    
    
    override func positionFromRatio      (h:CGFloat, _ v:CGFloat)                        -> CGPoint { return CGPoint(x:xFromRatio(h - anchorPoint.x),y:yFromRatio(v - anchorPoint.y)) }

    
    
    
    
    
    
    func withSpriteName                   (name:String)                               -> SKSpriteNode
    {
        withNodeName(name)
        return self
    }
    
    func withSpriteZRotation              (rotation:CGFloat)                          -> SKSpriteNode
    {
        withNodeZRotation(rotation)
        return self
    }
    
    func withSpriteScaleX                 (scale:CGFloat)                             -> SKSpriteNode
    {
        withNodeScaleX(scale)
        return self
    }
    
    func withSpriteScaleY                 (scale:CGFloat)                             -> SKSpriteNode
    {
        withNodeScaleY(scale)
        return self
    }
    
    func withSpriteScale                  (scale:CGFloat)                             -> SKSpriteNode
    {
        withNodeScale(scale)
        return self
    }
    
    func withSpriteScale                  (x:CGFloat, _ y:CGFloat)                    -> SKSpriteNode
    {
        withNodeScale(x,y)
        return self
    }
    
    func withSpriteAlpha                  (alpha:CGFloat)                             -> SKSpriteNode
    {
        withNodeAlpha(alpha)
        return self
    }
    
    func withSpritePositionX              (v:CGFloat)                                 -> SKSpriteNode
    {
        withNodePositionX(v)
        return self
    }
    
    func withSpritePositionY              (v:CGFloat)                                 -> SKSpriteNode
    {
        withNodePositionY(v)
        return self
    }
    
    func withSpritePosition               (position:CGPoint)                          -> SKSpriteNode
    {
        withNodePosition(position)
        return self
    }
    
    func withSpriteZPosition              (p:CGFloat)                                 -> SKSpriteNode
    {
        withNodeZPosition(p)
        return self
    }

    
    
    
    
    
    
    
    
    
    
    
    func withSpriteAnchor             (x:CGFloat, _ y:CGFloat)                        -> SKSpriteNode
    {
        self.anchorPoint.x = x
        self.anchorPoint.y = y
        return self
    }
    
    func withSpriteAnchor             (anchor:CGPoint)                                -> SKSpriteNode
    {
        self.anchorPoint = anchor
        return self
    }

    func withSpriteColor              (color:UIColor,andAlpha:Bool = true)            -> SKSpriteNode
    {
        self.color = color
        if andAlpha {
            self.alpha = color.alpha
        }
        return self
    }
    
    func withSpriteColorBlendFactor   (colorBlendFactor:CGFloat)                      -> SKSpriteNode
    {
        self.colorBlendFactor = colorBlendFactor
        return self
    }
    
    func withSpriteBlendMode          (blendMode:SKBlendMode)                         -> SKSpriteNode
    {
        self.blendMode = blendMode
        return self
    }
    
    
//    func with                   (size size:CGSize)                              -> SKSpriteNode
//    {
//        self.size = size
//        return self
//    }
    
//    func with                   (width width:CGFloat)                           -> SKSpriteNode
//    {
//        self.size.width = width
//        return self
//    }

//    func with                   (height height:CGFloat)                         -> SKSpriteNode
//    {
//        self.size.height = height
//        return self
//    }
    
    
    
    func withSpriteAlignX                 (from from:CGFloat, to:CGFloat)                 -> SKSpriteNode
    {
        // POSITION IS WRT TO PARENT'S ANCHOR
        
        self.position.x = to - from
        
        return self
    }
    
    func withSpriteAlignX                 (fromRatio fromRatio:CGFloat, to:CGFloat)       -> SKSpriteNode
    {
        let from        = hFromRatio(fromRatio - anchorPoint.x)

        self.position.x = to - from
        
        return self
    }

    func withSpriteAlignX                 (fromRatio fromRatio:CGFloat, toRatio:CGFloat)  -> SKSpriteNode
    {
        if let parent = self.parent as? SKSpriteNode {
            let from        = self  .hFromRatio(fromRatio - anchorPoint.x)
            let to          = parent.hFromRatio(toRatio - parent.anchorPoint.x)
            self.position.x = to - from
        }
        else if let parent = self.parent as? SKScene {
            let from        = self  .hFromRatio(fromRatio - anchorPoint.x)
            let to          = parent.hFromRatio(toRatio - parent.anchorPoint.x)
            self.position.x = to - from
        }
        return self
    }
    
    func withSpriteAlignX                 (from from:CGFloat, toRatio:CGFloat)            -> SKSpriteNode
    {
        if let parent = self.parent as? SKSpriteNode {
            let to          = parent.hFromRatio(toRatio - parent.anchorPoint.x)
            self.position.x = to - from
        }
        else if let parent = self.parent as? SKScene {
            let to          = parent.hFromRatio(toRatio - parent.anchorPoint.x)
            self.position.x = to - from
        }
        return self
    }
    
    
    
    
    
    func withSpriteAlignY                 (from from:CGFloat, to:CGFloat)                 -> SKSpriteNode
    {
        self.position.y = to - from
        
        return self
    }
    
    func withSpriteAlignY                 (fromRatio fromRatio:CGFloat, to:CGFloat)       -> SKSpriteNode
    {
        let from        = vFromRatio(fromRatio - anchorPoint.y)
        
        self.position.y = to - from
        
        return self
    }
    
    func withSpriteAlignY                 (fromRatio fromRatio:CGFloat, toRatio:CGFloat)  -> SKSpriteNode
    {
        if let parent = self.parent as? SKSpriteNode {
            let from        = self  .vFromRatio(fromRatio - anchorPoint.y)
            let to          = parent.vFromRatio(toRatio - parent.anchorPoint.y)
            self.position.y = to - from
        }
        else if let parent = self.parent as? SKScene {
            let from        = self  .vFromRatio(fromRatio - anchorPoint.y)
            let to          = parent.vFromRatio(toRatio - parent.anchorPoint.y)
            self.position.y = to - from
        }
        return self
    }
    
    func withSpriteAlignY                 (from from:CGFloat, toRatio:CGFloat)            -> SKSpriteNode
    {
        if let parent = self.parent as? SKSpriteNode {
            let to          = parent.vFromRatio(toRatio - parent.anchorPoint.y)
            self.position.x = to - from
        }
        else if let parent = self.parent as? SKScene {
            let to          = parent.vFromRatio(toRatio - parent.anchorPoint.y)
            self.position.x = to - from
        }
        return self
    }

    
    
    
    

    func withSpriteAlign                  (from from:CGPoint, to:CGPoint)                 -> SKSpriteNode
    {
        withSpriteAlignX(from:from.x,to:to.x)
        withSpriteAlignY(from:from.y,to:to.y)
        return self
    }

    func withSpriteAlign                  (fromRatio fromRatio:CGPoint, to:CGPoint)       -> SKSpriteNode
    {
        withSpriteAlignX(fromRatio:fromRatio.x,to:to.x)
        withSpriteAlignY(fromRatio:fromRatio.y,to:to.y)
        return self
    }
    
    func withSpriteAlign                  (fromRatio fromRatio:CGxy, toRatio:CGxy)  -> SKSpriteNode
    {
        withSpriteAlignX(fromRatio:fromRatio.x,toRatio:toRatio.x)
        withSpriteAlignY(fromRatio:fromRatio.y,toRatio:toRatio.y)
        return self
    }
    
    func withSpriteAlign                  (fromRatio fromRatio:CGPoint, toRatio:CGPoint)  -> SKSpriteNode
    {
        withSpriteAlignX(fromRatio:fromRatio.x,toRatio:toRatio.x)
        withSpriteAlignY(fromRatio:fromRatio.y,toRatio:toRatio.y)
        return self
    }
    
    func withSpriteAlign                  (from from:CGPoint, toRatio:CGPoint)            -> SKSpriteNode
    {
        withSpriteAlignX(from:from.x,toRatio:toRatio.x)
        withSpriteAlignY(from:from.y,toRatio:toRatio.y)
        return self
    }
    
    func withSpriteAlign                  (fromRatio:CGPoint)                             -> SKSpriteNode
    {
        return withSpriteAlign(fromRatio:fromRatio,
                               toRatio  :CGPointMake(0.5,0.5))
    }
    
    func withSpriteAlign                  (toRatio toRatio:CGPoint)                       -> SKSpriteNode
    {
        return withSpriteAlign(fromRatio:CGPointMake(0.5,0.5),
                               toRatio  :toRatio)
    }
    
    func withSpriteAlignCenters           ()                                              -> SKSpriteNode
    {
        return withSpriteAlign(fromRatio:CGPointMake(0.5,0.5),
                               toRatio  :CGPointMake(0.5,0.5))
    }
    
    // withSpriteAlign(r:(0.5,0.3),p=(320,120))
    
}







extension SKNode
{
    func debugAddX(lineWidth lineWidth:CGFloat = 1,color:UIColor = UIColor.redColor()) -> SKNode
    {
        if true
        {
            let path = CGPathCreateMutable()
            
            CGPathMoveToPoint       (path,nil,0.0,0.0)
            CGPathAddLineToPoint    (path,nil,self.frame.size.width,self.frame.size.height)
            
            let n = SKShapeNode(path:path)
            //            let n = SKShapeNode(rectOfSize:size,cornerRadius:32)
            
            n.strokeColor       = color
            n.lineWidth         = lineWidth
            
            self.addChild(n)
            
            n.position          = self.frame.bl
        }
        if true
        {
            let path = CGPathCreateMutable()
            
            CGPathMoveToPoint       (path,nil,0.0,self.frame.size.height)
            CGPathAddLineToPoint    (path,nil,self.frame.size.width,0)
            
            let n = SKShapeNode(path:path)
            //            let n = SKShapeNode(rectOfSize:size,cornerRadius:32)
            
            n.strokeColor       = color
            n.lineWidth         = lineWidth
            
            self.addChild(n)
            
            n.position          = self.frame.tl
        }
        
        return self
    }
    
    func debugAddCross(lineWidth lineWidth:CGFloat = 1,color:UIColor = UIColor.redColor()) -> SKNode
    {
        if true
        {
            let path = CGPathCreateMutable()
            
            CGPathMoveToPoint       (path,nil,self.frame.size.width/2,0.0)
            CGPathAddLineToPoint    (path,nil,self.frame.size.width/2,self.frame.size.height)
            
            let n = SKShapeNode(path:path)
            //            let n = SKShapeNode(rectOfSize:size,cornerRadius:32)
            
            n.strokeColor       = color
            n.lineWidth         = lineWidth
            
            self.addChild(n)
            
            n.position          = self.frame.bl
        }
        if true
        {
            let path = CGPathCreateMutable()
            
            CGPathMoveToPoint       (path,nil,0.0,self.frame.size.height/2)
            CGPathAddLineToPoint    (path,nil,self.frame.size.width,self.frame.size.height/2)
            
            let n = SKShapeNode(path:path)
            //            let n = SKShapeNode(rectOfSize:size,cornerRadius:32)
            
            n.strokeColor       = color
            n.lineWidth         = lineWidth
            
            self.addChild(n)
            
            n.position          = self.frame.bl
        }
        
        return self
    }
    
    func debugAddBorder(lineWidth lineWidth:CGFloat = 1,corner:CGFloat = 16,color:UIColor = UIColor.greenColor()) -> SKNode
    {
        if true
        {
            let n = SKShapeNode(rectOfSize:self.frame.size,cornerRadius:corner)
            
            n.strokeColor       = color
            n.lineWidth         = lineWidth
            
            self.addChild(n)
            
            n.position          = self.frame.center
        }
        
        return self
    }
}





extension SKAction
{
    public func runOn(node:SKNode,delay sec:NSTimeInterval = 0) -> SKAction {
        aRun(self,node:node,delay:sec)
        return self
    }
}


public func aRun            (on node:SKNode,action:SKAction,delay sec:NSTimeInterval = 0)   -> SKNode { node.runAction(aDelayed(sec,action:action)); return node }
public func aRun            (action:SKAction,node:SKNode,delay sec:NSTimeInterval = 0)      -> SKNode { node.runAction(aDelayed(sec,action:action)); return node }
public func aRun            (action:SKAction,on:SKNode,delay sec:NSTimeInterval = 0)        -> SKNode { on.runAction(aDelayed(sec,action:action)); return on }

public func aRunOnChild     (named named:String,action:SKAction,delay sec:NSTimeInterval = 0)-> SKAction { return SKAction.runAction(aDelayed(sec,action:action), onChildWithName:named); }

public func aForever        (action:SKAction)                                               -> SKAction     { return SKAction.repeatActionForever(action) }
public func aRepeat         (action:SKAction,count:UInt)                                    -> SKAction     { return SKAction.repeatAction(action,count:Int(count)) }

public func aSequence       (actions:[SKAction])                                            -> SKAction     { return SKAction.sequence(actions) }
public func aGroup          (actions:[SKAction])                                            -> SKAction     { return SKAction.group(actions) }

public func aWait           (sec:NSTimeInterval)                                            -> SKAction     { return SKAction.waitForDuration(sec) }
public func aWait           (sec:NSTimeInterval,range:NSTimeInterval)                       -> SKAction     { return SKAction.waitForDuration(sec,withRange:range) }

public func aDelayed        (action:SKAction,delay sec:NSTimeInterval)                      -> SKAction     { return 0.0 < sec ? aSequence([aWait(sec), action]) : action }
public func aDelayed        (sec:NSTimeInterval,action:SKAction)                            -> SKAction     { return aDelayed(action,delay:sec) }

public func aPerform        (selector selector:Selector,on:AnyObject)                       -> SKAction     { return SKAction.performSelector(selector,onTarget:on) }

public func aBlock          (block: dispatch_block_t, delay:NSTimeInterval)                 -> SKAction     { return aDelayed(SKAction.runBlock(block),delay:delay) }
public func aBlock          (delay delay:NSTimeInterval,block: dispatch_block_t)            -> SKAction     { return aDelayed(SKAction.runBlock(block),delay:delay) }
public func aBlock          (block: dispatch_block_t)                                       -> SKAction     { return SKAction.runBlock(block) }
public func aBlock          (block: dispatch_block_t, queue:dispatch_queue_t)               -> SKAction     { return SKAction.runBlock(block,queue:queue) }
public func aBlock          (block: (SKNode,CGFloat) -> Void,
                             duration sec:NSTimeInterval,
                                      delay:NSTimeInterval = 0)                             -> SKAction     { return aDelayed(delay,action:SKAction.customActionWithDuration(sec,actionBlock:block)) }
public func aBlock          (duration sec:NSTimeInterval,
                                      delay:NSTimeInterval = 0,
                                      block: (SKNode,CGFloat) -> Void)                      -> SKAction     { return aDelayed(delay,action:SKAction.customActionWithDuration(sec,actionBlock:block)) }
public func aBlockTimed01   (duration sec:NSTimeInterval,
                                      delay:NSTimeInterval = 0,
                                      block: (SKNode,CGFloat) -> Void)                      -> SKAction
{
    return aDelayed(delay,action:SKAction.customActionWithDuration(sec,actionBlock:{ node,time in
        block(node,time/CGFloat(sec))
    }))
}





public func aWithTiming         (function f:SKActionTimingFunction,on:SKAction) -> SKAction { on.timingFunction=f; return on }
public func aWithTiming         (on on:SKAction,_ f:SKActionTimingFunction) -> SKAction { on.timingFunction=f; return on }

public func aWithTimingMode     (mode:SKActionTimingMode,on:SKAction) -> SKAction { on.timingMode=mode; return on }

public func aWithSpeed          (speed:CGFloat,on:SKAction) -> SKAction { on.speed=speed; return on }

public func aReversed           (on:SKAction) -> SKAction { return on.reversedAction() }

public func aRemoveFromParent   () -> SKAction { return SKAction.removeFromParent() }
public func aRemove             () -> SKAction { return SKAction.removeFromParent() }






public func aMoveBy             (x x:CGFloat,y:CGFloat,duration sec:NSTimeInterval) -> SKAction { return SKAction.moveByX(x,y:y,duration:sec) }
public func aMoveBy             (x x:CGFloat,duration sec:NSTimeInterval) -> SKAction { return SKAction.moveByX(x,y:0,duration:sec) }
public func aMoveBy             (y y:CGFloat,duration sec:NSTimeInterval) -> SKAction { return SKAction.moveByX(0,y:y,duration:sec) }
public func aMoveBy             (move:CGVector,duration sec:NSTimeInterval) -> SKAction { return SKAction.moveBy(move,duration:sec) }

public func aMoveTo             (move:CGPoint,duration sec:NSTimeInterval) -> SKAction { return SKAction.moveTo(move,duration:sec) }
public func aMoveTo             (x x:CGFloat,y:CGFloat,duration sec:NSTimeInterval) -> SKAction { return SKAction.moveTo(CGPointMake(x,y),duration:sec) }
public func aMoveTo             (x x:CGFloat,duration sec:NSTimeInterval) -> SKAction { return SKAction.moveToX(x,duration:sec) }
public func aMoveTo             (y y:CGFloat,duration sec:NSTimeInterval) -> SKAction { return SKAction.moveToY(y,duration:sec) }

public func aFollow             (path path:CGPath,duration sec:NSTimeInterval) -> SKAction { return SKAction.followPath(path,duration:sec) }
public func aFollow             (path path:CGPath,speed:CGFloat) -> SKAction { return SKAction.followPath(path,speed:speed) }
public func aFollow             (path path:CGPath,asOffset:Bool,orientToPath:Bool,duration sec:NSTimeInterval) -> SKAction { return SKAction.followPath(path,asOffset:asOffset,orientToPath:orientToPath,duration:sec) }
public func aFollow             (path path:CGPath,asOffset:Bool,orientToPath:Bool,speed:CGFloat) -> SKAction { return SKAction.followPath(path,asOffset:asOffset,orientToPath:orientToPath,speed:speed) }

public func aRotateBy           (degrees angle:CGFloat,duration sec:NSTimeInterval) -> SKAction { return SKAction.rotateByAngle(CGDegrees2Radians(angle),duration:sec) }
public func aRotateBy           (radians angle:CGFloat,duration sec:NSTimeInterval) -> SKAction { return SKAction.rotateByAngle(angle,duration:sec) }

public func aRotateTo           (degrees angle:CGFloat,duration sec:NSTimeInterval,alongShortestArc:Bool = false) -> SKAction   { return SKAction.rotateToAngle(CGDegrees2Radians(angle),duration:sec,shortestUnitArc:alongShortestArc) }
public func aRotateTo           (radians angle:CGFloat,duration sec:NSTimeInterval,alongShortestArc:Bool = false) -> SKAction   { return SKAction.rotateToAngle(angle,duration:sec,shortestUnitArc:alongShortestArc) }

public func aSpeedBy            (speed:CGFloat,duration sec:NSTimeInterval) -> SKAction { return SKAction.speedBy(speed,duration:sec) }
public func aSpeedTo            (speed:CGFloat,duration sec:NSTimeInterval) -> SKAction { return SKAction.speedTo(speed,duration:sec) }

public func aScaleBy            (scale:CGFloat,duration sec:NSTimeInterval) -> SKAction { return SKAction.scaleBy(scale,duration:sec) }
public func aScaleTo            (scale:CGFloat,duration sec:NSTimeInterval) -> SKAction { return SKAction.scaleTo(scale,duration:sec) }

public func aScaleBy            (x x:CGFloat,y:CGFloat,duration sec:NSTimeInterval) -> SKAction { return SKAction.scaleXBy(x,y:y,duration:sec) }
public func aScaleTo            (x x:CGFloat,y:CGFloat,duration sec:NSTimeInterval) -> SKAction { return SKAction.scaleXTo(x,y:y,duration:sec) }

public func aScaleTo            (x x:CGFloat,duration sec:NSTimeInterval) -> SKAction { return SKAction.scaleXTo(x,duration:sec) }
public func aScaleTo            (y y:CGFloat,duration sec:NSTimeInterval) -> SKAction { return SKAction.scaleYTo(y,duration:sec) }

public func aHide               () -> SKAction { return SKAction.hide() }
public func aShow               () -> SKAction { return SKAction.unhide() }
public func aShow               (flag:Bool) -> SKAction { return flag ? SKAction.unhide() : SKAction.hide() }

public func aFadeIn             (duration sec:NSTimeInterval) -> SKAction { return SKAction.fadeInWithDuration(sec) }
public func aFadeOut            (duration sec:NSTimeInterval) -> SKAction { return SKAction.fadeOutWithDuration(sec) }

public func aFadeBy             (alpha:CGFloat,duration sec:NSTimeInterval) -> SKAction { return SKAction.fadeAlphaBy(alpha,duration:sec) }
public func aFadeTo             (alpha:CGFloat,duration sec:NSTimeInterval) -> SKAction { return SKAction.fadeAlphaTo(alpha,duration:sec) }




public func aSpriteColorTo            (color:UIColor,duration sec:NSTimeInterval) -> SKAction { return SKAction.colorizeWithColor(color,colorBlendFactor:color.alpha,duration:sec) }
public func aSpriteColorTo            (color:UIColor,blendFactor:CGFloat,duration sec:NSTimeInterval) -> SKAction { return SKAction.colorizeWithColor(color,colorBlendFactor:color.alpha,duration:sec) }
public func aSpriteColor              (blendFactorTo blendFactor:CGFloat,duration sec:NSTimeInterval) -> SKAction { return SKAction.colorizeWithColorBlendFactor(blendFactor,duration:sec) }

//public func aAnimate            (textures:[SKTexture],timePerFrame:NSTimeInterval) -> SKAction { return SKAction.animateWithNormalTextures(textures,timePerFrame:timePerFrame) }
public func aSpriteAnimate            (textures textures:[SKTexture],timePerFrame:NSTimeInterval,resize:Bool=false,restore:Bool=true) -> SKAction { return SKAction.animateWithTextures(textures,timePerFrame:timePerFrame,resize:resize,restore:restore) }
public func aSpriteAnimate            (normalTextures textures:[SKTexture],timePerFrame:NSTimeInterval,resize:Bool=false,restore:Bool=true) -> SKAction { return SKAction.animateWithNormalTextures(textures,timePerFrame:timePerFrame,resize:resize,restore:restore) }
public func aSpriteTexture            (texture texture:SKTexture,resize:Bool=false) -> SKAction { return SKAction.setTexture(texture,resize:resize) }
public func aSpriteTexture            (normal texture:SKTexture,resize:Bool=false) -> SKAction { return SKAction.setNormalTexture(texture,resize:resize) }

public func aSpriteResizeBy           (width width:CGFloat=0,height:CGFloat=0,duration sec:NSTimeInterval) -> SKAction { return SKAction.resizeByWidth(width,height:height,duration:sec) }
public func aSpriteResizeTo           (width width:CGFloat,height:CGFloat,duration sec:NSTimeInterval) -> SKAction { return SKAction.resizeToWidth(width,height:height,duration:sec) }
public func aSpriteResizeTo           (width width:CGFloat,duration sec:NSTimeInterval) -> SKAction { return SKAction.resizeToWidth(width,duration:sec) }
public func aSpriteResizeTo           (height height:CGFloat,duration sec:NSTimeInterval) -> SKAction { return SKAction.resizeToHeight(height,duration:sec) }




public func aAudioPlay              (file file:String,waitForCompletion wait:Bool) -> SKAction { return SKAction.playSoundFileNamed(file,waitForCompletion:wait) }
public func aAudioPlay              () -> SKAction { return SKAction.play() }
public func aAudioPause             () -> SKAction { return SKAction.pause() }
public func aAudioStop              () -> SKAction { return SKAction.stop() }
public func aAudioRate              (to to:Float,duration:NSTimeInterval) -> SKAction { return SKAction.changePlaybackRateTo(to,duration:duration) }
public func aAudioRate              (by by:Float,duration:NSTimeInterval) -> SKAction { return SKAction.changePlaybackRateBy(by,duration:duration) }
public func aAudioVolume            (to to:Float,duration:NSTimeInterval) -> SKAction { return SKAction.changeVolumeTo(to,duration:duration) }
public func aAudioVolume            (by by:Float,duration:NSTimeInterval) -> SKAction { return SKAction.changeVolumeBy(by,duration:duration) }
public func aAudioObstruction       (to to:Float,duration:NSTimeInterval) -> SKAction { return SKAction.changeObstructionTo(to,duration:duration) }
public func aAudioObstruction       (by by:Float,duration:NSTimeInterval) -> SKAction { return SKAction.changeObstructionBy(by,duration:duration) }
public func aAudioOcclusion         (to to:Float,duration:NSTimeInterval) -> SKAction { return SKAction.changeOcclusionTo(to,duration:duration) }
public func aAudioOcclusion         (by by:Float,duration:NSTimeInterval) -> SKAction { return SKAction.changeOcclusionBy(by,duration:duration) }
public func aAudioReverb            (to to:Float,duration:NSTimeInterval) -> SKAction { return SKAction.changeReverbTo(to,duration:duration) }
public func aAudioReverb            (by by:Float,duration:NSTimeInterval) -> SKAction { return SKAction.changeReverbBy(by,duration:duration) }
public func aAudioPan               (to to:Float,duration:NSTimeInterval) -> SKAction { return SKAction.stereoPanTo(to,duration:duration) }
public func aAudioPan               (by by:Float,duration:NSTimeInterval) -> SKAction { return SKAction.stereoPanBy(by,duration:duration) }





public func aPhysicsApply       (force v:CGVector,duration:NSTimeInterval) -> SKAction { return SKAction.applyForce(v,duration:duration) }
public func aPhysicsApply       (force v:CGVector,point:CGPoint,duration:NSTimeInterval) -> SKAction { return SKAction.applyForce(v,atPoint:point,duration:duration) }
public func aPhysicsApply       (torque v:CGFloat,duration:NSTimeInterval) -> SKAction { return SKAction.applyTorque(v,duration:duration) }
public func aPhysicsApply       (impulse v:CGVector,duration:NSTimeInterval) -> SKAction { return SKAction.applyImpulse(v,duration:duration) }
public func aPhysicsApply       (angular impulse:CGFloat,duration:NSTimeInterval) -> SKAction { return SKAction.applyAngularImpulse(impulse,duration:duration) }
public func aPhysicsApply       (impulse v:CGVector,point:CGPoint,duration:NSTimeInterval) -> SKAction { return SKAction.applyImpulse(v,atPoint:point,duration:duration) }

public func aPhysicsCharge      (to v:Float,point:CGPoint,duration:NSTimeInterval) -> SKAction { return SKAction.changeChargeTo(v,duration:duration) }
public func aPhysicsCharge      (by v:Float,point:CGPoint,duration:NSTimeInterval) -> SKAction { return SKAction.changeChargeBy(v,duration:duration) }

public func aPhysicsMass        (to v:Float,point:CGPoint,duration:NSTimeInterval) -> SKAction { return SKAction.changeMassTo(v,duration:duration) }
public func aPhysicsMass        (by v:Float,point:CGPoint,duration:NSTimeInterval) -> SKAction { return SKAction.changeMassBy(v,duration:duration) }

public func aPhysicsStrength    (to v:Float,point:CGPoint,duration:NSTimeInterval) -> SKAction { return SKAction.strengthTo(v,duration:duration) }
public func aPhysicsStrength    (by v:Float,point:CGPoint,duration:NSTimeInterval) -> SKAction { return SKAction.strengthBy(v,duration:duration) }

public func aPhysicsFalloff     (to v:Float,point:CGPoint,duration:NSTimeInterval) -> SKAction { return SKAction.falloffTo(v,duration:duration) }
public func aPhysicsFalloff     (by v:Float,point:CGPoint,duration:NSTimeInterval) -> SKAction { return SKAction.falloffBy(v,duration:duration) }






