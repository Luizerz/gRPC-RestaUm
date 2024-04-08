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
        return self.sessions.first { $0.users.contains(user) }!
    }

    func connect(request: MyProto_Empty, context: GRPC.GRPCAsyncServerCallContext) async throws -> MyProto_User {
        let newUser = MyProto_User.with {
            $0.id = UUID().uuidString
            $0.name = (1...200).randomElement()!.description
        }
        let index = verifySession()
        let session = self.sessions[index]
        session.users.append(newUser)
        if session.users.count == 2 { session.isInGame.toggle() }
        return newUser
    }

    func disconnect(request: MyProto_User, context: GRPC.GRPCAsyncServerCallContext) async throws -> MyProto_Empty {
        let session = playerInSession(request)
        session.users.removeAll { user in
            user.id == request.id
        }
        return MyProto_Empty()
    }

    func sendMessage(request: MyProto_Message, context: GRPC.GRPCAsyncServerCallContext) async throws -> MyProto_Empty {
        let session = playerInSession(request.user)
        session.messagesHistory.append(request)
        return MyProto_Empty()
    }

    func updateMessages(request: MyProto_User, responseStream: GRPC.GRPCAsyncResponseStreamWriter<MyProto_Message>, context: GRPC.GRPCAsyncServerCallContext) async throws {
        let session = playerInSession(request)
        var index = 0
        while session.users.contains(request) {
            usleep(500)
            while index < session.messagesHistory.count {
                try await responseStream.send(session.messagesHistory[index])
                index += 1
            }
        }
    }

    func sendPlay(request: MyProto_Play, context: GRPC.GRPCAsyncServerCallContext) async throws -> MyProto_Empty {
        MyProto_Empty()
    }

    func updateBoard(request: MyProto_User, responseStream: GRPC.GRPCAsyncResponseStreamWriter<MyProto_Board>, context: GRPC.GRPCAsyncServerCallContext) async throws {
        let session = playerInSession(request)
        let board = session.gameBoard.board

    }

    func updateTurn(request: MyProto_User, responseStream: GRPC.GRPCAsyncResponseStreamWriter<MyProto_Turn>, context: GRPC.GRPCAsyncServerCallContext) async throws {
        print()
    }
}

