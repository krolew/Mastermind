# MasterMind
module TextContent
    def startInstruction
        puts "\n\nComputer set 'code' now try to break the code. \nEnter 1 to be the code Maker or 2 to be code breaker "
    end
    def guessInformation(turn)
        puts "\nTurn #{turn} \nType in four numbers (1-6) to guess code"
    end
    def quessCorectness
        puts "\nYour guess should only be 4 digits between 1-6"
    end
    def gameOver(local)
        puts "\nGame Over:C That was the code:".red + " #{local}"
    end
    def game_mode_info
        puts "Enter 1 to be the code Maker or 2 to be code breaker"

    end
end



class String
    def black;          "\033[30m#{self}\033[0m" end
    def red;            "\033[31m#{self}\033[0m" end
    def green;          "\033[32m#{self}\033[0m" end
    def brown;          "\033[33m#{self}\033[0m" end
    def blue;           "\033[34m#{self}\033[0m" end
    def magenta;        "\033[35m#{self}\033[0m" end
    def cyan;           "\033[36m#{self}\033[0m" end
    def gray;           "\033[37m#{self}\033[0m" end
end

class Game
    include TextContent
    def initialize
        @computer = Computer.new
        @player = Player.new
        @turn = 1
    end

    def play
        startInstruction
        game_mode = game_selection
        if game_mode == "1"
            code_maker
        end
        if game_mode == "2"
            code_breaker
        end
    end

    def game_selection
        gameMode = gets.chomp
        until !!(gameMode=~ /^[1-2]{1}$/)
            game_mode_info
            gameMode = gets.chomp
        end
        gameMode
    end

    def code_maker
        sets = []

    end



    def code_breaker
        guessInformation(@turn)
        @player.code = gets.chomp
        checkPlayerGueesCorrectness
        while(@turn != 13 || checkWinningArray)
            local = Marshal.load(Marshal.dump(@computer.code))
            guessInformation(@turn)
            @player.code = gets.chomp
            checkPlayerGueesCorrectness
            changePlayerCodeToArray
            checkPlayerGuess
            printColors
            checkWins(local)
            @computer.code = local
        end
    end

    def printColors
        print "Clues:"
        @computer.code.shuffle.each do |el|
            if(el == "x")
                print " ● ".green
            elsif(el == "o")
                print " ● ".red
            end
        end
        print "\n"
    end

    def checkPlayerGueesCorrectness
        until !!(@player.code =~ /^[1-6]{4}$/)
            quessCorectness
            @player.code = gets.chomp
        end
    end

    def changePlayerCodeToArray
        @player.code = @player.code.split("").map { |num| num.to_i}
    end

    def checkPlayerGuess
        for i in 0..@computer.code.length - 1
            for j in 0..@player.code.length - 1
                if(@computer.code[i] == @player.code[j] && (1..6) === @computer.code[i].to_i)
                    if(i == j)
                        @computer.code[i] = "x"
                        @player.code[j] = "x"
                        break
                    else
                        if(@computer.code[j] == @player.code[j] )
                            @computer.code[j] = "x"
                            @player.code[j] = "x"
                        elsif(@computer.code[i] == @player.code[i])
                            @computer.code[i] == "x"
                            @player.code[i] == "x"
                        else
                            @computer.code[i] = "o"
                            @player.code[j] = "o"
                        end
                    end
                end
            end
        end
    end

    def checkWins(local)
        @turn += 1
        if(checkWinningArray)
            @turn = 13
            puts "\nCongratulations you won!!! :)"
        elsif(!checkWinningArray && @turn == 13)
            gameOver(local)
        end
    end

    def checkWinningArray
        @computer.code.all? { |digit| digit == "x"}
    end
end

class Player
    attr_accessor :code

    def initialize
        @code = []
    end
end

class Computer
    attr_accessor :code

    def initialize
        @code = self.setCode
    end

    def setCode
        code = []
        for i in (0..3)
            code.push(rand(1..6))
        end
        code
    end
end

Game.new.play