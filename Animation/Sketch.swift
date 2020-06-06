import Foundation
import CanvasGraphics

class Sketch : NSObject {
    
    // NOTE: Every sketch must contain an object of type Canvas named 'canvas'
    //       Therefore, the line immediately below must always be present.
    let canvas: Canvas
    
    // L-system definitions
    let coniferousTree: LindenmayerSystem
    let bush: LindenmayerSystem
    let sun: LindenmayerSystem
    let flower:LindenmayerSystem
    // This function runs once
    override init() {
        
        // Create canvas object – specify size
        canvas = Canvas(width: 500, height: 500)
        
        // Draw slowly
        //canvas.framesPerSecond = 1
        
        // Define a stochastic system that resembles a coniferous tree
        coniferousTree = LindenmayerSystem(axiom: "SF",
                                           angle: 20,
                                           rules: ["F": [
                                                        RuleSet(odds: 1, successorText: "3F[++1F[X]][+2F][-4F][--5F[X]]6F"),
                                                        RuleSet(odds: 1, successorText: "3F[+1F][+2F][-4F]5F"),
                                                        RuleSet(odds: 1, successorText: "3F[+1F][-2F][--6F]4F"),
                                                        ],
                                                   "X": [
                                                        RuleSet(odds: 1, successorText: "X")
                                                        ]
                                                  ],
                                           colors: ["1": Color(hue: 120, saturation: 100, brightness: 61, alpha: 100),
                                                    "2": Color(hue: 134, saturation: 97, brightness: 46, alpha: 100),
                                                    "3": Color(hue: 145, saturation: 87, brightness: 8, alpha: 100),
                                                    "4": Color(hue: 135, saturation: 84, brightness: 41, alpha: 100),
                                                    "5": Color(hue: 116, saturation: 26, brightness: 100, alpha: 100),
                                                    "6": Color(hue: 161, saturation: 71, brightness: 53, alpha: 100)
                                                   ],
                                           generations: 5)
        
        
        bush = LindenmayerSystem(axiom: "SX",
                                 angle: 20,
                                 rules: ["F": [
                                            RuleSet(odds: 1, successorText: "1/FFF"),
                                        ],
                                        "X": [
                                            RuleSet(odds: 1, successorText: "1/1[[2-X][2-X+FX+FX][2+X]1-FX[2-XF]1F[2-X][2-X]]"),
                                            RuleSet(odds: 1, successorText: "1/1[[2+X][2+X-FX-FX][2-X]1+FX[2+XF]1F[2+X][2+X]]"),
                                            RuleSet(odds: 1, successorText: "1/1[[2-X][2-X+FXX+FX][2-FXFX]1-FX[2-XF][2-X]]"),
                                        ]
                                        ],
                                 colors: ["1": Color(hue: 131, saturation: 100, brightness: 25, alpha: 100),
                                          "2": Color(hue: 312, saturation: 51, brightness: 44, alpha: 100),
                                          "3": Color(hue: 132, saturation: 205, brightness: 151, alpha: 100),
                                          "4": Color(hue: 132, saturation:205, brightness: 151, alpha: 100),
                                         ],
                                generations: 4)
        
        
        sun = LindenmayerSystem(axiom: "SF+F+F+F+F+F+F+F+",
                                angle: 45,
                                rules: ["F": [
                                    RuleSet(odds: 1, successorText: "1+F--F+F"),
                                    ]
                                    ],
                                        colors: ["1": Color(hue: 59, saturation: 52, brightness: 100, alpha: 100),],
                                generations: 6)
        
        flower = LindenmayerSystem(axiom: "SFX",
                                   angle: 10,
                                   rules: ["F": [
                                   RuleSet(odds: 1, successorText: "F++[2FFFF]"),
                                   ],
                                    "X": [
                                    RuleSet(odds: 1, successorText: "1/1+XX"),
                                    RuleSet(odds: 1, successorText: "1/1XX"),
                                    RuleSet(odds: 1, successorText: "1/1-XX"),
                                    ]
                                   ],
                                   colors: ["1": Color(hue: 120, saturation: 60, brightness: 46, alpha: 100),
                                            "2": Color(hue: 360, saturation: 85, brightness: 75, alpha: 100),
                                            ],
                                   generations: 6)
        
        
        
        // Create a gradient sky background, blue to white as vertical location increases
        for y in 300...500 {
            
            // Set the line saturation to progressively get closer to white
            let currentSaturation = 100.0 - Float(y - 300) / 2
            // DEBUG: Uncomment line below to see how this value changes
            print("currentSaturation is: \(currentSaturation)")
            canvas.lineColor = Color(hue: 200.0, saturation: currentSaturation, brightness: 90.0, alpha: 100.0)
            
            // Draw a horizontal line at this vertical location
            canvas.drawLine(from: Point(x: 0, y: y), to: Point(x: canvas.width, y: y))
            
        }
        
        // Create a gradient ground background, green to darker green as vertical location increases
        // NOTE: Can use the HSV/HSB sliders (third from top) at this site for help picking colours:
        //       http://colorizer.org
        for y in 0...300 {
            
            // Set the line brightness to progressively get closer to black
            let currentBrightness = 50.0 - Float(y) / 30.0 * 3.0
            // DEBUG: Uncomment line below to see how this value changes
            print("currentBrightness is \(currentBrightness)")
            canvas.lineColor = Color(hue: 120.0, saturation: 180.0, brightness: currentBrightness, alpha: 100.0)
            
            // Draw a horizontal line at this vertical location
            canvas.drawLine(from: Point(x: 0, y: y), to: Point(x: canvas.width, y: y))
    
        }
        
        //create a mountain
        for y in 0...300 {
                

            canvas.lineColor = Color(hue: 20.0, saturation: 0, brightness: 50, alpha: 100.0)
            
            // Draw a horizontal line at this vertical location
            canvas.drawLine(from: Point(x: 150, y: 0), to: Point(x: 450, y: y))
    
        }
        for y in 0...300 {
                    
            canvas.lineColor = Color(hue: 20.0, saturation: 0, brightness: 50, alpha: 100.0)
            
            // Draw a horizontal line at this vertical location
            canvas.drawLine(from: Point(x: 150, y: 0), to: Point(x: 450, y: y))
    
        }
        for y in 0...450 {
                
            // DEBUG: Uncomment line below to see how this value change
            canvas.lineColor = Color(hue: 20.0, saturation: 0, brightness: 50, alpha: 100.0)
            
            // Draw a horizontal line at this vertical location
            canvas.drawLine(from: Point(x: 350, y: 0), to: Point(x: 500, y: y))
    
        }
        for y in 0...450 {
                    
            // DEBUG: Uncomment line below to see how this value change
            canvas.lineColor = Color(hue: 20.0, saturation: 0, brightness: 50, alpha: 100.0)
            
            // Draw a horizontal line at this vertical location
            canvas.drawLine(from: Point(x: 350, y: 0), to: Point(x: 500, y: y))
    
        }

        for y in 0...200{
        for x in 300...500{
                        
            // DEBUG: Uncomment line below to see how this value change
            canvas.lineColor = Color(hue: 20.0, saturation: 0, brightness: 50, alpha: 100.0)
            
            // Draw a horizontal line at this vertical location
            canvas.drawLine(from: Point(x: 300, y: 150), to: Point(x: x, y: y))
        
        }
        }
        for y in 0...200{
        for x in 300...500{
                        
            // DEBUG: Uncomment line below to see how this value change
            canvas.lineColor = Color(hue: 20.0, saturation: 0, brightness: 50, alpha: 100.0)
            
            // Draw a horizontal line at this vertical location
            canvas.drawLine(from: Point(x: 300, y: 150), to: Point(x: x, y: y))
        
        }
        }
        for y in 0...200{
                        
            // DEBUG: Uncomment line below to see how this value change
            canvas.lineColor = Color(hue: 20.0, saturation: 0, brightness: 50, alpha: 100.0)
            
            // Draw a horizontal line at this vertical location
            canvas.drawLine(from: Point(x: 200, y: 0), to: Point(x: 300, y: y))
        
        }
        
        
        
        // Create 16 trees, drawn from their tops along a quadratic path
        
        // Define the vertex of the parabolic path (top right of canvas)
        let vertex = Point(x: 450, y: 350)
        
        // Define some other point on the parabolic path (in this case, closer to bottom left)
        let anotherPointOnParabola = Point(x: 100, y: 225)
        
        // Work out the "a" value for the parabola (vertical stretch)
        let a = (anotherPointOnParabola.y - vertex.y) / pow(anotherPointOnParabola.x - vertex.x, 2)
        
        
        
        // make a lot of trees (16)
        for i in 1...1 {
            // Use a quadratic relationship to define the vertical starting point for the top of each tree
            // (trees grow down from starting point)
            let x = CGFloat(i - 1) * 50.0 + 30              // This defines "spread" of the trees along the quadratic path
            let y = a * pow(x - vertex.x, 2) + vertex.y + 150     // Determine vertical position using y = a(x-h)^2 + k
            
            // DEBUG: To help see where starting points are
            print("Starting point for tree is... x: \(x), y: \(y)")
            
            // Define the length of the tree's initial stroke
            let length = 27.0 - Double(y) / 16.0            // Piggyback on quadratic change in y values to set length
            print("Length of line for system is: \(length)")
            
            
            
            // Generate the tree
            var aTree = VisualizedLindenmayerSystem(system: coniferousTree,
                                                    length: length,
                                                    initialDirection: 270,
                                                    reduction: 1.35,
                                                    pointToStartRenderingFrom: Point(x: x, y: y),
                                                    drawnOn: canvas)
                
            // Render this tree
            aTree.renderFullSystem()
            
        }
        
        
        
        for i in 1...3 {
            // Use a quadratic relationship to define the vertical starting point for the top of each tree
            // (trees grow down from starting point)
            let x = CGFloat(i - 1) * 50.0 + 40              // This defines "spread" of the trees along the quadratic path
            let y = a * pow(x - vertex.x, 2) + vertex.y + 90     // Determine vertical position using y = a(x-h)^2 + k
            
            // DEBUG: To help see where starting points are
            print("Starting point for tree is... x: \(x), y: \(y)")
            
            // Define the length of the tree's initial stroke
            let length = 27.0 - Double(y) / 16.0            // Piggyback on quadratic change in y values to set length
            print("Length of line for system is: \(length)")
            
            // Generate the tree
            var aTree = VisualizedLindenmayerSystem(system: coniferousTree,
                                                    length: length,
                                                    initialDirection: 270,
                                                    reduction: 1.35,
                                                    pointToStartRenderingFrom: Point(x: x, y: y),
                                                    drawnOn: canvas)
                
            // Render this tree
            aTree.renderFullSystem()
            
        }
        
        
        for i in 1...5 {
            // Use a quadratic relationship to define the vertical starting point for the top of each tree
            // (trees grow down from starting point)
            let x = CGFloat(i - 1) * 50.0 + 50              // This defines "spread" of the trees along the quadratic path
            let y = a * pow(x - vertex.x, 2) + vertex.y + 40     // Determine vertical position using y = a(x-h)^2 + k
            
            // DEBUG: To help see where starting points are
            print("Starting point for tree is... x: \(x), y: \(y)")
            
            // Define the length of the tree's initial stroke
            let length = 27.0 - Double(y) / 16.0            // Piggyback on quadratic change in y values to set length
            print("Length of line for system is: \(length)")
            
            // Generate the tree
            var aTree = VisualizedLindenmayerSystem(system: coniferousTree,
                                                    length: length,
                                                    initialDirection: 270,
                                                    reduction: 1.30,
                                                    pointToStartRenderingFrom: Point(x: x, y: y),
                                                    drawnOn: canvas)
                
            // Render this tree
            aTree.renderFullSystem()
            
        }
        
        
        for i in 1...7 {

            // Use a quadratic relationship to define the vertical starting point for the top of each tree
            // (trees grow down from starting point)
            let x = CGFloat(i - 1) * 50.0 + 75              // This defines "spread" of the trees along the quadratic path
            let y = a * pow(x - vertex.x, 2) + vertex.y     // Determine vertical position using y = a(x-h)^2 + k
            
            // DEBUG: To help see where starting points are
            print("Starting point for tree is... x: \(x), y: \(y)")
            
            // Define the length of the tree's initial stroke
            let length = 27.0 - Double(y) / 16.0            // Piggyback on quadratic change in y values to set length
            print("Length of line for system is: \(length)")
            
            // Generate the tree
            var aTree = VisualizedLindenmayerSystem(system: coniferousTree,
                                                    length: length,
                                                    initialDirection: 270,
                                                    reduction: 1.25,
                                                    pointToStartRenderingFrom: Point(x: x, y: y),
                                                    drawnOn: canvas)
            
            // Render this tree
            aTree.renderFullSystem()
        }
        
        for i in 1...2{
            
            let x = 300
            let y = 100
            
            // DEBUG: To help see where starting points are
            print("Starting point for tree is... x: \(x), y: \(y)")

            var aBush = VisualizedLindenmayerSystem(system: bush,
                                                    length: 30,
                                                    initialDirection: 90,
                                                    reduction: 3.2,
                                                    pointToStartRenderingFrom: Point(x: x, y: y),
                                                    drawnOn: canvas)
            // Render this bush
            aBush.renderFullSystem()
        }
        for i in 1...2{
            
            let x = 355
            let y = 100
            
            // DEBUG: To help see where starting points are
            print("Starting point for tree is... x: \(x), y: \(y)")

            var aBush = VisualizedLindenmayerSystem(system: bush,
                                                    length: 30,
                                                    initialDirection: 90,
                                                    reduction: 3.2,
                                                    pointToStartRenderingFrom: Point(x: x, y: y),
                                                    drawnOn: canvas)
            // Render this bush
            aBush.renderFullSystem()
        }
        for i in 1...2{
            
            let x = 335
            let y = 50
            
            // DEBUG: To help see where starting points are
            print("Starting point for tree is... x: \(x), y: \(y)")

            var aBush = VisualizedLindenmayerSystem(system: bush,
                                                    length: 30,
                                                    initialDirection: 90,
                                                    reduction: 3.2,
                                                    pointToStartRenderingFrom: Point(x: x, y: y),
                                                    drawnOn: canvas)
            // Render this bush
            aBush.renderFullSystem()
        }
        for i in 1...2{
            
            let x = 370
            let y = 50
            
            // DEBUG: To help see where starting points are
            print("Starting point for tree is... x: \(x), y: \(y)")

            var aBush = VisualizedLindenmayerSystem(system: bush,
                                                    length: 30,
                                                    initialDirection: 90,
                                                    reduction: 3.2,
                                                    pointToStartRenderingFrom: Point(x: x, y: y),
                                                    drawnOn: canvas)
            // Render this bush
            aBush.renderFullSystem()
        }
        for i in 1...2{
            
            let x = 410
            let y = 100
            
            // DEBUG: To help see where starting points are
            print("Starting point for tree is... x: \(x), y: \(y)")

            var aBush = VisualizedLindenmayerSystem(system: bush,
                                                    length: 30,
                                                    initialDirection: 90,
                                                    reduction: 3.2,
                                                    pointToStartRenderingFrom: Point(x: x, y: y),
                                                    drawnOn: canvas)
            // Render this bush
            aBush.renderFullSystem()
        }
        for i in 1...2{
            
            let x = 300
            let y = 50
            
            // DEBUG: To help see where starting points are
            print("Starting point for tree is... x: \(x), y: \(y)")

            var aBush = VisualizedLindenmayerSystem(system: bush,
                                                    length: 30,
                                                    initialDirection: 90,
                                                    reduction: 3.2,
                                                    pointToStartRenderingFrom: Point(x: x, y: y),
                                                    drawnOn: canvas)
            // Render this bush
            aBush.renderFullSystem()
        }
        for i in 1...2{
            
            let x = 405
            let y = 50
            
            // DEBUG: To help see where starting points are
            print("Starting point for tree is... x: \(x), y: \(y)")

            var aBush = VisualizedLindenmayerSystem(system: bush,
                                                    length: 30,
                                                    initialDirection: 90,
                                                    reduction: 3.2,
                                                    pointToStartRenderingFrom: Point(x: x, y: y),
                                                    drawnOn: canvas)
            // Render this bush
            aBush.renderFullSystem()
        }
        

            var aSun = VisualizedLindenmayerSystem(system: sun,
                                                    length: 30,
                                                    initialDirection: 0,
                                                    reduction: 3.5,
                                                    pointToStartRenderingFrom: Point(x: 50, y: 450),
                                                    drawnOn: canvas)
            // Render this bush
            aSun.renderFullSystem()
        
        
            var aFlower = VisualizedLindenmayerSystem(system: flower,
                                                      length: 50,
                                                      initialDirection: 0,
                                                      reduction: 2.2,
                                                      pointToStartRenderingFrom: Point(x: 470, y: 250),
                                                      drawnOn: canvas)
            aFlower.renderFullSystem()
            var aFlower2 = VisualizedLindenmayerSystem(system: flower,
                                                      length: 50,
                                                      initialDirection: 0,
                                                      reduction: 2.1,
                                                      pointToStartRenderingFrom: Point(x: 490, y: 240),
                                                      drawnOn: canvas)
            aFlower2.renderFullSystem()
            var aFlower3 = VisualizedLindenmayerSystem(system: flower,
                                                       length: 50,
                                                       initialDirection: 0,
                                                       reduction: 2.4,
                                                       pointToStartRenderingFrom: Point(x: 390, y: 250),
                                                       drawnOn: canvas)
            aFlower3.renderFullSystem()
            var aFlower4 = VisualizedLindenmayerSystem(system: flower,
                                                       length: 50,
                                                       initialDirection: 0,
                                                       reduction: 2.5,
                                                       pointToStartRenderingFrom: Point(x: 430, y: 240),
                                                       drawnOn: canvas)
            aFlower4.renderFullSystem()
            var aFlower5 = VisualizedLindenmayerSystem(system: flower,
                                                       length: 50,
                                                       initialDirection: 0,
                                                       reduction: 2,
                                                       pointToStartRenderingFrom: Point(x: 410, y: 260),
                                                       drawnOn: canvas)
            aFlower5.renderFullSystem()
            var aFlower6 = VisualizedLindenmayerSystem(system: flower,
                                                       length: 50,
                                                       initialDirection: 0,
                                                       reduction: 2.2,
                                                       pointToStartRenderingFrom: Point(x: 420, y: 250),
                                                       drawnOn: canvas)
            aFlower6.renderFullSystem()
            var aFlower7 = VisualizedLindenmayerSystem(system: flower,
                                                       length: 50,
                                                       initialDirection: 0,
                                                       reduction: 2.2,
                                                       pointToStartRenderingFrom: Point(x: 410, y: 240),
                                                       drawnOn: canvas)
            aFlower7.renderFullSystem()
            var aFlower8 = VisualizedLindenmayerSystem(system: flower,
                                                       length: 50,
                                                       initialDirection: 0,
                                                       reduction: 1.9,
                                                       pointToStartRenderingFrom: Point(x: 430, y: 280),
                                                       drawnOn: canvas)
            aFlower8.renderFullSystem()
    }
    
    
    // This function runs repeatedly, forever, to create the animated effect
    func draw() {
        
        // Nothing to animate, so nothing in this function
        
    }
    
}
