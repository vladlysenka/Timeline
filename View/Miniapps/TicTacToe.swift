// Created by Vlad Lysenka 09.07.2024

import SwiftUI

struct TicTacToe: View {
    @State private var board = Array(repeating: "", count: 9)
    @State private var currentPlayer = "X"
    @State private var gameOver = false
    @State private var message = ""
    @AppStorage("score_x") private var scoreX = 0
    @AppStorage("score_o") private var scoreO = 0
    
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
    
    let columns = Array(repeating: GridItem(spacing: 15), count: 3)
    
    var body: some View {
        VStack(spacing: 25) {
            HStack {
                Text("Tic Tac Toe")
                    .font(.system(size: 35, weight: .bold, design: .rounded))
                    .foregroundStyle(.gray)
                
                Spacer()
                
                Menu {
                    Button("Сбросить счетчик", systemImage: "delete.left") {
                        scoreX = 0
                        scoreO = 0
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .font(.title2)
                }
            }
            
            Text("Ход  **\(currentPlayer)**")
                .font(.system(size: 25, design: .rounded))
            
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(0..<9) { index in
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(.ultraThinMaterial)
                        .frame(height: 100)
                        .background(board[index] == "" ? .green : board[index] == "X" ? .red : .blue, in: .rect(cornerRadius: 20).stroke(lineWidth: 1))
                        .overlay {
                            Text(board[index])
                                .font(.system(size: 50, weight: .semibold, design: .rounded))
                                .foregroundStyle(board[index] == "X" ? .red : .blue)
                        }
                        .onTapGesture {
                            playerTap(index)
                        }
                }
            }
            
            HStack {
                Score(title: "X", value: scoreX, color: .red)
                
                Spacer()
                
                Score(title: "O", value: scoreO, color: .blue, true)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .alert(message, isPresented: $gameOver) {
            Button("Рестарт") {
                resetGame()
            }
        }
        .overlay(alignment: .topLeading) {
            Dismiss()
        }
    }
    
    @ViewBuilder func Score(title: String, value: Int, color: Color, _ isAngel: Bool = false) -> some View {
        HStack(spacing: 15) {
            Text(title)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundStyle(color)
            
            Divider()
            
            Text("\(value)")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .rotationEffect(.degrees(isAngel ? 180 : 0))
        }
        .frame(height: 40)
        .padding(.horizontal)
        .background(.ultraThinMaterial, in: .rect(cornerRadius: 16))
        .rotationEffect(.degrees(isAngel ? 180 : 0))
    }
    
    private func playerTap(_ index: Int) {
        if board[index] == "" && !gameOver {
            board[index] = currentPlayer
            if checkWin() {
                message = "\(currentPlayer) Выиграли!"
                gameOver = true
                if currentPlayer == "X" {
                    scoreX += 1
                } else {
                    scoreO += 1
                }
            } else if board.contains("") {
                currentPlayer = currentPlayer == "X" ? "O" : "X"
            } else {
                message = "Ничья"
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
