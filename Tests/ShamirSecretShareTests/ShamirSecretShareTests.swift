import XCTest
@testable import ShamirSecretShare

class ShamirSecretShareTests: XCTestCase {

    
    func testGF256() {
        let tester = { (got:GF256, want:GF256) -> Void in
            XCTAssert(want == got, "expected \(want), but got \(got).")
        }
        
        do {
            try tester(GF256(0xb6) * GF256(0x53), GF256(0x36))
            try tester(GF256(90) * GF256(21), GF256(254))
            try tester(GF256(7) * GF256(11), GF256(49))
            try tester(GF256(90) / GF256(21), GF256(189))
            
            try tester(GF256(90) * GF256(0), GF256(0))
            try tester(GF256(0) * GF256(21), GF256(0))
            try tester(GF256(0) * GF256(0), GF256(0))
            try tester(GF256(0) / GF256(21), GF256(0))
            
            do {
                let _ = try GF256(164) / GF256(0)
                XCTFail("No error on divBy0")
            } catch  {
                XCTAssert(error is GF256.Errors)
            }
        } catch {
            XCTFail("ERROR: \(error)")
        }
    }
    
    func testPolyGF256() {
        do {
            let poly = PolyGF256(bytes: [0x04, 0x02, 0xa3])
            let _ = try poly.evaluate(at: GF256(0x04))
            
            let _ = try GF256(0x04) + GF256(0x02)*GF256(0x04) + GF256(0xa3) * GF256(0x04) * GF256(0x04)
            
        } catch {
            XCTFail("ERROR: \(error)")
        }
    }
    
    func testSecretShare() {
        let loremIpsum = Data(bytes: [UInt8]("Sed ut perspiciatis, unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam eaque ipsa, quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt".utf8))
        
        do {
            let secret = try Secret(data: loremIpsum, threshold: 14, shares: 24)
            let shares = try secret.split()
            let recon  = try Secret.combine(shares: Array<Secret.Share>(shares[3...17]))
            
            XCTAssert(recon == secret.data, "data mismatch")
            
        } catch {
            XCTFail("ERROR: \(error)")
        }
        
    }
    
    func testSplitPerformance() {
        do {
            let data = try Data.random(size: 1000)
            let secret = try Secret(data: data, threshold: 5, shares: 10)
            
            self.measure {
                let _ = try? secret.split()
            }
            
        } catch {
            XCTFail("ERROR: \(error)")
        }
    }
    
    func testCombinePerformance() {
        do {
            let data = try Data.random(size: 1000)
            let secret = try Secret(data: data, threshold: 5, shares: 10)
            let shares = try Array<Secret.Share>(secret.split()[0 ..< 5])
            
            self.measure {
                let _ = try? Secret.combine(shares: shares)
            }
            
        } catch {
            XCTFail("ERROR: \(error)")
        }
    }

}
