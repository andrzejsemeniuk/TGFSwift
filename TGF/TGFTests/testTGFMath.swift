//
//  TGFTestUtilityVariable.swift
//  TGFFrankenbots
//
//  Created by andrzej semeniuk on 5/29/16.
//  Copyright © 2016 Tiny Game Factory LLC. All rights reserved.
//

import XCTest
@testable import TGF


class TestTGFMath: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testClamp() {
        
        if true {
            XCTAssertEqual("1.00",String(format:"%1.2f",Math.clamp(0,1,1.25)))
            XCTAssertEqual("0.00",String(format:"%1.2f",Math.clamp(0,1,-0.5)))
            XCTAssertEqual("0.56",String(format:"%1.2f",Math.clamp(0,1,0.56)))
            XCTAssertEqual("3.14",String(format:"%1.2f",Math.clamp(3,3.14,3.2)))
            XCTAssertEqual("3.14",String(format:"%1.2f",Math.clamp(3,3.14,3.14)))
            XCTAssertEqual("3.00",String(format:"%1.2f",Math.clamp(3,3.14,3.0)))
            XCTAssertEqual("3.00",String(format:"%1.2f",Math.clamp(3,3.14,2.2)))
            XCTAssertEqual("-3.00",String(format:"%1.2f",Math.clamp(-3,3.14,-3.2)))
            XCTAssertEqual("-2.11",String(format:"%1.2f",Math.clamp(-3,0,-2.11)))

            XCTAssertEqual("0.00",String(format:"%1.2f",Math.clamp(0,0,0)))
            XCTAssertEqual("0.00",String(format:"%1.2f",Math.clamp(0,0,1)))
            XCTAssertEqual("0.99",String(format:"%1.2f",Math.clamp(0.99,0.99,3)))
        }

        if true {
            XCTAssertEqual("1.00",String(format:"%1.2f",Math.clamp01(1.25)))
            XCTAssertEqual("1.00",String(format:"%1.2f",Math.clamp01(1.0)))
            XCTAssertEqual("0.00",String(format:"%1.2f",Math.clamp01(-0.5)))
            XCTAssertEqual("0.00",String(format:"%1.2f",Math.clamp01(0)))
            XCTAssertEqual("0.11",String(format:"%1.2f",Math.clamp01(0.112)))
        }

        if true {
            XCTAssertEqual("0.21",String(format:"%1.2f",Math.clamp(lowerbound:0.11,upperbound:0.22,value:0.21)))
            XCTAssertEqual("0.22",String(format:"%1.2f",Math.clamp(lowerbound:0.11,upperbound:0.22,value:0.25)))
            XCTAssertEqual("0.11",String(format:"%1.2f",Math.clamp(lowerbound:0.11,upperbound:0.22,value:0.01)))
            XCTAssertEqual("0.11",String(format:"%1.2f",Math.clamp(lowerbound:0.11,upperbound:0.22,value:0.11)))
        }
    }
    
    func testLerp() {
        if true {
            XCTAssertEqual("0.11",String(format:"%1.2f",Math.lerp(lowerbound:0.11,upperbound:0.22,value:0)))
            XCTAssertEqual("0.11",String(format:"%1.2f",Math.lerp(0.11,0.22,0)))
            
            XCTAssertEqual("0.22",String(format:"%1.2f",Math.lerp(lowerbound:0.11,upperbound:0.22,value:1)))
            XCTAssertEqual("0.22",String(format:"%1.2f",Math.lerp(0.11,0.22,1)))
            
            XCTAssertEqual("0.15",String(format:"%1.2f",Math.lerp(lowerbound:0.10,upperbound:0.20,value:0.5)))
            XCTAssertEqual("0.15",String(format:"%1.2f",Math.lerp(0.10,0.20,0.5)))
            
            XCTAssertEqual("0.25",String(format:"%1.2f",Math.lerp(lowerbound:0.10,upperbound:0.20,value:1.5)))
            XCTAssertEqual("0.25",String(format:"%1.2f",Math.lerp(0.10,0.20,1.5)))
            
            XCTAssertEqual("0.05",String(format:"%1.2f",Math.lerp(lowerbound:0.10,upperbound:0.20,value:-0.5)))
            XCTAssertEqual("0.05",String(format:"%1.2f",Math.lerp(0.10,0.20,-0.5)))
        }
        if true {
            XCTAssertEqual("-0.11",String(format:"%1.2f",Math.lerp01(lowerbound:-0.11,upperbound:0.22,value:-1)))
            XCTAssertEqual("-0.11",String(format:"%1.2f",Math.lerp01(-0.11,0.22,-1)))
            
            XCTAssertEqual("0.22",String(format:"%1.2f",Math.lerp01(lowerbound:-0.11,upperbound:0.22,value:2)))
            XCTAssertEqual("0.22",String(format:"%1.2f",Math.lerp01(-0.11,0.22,2)))
            
            XCTAssertEqual("-0.11",String(format:"%1.2f",Math.lerp01(lowerbound:-0.11,upperbound:0.22,value:0)))
            XCTAssertEqual("-0.11",String(format:"%1.2f",Math.lerp01(-0.11,0.22,0)))
            
            XCTAssertEqual("0.22",String(format:"%1.2f",Math.lerp01(lowerbound:-0.11,upperbound:0.22,value:1)))
            XCTAssertEqual("0.22",String(format:"%1.2f",Math.lerp01(-0.11,0.22,1)))
        }
    }
    
    func testProgress() {
        XCTAssertEqual("0.00",String(format:"%1.2f",Math.lprogress(from:0.00,to:100.0,now:0)))
        XCTAssertEqual("0.00",String(format:"%1.2f",Math.lprogress(0.00,100.0,0)))
        
        XCTAssertEqual("0.01",String(format:"%1.2f",Math.lprogress(from:0.00,to:100.0,now:1)))
        XCTAssertEqual("0.01",String(format:"%1.2f",Math.lprogress(0.00,100.0,1)))

        XCTAssertEqual("0.51",String(format:"%1.2f",Math.lprogress(from:0.00,to:100.0,now:51)))
        XCTAssertEqual("0.51",String(format:"%1.2f",Math.lprogress(0.00,100.0,51)))

        XCTAssertEqual("1.01",String(format:"%1.2f",Math.lprogress(from:0.00,to:100.0,now:101)))
        XCTAssertEqual("1.01",String(format:"%1.2f",Math.lprogress(0.00,100.0,101)))

        XCTAssertEqual("1.50",String(format:"%1.2f",Math.lprogress(from:0.00,to:100.0,now:150)))
        XCTAssertEqual("1.50",String(format:"%1.2f",Math.lprogress(0.00,100.0,150)))

        XCTAssertEqual("-0.01",String(format:"%1.2f",Math.lprogress(from:0.00,to:100.0,now:-1)))
        XCTAssertEqual("-0.01",String(format:"%1.2f",Math.lprogress(0.00,100.0,-1)))

        
        XCTAssertEqual("0.00",String(format:"%1.2f",Math.lprogress01(from:0.00,to:100.0,now:-1)))
        XCTAssertEqual("0.00",String(format:"%1.2f",Math.lprogress01(0.00,100.0,-1)))

        XCTAssertEqual("0.33",String(format:"%1.2f",Math.lprogress01(from:0.00,to:100.0,now:33)))
        XCTAssertEqual("0.33",String(format:"%1.2f",Math.lprogress01(0.00,100.0,33)))

        XCTAssertEqual("1.00",String(format:"%1.2f",Math.lprogress01(from:0.00,to:99.0,now:101)))
        XCTAssertEqual("1.00",String(format:"%1.2f",Math.lprogress01(0.00,99.0,101)))
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
