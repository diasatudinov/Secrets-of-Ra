import SwiftUI
import SpriteKit

// MARK: - SwiftUI App Entry

@main
struct BallMergeGameApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// MARK: - SwiftUI Content View

struct ContentView: View {
    @State private var scene: SKScene = {
        let scene = GameScene()
        scene.size = UIScreen.main.bounds.size
        scene.scaleMode = .resizeFill
        return scene
    }()
    
    var body: some View {
        VStack(spacing: 0) {
            SpriteView(scene: scene)
                .ignoresSafeArea()
            Button(action: restartGame) {
                Text("Restart")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .padding(.bottom)
            }
        }
    }
    
    private func restartGame() {
        let newScene = GameScene()
        newScene.size = UIScreen.main.bounds.size
        newScene.scaleMode = .resizeFill
        scene = newScene
    }
}

// MARK: - Enums and Structs

enum BallLevel: Int {
    case level1 = 1, level2, level3, level4, level5, level6, level7, level8
    
    var textureName: String { "ball_level\(rawValue)" }
}

struct GridPosition {
    let row: Int
    let column: Int
}

// MARK: - BallNode

class BallNode: SKSpriteNode {
    var level: BallLevel
    
    init(level: BallLevel, size: CGSize) {
        self.level = level
        let texture = SKTexture(imageNamed: level.textureName)
        super.init(texture: texture, color: .clear, size: size)
        isUserInteractionEnabled = true
        zPosition = 1
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - GeneratorNode

class GeneratorNode: SKSpriteNode {
    let index: Int
    let unlockLevel: Int
    weak var gameScene: GameScene?
    
    var isUnlocked: Bool { gameScene?.currentLevel ?? 1 >= unlockLevel }
    
    init(index: Int, unlockLevel: Int, size: CGSize, gameScene: GameScene) {
        self.index = index
        self.unlockLevel = unlockLevel
        self.gameScene = gameScene
        let texture = SKTexture(imageNamed: "generator_box_\(index)")
        super.init(texture: texture, color: .clear, size: size)
        isUserInteractionEnabled = true
        setupLockOverlay()
    }
    
    private func setupLockOverlay() {
        if let scene = gameScene, scene.currentLevel < unlockLevel {
            let label = SKLabelNode(text: "Unlocks at Lv. \(unlockLevel)")
            label.fontSize = 12
            label.fontColor = .red
            label.position = CGPoint(x: 0, y: -size.height/2 - 10)
            addChild(label)
        }
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isUnlocked, let scene = gameScene else { return }
        scene.generateBall(from: self)
    }
}

// MARK: - VisitorNode

class VisitorNode: SKSpriteNode {
    var needs: [BallLevel: Int]
    weak var gameScene: GameScene?
    
    init(needs: [BallLevel: Int], size: CGSize, gameScene: GameScene) {
        self.needs = needs
        self.gameScene = gameScene
        let texture = SKTexture(imageNamed: "visitor")
        super.init(texture: texture, color: .clear, size: size)
        zPosition = 1
        displayNeeds()
    }
    
    private func displayNeeds() {
        var yOffset = size.height/2 + 20
        for (level, count) in needs {
            let label = SKLabelNode(text: "Lv\(level.rawValue): x\(count)")
            label.fontSize = 12
            label.fontColor = .black
            label.position = CGPoint(x: 0, y: yOffset)
            addChild(label)
            yOffset -= 16
        }
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - GameScene Implementation

class GameScene: SKScene {
    let rows = 6, columns = 3
    var cellSize = CGSize.zero
    var gridOrigin = CGPoint.zero
    var cells: [[BallNode?]] = []
    var currentLevel = 1
    var generators: [GeneratorNode] = []
    var visitor: VisitorNode!
    
    override func didMove(to view: SKView) {
        backgroundColor = .white
        setupGrid()
        setupGenerators()
        setupVisitor()
    }
    
    private func setupGrid() {
        let w = size.width * 0.8
        let h = size.height * 0.6
        cellSize = CGSize(width: w/CGFloat(columns), height: h/CGFloat(rows))
        gridOrigin = CGPoint(x: frame.midX - w/2, y: frame.midY - h/2)
        cells = Array(repeating: Array(repeating: nil, count: columns), count: rows)
        for r in 0..<rows {
            for c in 0..<columns {
                let cell = SKShapeNode(rectOf: cellSize)
                cell.strokeColor = .gray
                cell.lineWidth = 2
                cell.position = positionFor(r,c)
                addChild(cell)
            }
        }
    }
    
    private func positionFor(_ r: Int,_ c: Int) -> CGPoint {
        CGPoint(x: gridOrigin.x + CGFloat(c)*cellSize.width + cellSize.width/2,
                y: gridOrigin.y + CGFloat(r)*cellSize.height + cellSize.height/2)
    }
    
    private func setupGenerators() {
        let sizes = CGSize(width: 50, height: 50)
        let spacing: CGFloat = 10
        let totalW = CGFloat(5)*sizes.width + CGFloat(4)*spacing
        let startX = frame.midX - totalW/2
        let unlocks = [1,2,5,12,20]
        for i in 0..<5 {
            let gen = GeneratorNode(index: i, unlockLevel: unlocks[i], size: sizes, gameScene: self)
            gen.position = CGPoint(x: startX + CGFloat(i)*(sizes.width+spacing) + sizes.width/2,
                                   y: gridOrigin.y - sizes.height - 20)
            addChild(gen)
            generators.append(gen)
        }
    }
    
    private func setupVisitor() {
        let needs: [BallLevel:Int] = [.level1:2, .level2:1]
        visitor = VisitorNode(needs: needs, size: CGSize(width: size.width*0.6, height: 100), gameScene: self)
        visitor.position = CGPoint(x: frame.midX, y: frame.maxY - 80)
        addChild(visitor)
    }
    
    func generateBall(from gen: GeneratorNode) {
        guard let free = firstFree() else { return }
        let ball = BallNode(level: .level1, size: cellSize)
        ball.position = positionFor(free.row, free.column)
        cells[free.row][free.column] = ball
        addChild(ball)
    }
    
    private func firstFree() -> GridPosition? {
        for r in 0..<rows { for c in 0..<columns { if cells[r][c] == nil { return GridPosition(row: r, column: c) } }}
        return nil
    }
    
    // TODO: drag & merge logic, visitor interaction, level progression, soft currency
}
