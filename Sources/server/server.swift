//
//  File.swift
//
//
//  Created by Luiz Sena on 03/04/24.
//

import ArgumentParser
import GRPC
import NIOCore
import NIOPosix

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
@main
struct HelloWorld: AsyncParsableCommand {
    @Option(help: "The port to listen on for new connections")
    var port = 1234

    func run() async throws {
        let group = MultiThreadedEventLoopGroup(numberOfThreads: 2)
        defer {
            try! group.syncShutdownGracefully()
        }

        // Start the server and print its address once it has started.
        let server = try await Server.insecure(group: group)
            .withServiceProviders([MessageProvider()])
            .bind(host: "localhost", port: self.port)
            .get()

        print("server started on port \(server.channel.localAddress!.port!)")
        // Wait on the server's `onClose` future to stop the program from exiting.
        try await server.onClose.get()
    }
}


class GameSession {
    var users: [MyProto_User] = [] {
        didSet {
            print(users)
        }
    }
    var gameBoard = GameBoard()
    var messagesHistory: [MyProto_Message] = []
    var isInGame: Bool = false
}

class GameBoard {

    private var matrix = [[BoardValue]]()
    var board: [[BoardValue]] {
        return matrix
    }

    init() {
        setupMatrix()
    }

    private func setupMatrix() {
        for i in 0 ... 6 {
            if (i == 0 || i == 1 || i == 5 || i == 6) {
                self.matrix.append([.null,.null,.on,.on,.on,.null,.null])
            } else if (i == 3){
                self.matrix.append([.on,.on,.on,.off,.on,.on,.on])
            } else {
                self.matrix.append([.on,.on,.on,.on,.on,.on,.on])
            }
        }
    }

    func moveDown(itemRow: Int, itemColumn: Int) {
        let item = matrix[itemRow][itemColumn]
        let bottomItem = matrix[itemRow + 1][itemColumn]
        let destinyItem = matrix[itemRow + 2] [itemColumn]

        if item == .on && bottomItem == .on && destinyItem == .off {
            matrix[itemRow][itemColumn].toggle()
            matrix[itemRow + 1][itemColumn].toggle()
            matrix[itemRow + 2][itemColumn].toggle()
            print("Jogada Validada")
        } else {
            print("Jogada Invalida")
        }
    }

    func moveUp(itemRow: Int, itemColumn: Int){
        let item = matrix[itemRow][itemColumn]
        let topItem = matrix[itemRow - 1][itemColumn]
        let destinyItem = matrix[itemRow - 2][itemColumn]

        if item == .on && topItem == .on && destinyItem == .off {
            matrix[itemRow][itemColumn].toggle()
            matrix[itemRow - 1][itemColumn].toggle()
            matrix[itemRow - 2][itemColumn].toggle()
            print("Jogada Validada")
        } else {
            print("Jogada Invalidada")
        }
    }

    func moveRight(itemRow: Int, itemColumn: Int) {
        let item = matrix[itemRow][itemColumn]
        let rightItem = matrix[itemRow][itemColumn + 1]
        let destinyItem = matrix[itemRow][itemColumn + 2]

        if item == .on && rightItem == .on && destinyItem == .off {
            matrix[itemRow][itemColumn].toggle()
            matrix[itemRow][itemColumn + 1].toggle()
            matrix[itemRow][itemColumn + 2].toggle()
            print("Jogada Validada")
        } else {
            print("Jogada Invalidada")
        }
    }

    func moveLeft(itemRow: Int, itemColumn: Int) {
        let item = matrix[itemRow][itemColumn]
        let leftItem = matrix[itemRow][itemColumn - 1]
        let destinyItem = matrix[itemRow][itemColumn - 2]

        if item == .on && leftItem == .on && destinyItem == .off {
            matrix[itemRow][itemColumn].toggle()
            matrix[itemRow][itemColumn - 1].toggle()
            matrix[itemRow][itemColumn - 2].toggle()
            print("Jogada Validada")
        } else {
            print("Jogada Invalidada")
        }
    }
}


enum BoardValue {
    case null
    case on
    case off

    mutating func toggle() {
        switch self {
        case .off :
            self = .on
        case .on:
            self = .off
        default:
            ()
        }
    }
}

extension BoardValue {

    init(_ protoBoardValue: MyProto_BoardValue) {
        switch protoBoardValue {
        case .on:
            self = .on
        case .off:
            self = .off
        case .null:
            self = .null
        case .UNRECOGNIZED(let int):
            self = .null
        }
    }
}

extension Array where Element == BoardValue {
    func convertToProto() -> [MyProto_BoardValue] {
        let arr = self.map {
            switch $0 {
            case .on:
                MyProto_BoardValue.on
            case .off:
                MyProto_BoardValue.off
            case .null:
                MyProto_BoardValue.null
            }
        }
        return arr
    }
}


