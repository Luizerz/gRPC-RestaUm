//
//  File.swift
//
//
//  Created by Luiz Sena on 03/04/24.
//

import Foundation
import GRPC

@available(macOS 10.15, *)
final class MessageProvider: MyProto_MessageServiceAsyncProvider {

    private var sessions: [GameSession] = []

    private func verifySession() -> Int {
        let index = self.sessions.firstIndex { !$0.isInGame && $0.users.count < 2 }
        if index == nil {
            self.sessions.append(GameSession())
            return self.sessions.firstIndex { !$0.isInGame && $0.users.count < 2 }!
        } else {
            return index!
        }
    }

    private func playerInSession(_ user: MyProto_User) -> GameSession {
        return self.sessions.first { $0.users.contains { cUser in
            cUser.id == user.id
        } }!
    }

    private func turnHandler(_ session: GameSession) {
        session.users[0].isYourTurn.toggle()
    }

    func connect(request: MyProto_Empty, context: GRPC.GRPCAsyncServerCallContext) async throws -> MyProto_User {
        let newUser = MyProto_User.with {
            $0.id = UUID().uuidString
            $0.name = (1...200).randomElement()!.description
            $0.isYourTurn = false
        }
        let index = verifySession()
        let session = self.sessions[index]
        session.users.append(newUser)
        if session.users.count == 2 {
            session.isInGame.toggle()
            self.turnHandler(session)
        }
        let user = session.users.first { $0.id == newUser.id }!
        return user
    }

    func disconnect(request: MyProto_User, context: GRPC.GRPCAsyncServerCallContext) async throws -> MyProto_Empty {
        let session = playerInSession(request)
        session.users.removeAll { user in
            user.id == request.id
        }
        if session.isInGame { session.isInGame.toggle() }
        return MyProto_Empty()
    }

    func sendMessage(request: MyProto_Message, context: GRPC.GRPCAsyncServerCallContext) async throws -> MyProto_Empty {
        let session = playerInSession(request.user)
        session.messagesHistory.append(request)
        return MyProto_Empty()
    }


    func sendPlay(request: MyProto_Play, context: GRPC.GRPCAsyncServerCallContext) async throws -> MyProto_Empty {

        let session = playerInSession(request.user)
        switch request.direction {
        case .right:
            session.gameBoard.moveRight(itemRow: Int(request.row), itemColumn: Int(request.column))
        case .left:
            session.gameBoard.moveLeft(itemRow: Int(request.row), itemColumn: Int(request.column))
        case .top:
            session.gameBoard.moveUp(itemRow: Int(request.row), itemColumn: Int(request.column))
        case .bottom:
            session.gameBoard.moveDown(itemRow: Int(request.row), itemColumn: Int(request.column))
        default:
            print()
        }
        let userIndex = session.users.firstIndex { $0.id == request.user.id }!
        let nextUserIndex = session.users.firstIndex { $0.id != request.user.id }!
        session.users[userIndex].isYourTurn.toggle()
        session.users[nextUserIndex].isYourTurn.toggle()
        return MyProto_Empty()
    }

    func updateSessionStatus(request: MyProto_User, responseStream: GRPC.GRPCAsyncResponseStreamWriter<MyProto_SessionStatus>, context: GRPC.GRPCAsyncServerCallContext) async throws {
        let session = playerInSession(request)
        while !session.isInGame {
            usleep(1000)
            try await responseStream.send(MyProto_SessionStatus.with { $0.gameStarted = false })
        }
        try await responseStream.send(MyProto_SessionStatus.with { $0.gameStarted = true })
    }


    func updateMessages(request: MyProto_User, responseStream: GRPC.GRPCAsyncResponseStreamWriter<MyProto_Message>, context: GRPC.GRPCAsyncServerCallContext) async throws {
        let session = playerInSession(request)
        var index = 0
        while session.users.contains(where: {$0.id == request.id}) {
            usleep(1000)
            while index < session.messagesHistory.count {
                try await responseStream.send(session.messagesHistory[index])
                index += 1
            }
        }
    }

    func updateBoard(request: MyProto_User, responseStream: GRPC.GRPCAsyncResponseStreamWriter<MyProto_Board>, context: GRPC.GRPCAsyncServerCallContext) async throws {
        let session = playerInSession(request)
        while session.isInGame && session.users.contains(where: {$0.id == request.id}) {
            usleep(1000)
            let board = session.gameBoard.board.map { obj in MyProto_BoardColumn.with { $0.columns = obj.convertToProto()} }
            let message = MyProto_Board.with { $0.rows = board }
            try await responseStream.send(message)
        }
    }

    func updateTurn(request: MyProto_User, responseStream: GRPC.GRPCAsyncResponseStreamWriter<MyProto_User>, context: GRPC.GRPCAsyncServerCallContext) async throws {
        let session = playerInSession(request)
        while session.isInGame && session.users.contains(where: {$0.id == request.id}) {
            usleep(1000)
            let player = session.users.first { $0.id == request.id }

            if player != nil { try await responseStream.send(player!) }
        }
    }

    func updateGameStatus(request: MyProto_User, responseStream: GRPC.GRPCAsyncResponseStreamWriter<MyProto_GameStatus>, context: GRPC.GRPCAsyncServerCallContext) async throws {
        let session = playerInSession(request)
        while session.isInGame && session.users.contains(where: {$0.id == request.id}) {
            usleep(1000)
            let gameStatus = MyProto_GameStatus.with {
                $0.gameEnd = false
                $0.win = false
            }
            try await responseStream.send(gameStatus)
        }
        
        let player = session.users.first { user in
            user.id == request.id
        }
        if player == nil {
            let status = MyProto_GameStatus.with {
                $0.gameEnd = true
                $0.win = false
            }
            try await responseStream.send(status)
        } else {
            let status = MyProto_GameStatus.with {
                $0.gameEnd = true
                $0.win = true
            }
            try await responseStream.send(status)
        }
    }
}

