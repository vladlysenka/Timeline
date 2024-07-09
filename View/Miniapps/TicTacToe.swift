// Created by Vlad Lysenka 09.07.2024

import SwiftUI

struct TicTacToe: View {
    @State private var board = Array(repeating: "", count: 9)
    @State private var currentPlayer = "X"
    @State private var gameOver = false
    @State private var message = ""
    @State private var scoreX = 0
    @State private var scoreO = 0

    let winningCombinations = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6]
    ]
    var body: some View {
        VStack {
            Text("Tic Tac Toe")
                .font(.largeTitle)
                .padding()

            Text("Player \(currentPlayer)'s turn")
                .font(.title)
                .padding()
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 15) {
                ForEach(0..<9) { index in
                    ZStack {
                        Rectangle()
                            .foregroundColor(.blue)
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)
                        
                        Text(board[index])
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    .onTapGesture {
                        playerTap(index)
                    }
                }
            }
            .padding()
            
            if gameOver {
                Text(message)
                    .font(.title)
                    .padding()
                
                Button("Restart") {
                    resetGame()
                }
                .padding()
            }
            
            HStack {
                Text("Score X: \(scoreX)")
                Spacer()
                Text("Score O: \(scoreO)")
            }
            .padding()
        }
        .padding()
    }

    private func playerTap(_ index: Int) {
        if board[index] == "" && !gameOver {
            board[index] = currentPlayer
            if checkWin() {
                message = "\(currentPlayer) Wins!"
                gameOver = true
                if currentPlayer == "X" {
                    scoreX += 1
                } else {
                    scoreO += 1
                }
            } else if board.contains("") {
                currentPlayer = currentPlayer == "X" ? "O" : "X"
            } else {
                message = "It's a Draw!"
                gameOver = true
            }
        }
    }

    private func checkWin() -> Bool {
        for combination in winningCombinations {
            if board[combination[0]] == currentPlayer &&
                board[combination[1]] == currentPlayer &&
                board[combination[2]] == currentPlayer {
                return true
            }
        }
        return false
    }

    private func resetGame() {
        board = Array(repeating: "", count: 9)
        currentPlayer = "X"
        gameOver = false
        message = ""
    }
}


#Preview {
    TicTacToe()
}
