//
//  BallMergeGameApp.swift
//  Secrets of Ra
//
//


import SwiftUI
import SpriteKit

//ball_level

// MARK: - SpriteKit Scene with vertical layout and background
class GameScene: SKScene {
    
    var currentLevel: Int = 0
    
    // Scenarios for levels 1–10
    private static let scenarios: [[FigureType: Int]] = [
        [.type2: 1],                    // Level 1
        [.type1: 2, .type3: 1],         // Level 2
        [.type4: 1, .type5: 2],         // Level 3
        [.type2: 3, .type6: 1],         // Level 4
        [.type3: 2, .type7: 2],         // Level 5
        [.type8: 1, .type1: 3],         // Level 6
        [.type5: 3, .type9: 1],         // Level 7
        [.type4: 2, .type6: 2],         // Level 8
        [.type10: 1, .type11: 2],       // Level 9
        [.type12: 1, .type13: 1, .type2: 2] // Level 10
    ]
    
    // Grid properties
    let rows = 6, columns = 3
    var cellSize: CGSize = .zero
    var slots: [[CGPoint]] = []
    var gridNodes: [[FigureNode?]] = []
    
    // UI nodes
    private var customerNode: SKSpriteNode!
    private var orderNodes: [SKSpriteNode] = []
    private var chestNode: SKSpriteNode!
    private var orders: [FigureType: Int] = [:]
    private var backgroundNode: SKSpriteNode!

    // Drag state
    private var draggedNode: FigureNode?
    private var originalPos: CGPoint?

    // UI layout constants
    private let topAreaHeight: CGFloat = 250
    private let bottomAreaHeight: CGFloat = 100

    override func didMove(to view: SKView) {
        backgroundColor = .clear
        initializeGame()
    }
    // Common initialization and restart
    func initializeGame() {
        // Clear existing nodes and state
        removeAllChildren()
        // Reset data structures
        orders.removeAll()
        gridNodes.removeAll()
        slots.removeAll()
        orderNodes.removeAll()
        removeAllChildren()
        orders.removeAll()
        gridNodes.removeAll()
        slots.removeAll()
        setupUI()
        setupGrid()
        setupBackground()
        spawnInitialFigures(count: 8)
    }
    
    // Exposed restart method
    func restart() {
        initializeGame()
    }

    // MARK: - UI Setup
    private func setupUI() {
        // Customer and orders in top area
        let customerY = UIScreen.main.bounds.height - topAreaHeight / 1.35
        let customerX = UIScreen.main.bounds.width * 0.2
        customerNode = SKSpriteNode(imageNamed: "customerSR")
        customerNode.size = CGSize(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.width * 0.4)
        customerNode.position = CGPoint(x: customerX, y: customerY)
        addChild(customerNode)

        // Orders right of customer
        orders = GameScene.scenarios[currentLevel]
        let spacing: CGFloat = 80
        var idx = 0
        for (type, qty) in orders {
            let icon = SKSpriteNode(imageNamed: type.imageName)
            let xOffset = customerX + icon.size.width/2 + CGFloat(idx) * (icon.size.width)
            icon.position = CGPoint(x: xOffset, y: customerY)
            icon.name = "order_\(type.rawValue)"
            addChild(icon)

            let label = SKLabelNode(text: "x\(qty)")
            label.fontSize = 18
            label.fontColor = .black
            label.position = CGPoint(x: 0, y: -icon.size.height/2 - 12)
            icon.addChild(label)

            orderNodes.append(icon)
            idx += 1
        }

        // Chest at bottom center
        chestNode = SKSpriteNode(imageNamed: "chestSR")
        chestNode.size = CGSize(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.width * 0.3)
        chestNode.position = CGPoint(x: UIScreen.main.bounds.width/2, y: bottomAreaHeight / 1.5)
        chestNode.name = "chestSR"
        addChild(chestNode)
    }

    // MARK: - Grid Setup
    private func setupGrid() {
        let gridYStart = bottomAreaHeight
        let gridHeight = UIScreen.main.bounds.height - topAreaHeight - bottomAreaHeight
        cellSize = CGSize(width: UIScreen.main.bounds.width / CGFloat(columns), height: gridHeight / CGFloat(rows))
        slots = []
        gridNodes = Array(
            repeating: Array(repeating: nil, count: columns),
            count: rows
        )
        for row in 0..<rows {
            var rowPoints: [CGPoint] = []
            for col in 0..<columns {
                let x = cellSize.width * (CGFloat(col) + 0.5)
                let y = gridYStart + cellSize.height * (CGFloat(rows - row) - 0.5)
                rowPoints.append(CGPoint(x: x, y: y))
                
                let cellBg = SKSpriteNode(imageNamed: "cellBgSR")
                cellBg.size = cellSize
                cellBg.position = CGPoint(x: x, y: y)
                cellBg.zPosition = -1
                addChild(cellBg)
            }
            slots.append(rowPoints)
        }
    }

    // MARK: - Background Setup
    private func setupBackground() {
        // Create background sprite covering the grid area
        let gridYStart = bottomAreaHeight
        let gridHeight = UIScreen.main.bounds.height - topAreaHeight - bottomAreaHeight
        backgroundNode = SKSpriteNode(imageNamed: "background")
        backgroundNode.position = CGPoint(x: UIScreen.main.bounds.width/2,
                                          y: gridYStart + gridHeight/2)
        backgroundNode.size = CGSize(width: UIScreen.main.bounds.width, height: gridHeight)
        backgroundNode.zPosition = -2
        addChild(backgroundNode)
    }

    // MARK: - Spawn & Merge Logic
    func spawnInitialFigures(count: Int) {
        for _ in 0..<count {
            guard let slot = randomEmptySlot() else { break }
            let raw = Int.random(in: 1...min(3, FigureType.maxRaw))
            if let t = FigureType(rawValue: raw) {
                addFigure(type: t, at: slot)
            }
        }
    }

    private func addFigure(type: FigureType, at slot: (Int, Int)) {
        let node = FigureNode(type: type)
        let (r, c) = slot
        node.position = slots[r][c]
        addChild(node)
        gridNodes[r][c] = node
    }

    private func randomEmptySlot() -> (Int, Int)? {
        var empty: [(Int, Int)] = []
        for r in 0..<rows {
            for c in 0..<columns where gridNodes[r][c] == nil {
                empty.append((r, c))
            }
        }
        return empty.randomElement()
    }
    
    // MARK: - Delivery Logic
    private func tryDeliver(_ node: FigureNode) {
        for icon in orderNodes {
            if node.frame.intersects(icon.frame) {
                let type = node.type
                if let qty = orders[type], qty > 0 {
                    orders[type]! -= 1
                    if let label = icon.children.compactMap({ $0 as? SKLabelNode }).first {
                        label.text = "x\(orders[type]!)"
                    }
                    if let orig = originalSlot(of: node) { gridNodes[orig.0][orig.1] = nil }
                    node.removeFromParent()
                    
                    // Check victory
                    if orders.values.allSatisfy({ $0 == 0 }) {
                        NotificationCenter.default.post(name: .gameWon, object: nil)
                    }
                } else {
                    if let orig = originalPos {
                        node.run(SKAction.move(to: orig, duration: 0.2))
                    }
                }
                return
            }
        }
    }

    // MARK: - Touch Handling
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let loc = touches.first?.location(in: self) else { return }
        let nodesAtPoint = nodes(at: loc)
        if nodesAtPoint.contains(chestNode) {
            spawnInitialFigures(count: 1)
            return
        }
        if let fig = nodesAtPoint.compactMap({ $0 as? FigureNode }).first {
            draggedNode = fig
            originalPos = fig.position
            fig.zPosition = 10
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let loc = touches.first?.location(in: self), let fig = draggedNode else { return }
        fig.position = loc
    }

//    guard let fig = draggedNode else { return }
//    defer { draggedNode = nil; fig.zPosition = 0 }
//    // Try delivery first
//    tryDeliver(fig)
//    // If still in scene and not delivered, try merge
//    if parent != nil {
//        if let slot = nearestSlot(to: fig.position),
//           let other = gridNodes[slot.0][slot.1], other !== fig,
//           other.type.level == fig.type.level {
//            performMerge(fig, with: other, at: slot)
//        } else if let orig = originalPos {
//            fig.run(SKAction.move(to: orig, duration: 0.2))
//        }
//    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let fig = draggedNode else { return }
        defer { draggedNode = nil; fig.zPosition = 0 }
        tryDeliver(fig)
        if let slot = nearestSlot(to: fig.position),
           let other = gridNodes[slot.0][slot.1], other !== fig,
           other.type.level == fig.type.level {
            performMerge(fig, with: other, at: slot)
        } else if let orig = originalPos {
            fig.run(SKAction.move(to: orig, duration: 0.2))
        }
    }

    private func nearestSlot(to point: CGPoint) -> (Int, Int)? {
        var best: (Int, Int)?; var minD = CGFloat.greatestFiniteMagnitude
        for r in 0..<rows {
            for c in 0..<columns {
                let d = hypot(point.x - slots[r][c].x, point.y - slots[r][c].y)
                if d < minD { minD = d; best = (r, c) }
            }
        }
        return (minD < cellSize.width/2) ? best : nil
    }

    private func performMerge(_ a: FigureNode, with b: FigureNode, at slot: (Int, Int)) {
        gridNodes[slot.0][slot.1] = nil
        b.removeFromParent()
        if let orig = originalSlot(of: a) {
            gridNodes[orig.0][orig.1] = nil
        }
        let nextLvl = a.type.level + 1
        if nextLvl <= FigureType.maxLevel {
            let start = (nextLvl-1)*3 + 1
            let end = min(nextLvl*3, FigureType.maxRaw)
            let raw = Int.random(in: start...end)
            if let newType = FigureType(rawValue: raw) {
                addFigure(type: newType, at: slot)
            }
        }
        a.removeFromParent()
    }

    private func originalSlot(of node: FigureNode) -> (Int, Int)? {
        for r in 0..<rows { for c in 0..<columns where gridNodes[r][c] === node { return (r, c) } }
        return nil
    }
}

// MARK: - FigureNode
class FigureNode: SKSpriteNode {
    let type: FigureType
    init(type: FigureType) {
        self.type = type
        let texture = SKTexture(imageNamed: type.imageName)
        super.init(texture: texture, color: .clear, size: texture.size())
        self.name = "ball_level\(type.rawValue)"
    }
    required init?(coder: NSCoder) { fatalError() }
}

// MARK: - FigureType
enum FigureType: Int, CaseIterable {
    case type1 = 1, type2, type3,
         type4, type5, type6,
         type7, type8, type9,
         type10, type11, type12,
         type13

    var level: Int { (rawValue - 1) / 3 + 1 }
    static let maxLevel = 5
    static let maxRaw = 13
    var imageName: String { "ball_level\(rawValue)" }
}
