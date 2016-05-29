//
//  TGFSwiftMath.swift
//  TGFFrankenbots
//
//  Created by andrzej semeniuk on 5/14/16.
//  Copyright © 2016 Tiny Game Factory LLC. All rights reserved.
//

import Foundation
import CoreGraphics
import GameplayKit



public struct Math
{
    static public let PI           :CGFloat            = CGFloat(M_PI)
    static public let TwoPI        :CGFloat            = CGFloat(M_PI * 2.0)
}



private var __randomSourceObject    :GKRandomSource?
private var __randomSource          :RandomSource       = .Arc4Random

public enum RandomSource {
    case Arc4Random, LinearCongruential, MersenneTwister
}

public func randomUseSource(source:RandomSource) -> GKRandomSource {
    __randomSource = source
    switch source
    {
        case .Arc4Random:           __randomSourceObject = GKARC4RandomSource()
        case .LinearCongruential:   __randomSourceObject = GKLinearCongruentialRandomSource()
        case .MersenneTwister:      __randomSourceObject = GKMersenneTwisterRandomSource()
    }
    return __randomSourceObject!
}

public func randomGetSource() -> GKRandomSource {
    return __randomSourceObject ?? randomUseSource(__randomSource)
}




private var __randomDistributionObject  :GKRandomDistribution?
private let __randomDistributionLowestValue                             = 0
private let __randomDistributionHighestValue                            = Int.max
private let __randomDistributionDelta   :Double                         = Double(__randomDistributionHighestValue - __randomDistributionLowestValue)
private var __randomDistribution        :RandomDistribution             = .Uniform

public enum RandomDistribution {
    case Gaussian,Uniform
}

public func randomUseDistribution(distribution:RandomDistribution) -> GKRandomDistribution {
    __randomDistribution = distribution
    switch distribution
    {
        case .Gaussian:     __randomDistributionObject = GKGaussianDistribution(randomSource:randomGetSource(),
                                                                                lowestValue:__randomDistributionLowestValue,
                                                                                highestValue:__randomDistributionHighestValue)
        case .Uniform:      __randomDistributionObject = GKRandomDistribution(randomSource:randomGetSource(),
                                                                              lowestValue:__randomDistributionLowestValue,
                                                                              highestValue:__randomDistributionHighestValue)
    }
    return __randomDistributionObject!
}

public func randomGetDistribution() -> GKRandomDistribution
{
    return __randomDistributionObject ?? randomUseDistribution(.Uniform)
}


public func random      (from from:CGFloat,to:CGFloat)  -> CGFloat  {
    let v = Double(randomGetDistribution().nextInt())
    return from + CGFloat(v/__randomDistributionDelta) * (to-from)
}

public func random01    ()  -> CGFloat  { return random(from:0,to:1) }
public func random11    ()  -> CGFloat  { return random(from:-1,to:+1) }

