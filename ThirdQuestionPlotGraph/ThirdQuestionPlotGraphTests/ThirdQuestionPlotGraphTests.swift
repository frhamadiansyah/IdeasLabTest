//
//  ThirdQuestionPlotGraphTests.swift
//  ThirdQuestionPlotGraphTests
//
//  Created by Fandrian Rhamadiansyah on 13/08/24.
//

import XCTest
@testable import ThirdQuestionPlotGraph

final class ThirdQuestionPlotGraphTests: XCTestCase {

    let sut = KeypointsHelper()
    
    func testReadLocalFileValue() throws {
        let data = sut.readLocalFile(forName: "TW_Keypoints")
        
        let expectedDataCount = 764
        XCTAssert(data.count == expectedDataCount, "data count is different from expected")
    }
    
    func testMinMaxValue() throws {
        let data = sut.readLocalFile(forName: "TW_Keypoints")
        let result = sut.getMinMaxFloatValue(data)
        
        let expectedMinX: Float = -0.20883198
        XCTAssert(result.minX == expectedMinX, "minX result is different from expected")
    }
    
    func testScaleAndCenter() throws {
        
        let bounds = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSizeMake(393, 681.3333333333334))
        let data = sut.readLocalFile(forName: "TW_Keypoints")
        
        let scaleObj = sut.calculateCenterAndScale(datapoint: data, inset: 10, bounds: bounds)
        
        let expectedScale = 982.9263059122737
        let expectedCenter = CGPoint(x: 215.2664474681396, y: 361.8277687881591)
        XCTAssert(scaleObj.scale == expectedScale, "minX result is different from expected")
        
        XCTAssert(scaleObj.center.x == expectedCenter.x, "center x result is different from expected")
        XCTAssert(scaleObj.center.y == expectedCenter.y, "center y result is different from expected")
        
    }


}
