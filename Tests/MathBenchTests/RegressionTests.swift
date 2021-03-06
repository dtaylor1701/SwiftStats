import XCTest
import MathBench

class RegressionTests: XCTestCase {
    func testFindBeta() throws {
        let y = Matrix<Double>([4],
                               [6],
                               [8])
        let a = Matrix<Double>([2,0,0],
                               [0,2,0],
                               [0,0,2])
        
        let expectedB = Matrix<Double>([2],
                                      [3],
                                      [4])
        let expectedR = Matrix<Double>([0],
                                       [0],
                                       [0])

        let beta = try Regression.beta(independentVariables: a, dependentVariable: y)
        let residuals = try Regression.risiduals(beta: beta, independentVariables: a, dependentVariable: y)

        XCTAssertEqual(expectedB, beta)
        XCTAssertEqual(expectedR, residuals)
    }
    
    func testRegressionAgain() throws {
        let y = Matrix<Double>([4],
                               [6],
                               [8],
                               [4],
                               [6],
                               [8],
                               [9],
                               [23])
        
        let a = Matrix<Double>([3,1,5],
                               [4,2,4],
                               [9,2,23],
                               [2,1,5],
                               [4,2,4],
                               [7,2,23],
                               [3,2,53],
                               [4,2,43])
        let beta = try Regression.beta(independentVariables: a, dependentVariable: y)
        XCTAssertNotNil(beta)
    }
    
    func testRegression() throws {
        let height = Matrix<Double>([1.47],
                                    [1.50],
                                    [1.52],
                                    [1.55],
                                    [1.57],
                                    [1.60],
                                    [1.63],
                                    [1.65],
                                    [1.68],
                                    [1.70],
                                    [1.73],
                                    [1.75],
                                    [1.78],
                                    [1.80],
                                    [1.83])

        let weight = Matrix<Double>([52.21],
                                    [53.12],
                                    [54.48],
                                    [55.84],
                                    [57.20],
                                    [58.57],
                                    [59.93],
                                    [61.29],
                                    [63.11],
                                    [64.47],
                                    [66.28],
                                    [68.10],
                                    [69.92],
                                    [72.19],
                                    [74.46])
        let heightSquared = try Matrix.combine(left: height, right: height, action: *)
        let intercept: [Double] = Array.init(repeating: 1, count: weight.rowCount)
        let x = Matrix<Double>(columns: [intercept, height.column(0), heightSquared.column(0)])
        do {
            let r = try Regression(independentVariables: x, dependentVariable: weight)
            print(r)
            print(r.csv())
            print(r.csvX())
        } catch(let error) {
            print(error)
        }
    }
}
