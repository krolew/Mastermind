# MasterMind
module TextContent
    def startInstruction
        puts "\n\nEnter 1 to be the code Maker or 2 to be code breaker "
    end
    def guessInformation(turn)
        puts "\nTurn #{turn} \nType in four numbers (1-6) to guess code"
    end
    def quessCorectness
        puts "\nYour code should only be 4 digits between 1-6"
    end
    def gameOver(local)
        puts "\nGame Over:C That was the code:".red + " #{local}"
    end
    def game_mode_info
        puts "Enter 1 to be the code Maker or 2 to be code breaker"
    end
    def code_breaker_start_instruction
        puts "\n\nComputer has set a code try to brake it."
    end
    def code_maker_start_instruction
        puts"Please enter 4-digit code for the computer to break."
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
        code_maker_start_instruction
        @player.code = gets.chomp
        checkPlayerGueesCorrectness
        changePlayerCodeToArray
        allCombination = generate_all_combinations
        while(@turn != 13)
                local = Marshal.load(Marshal.dump(@player.code))
                allCombinationLocal = Marshal.load(Marshal.dump(allCombination))
                @computer.code = playComputerGuess(allCombinationLocal)
                localComputer = Marshal.load(Marshal.dump(@computer.code))
                checkPlayerGuess
                showComputerCode(localComputer)
                printColors
                sleep 1
                codeOfXandO = quessToArray
                checkWins(local)
                @player.code = local
                @computer.code = localComputer
                removeMismatchedGuess(allCombination, localComputer)
                allCombination = compareAndDelete(allCombination, allCombinationLocal, codeOfXandO)
        end
    end

    def playComputerGuess(allCombinationLocal)
        # Inital guess
        arr = [[1,1,2,2],[1,1,3,3],[1,1,4,4],[1,1,5,5],[1,1,6,6],[2,2,3,3],[2,2,4,4],[2,2,5,5],[2,2,6,6],[3,3,4,4],[3,3,5,5],[3,3,6,6],[4,4,5,5],[4,4,6,6],[5,5,6,6]]
        rand_inital_guess = arr[rand(0..arr.length-1)]
        if @turn == 1
            rand_inital_guess
        else
            allCombinationLocal[rand(0..allCombinationLocal.length-1)]
        end
    end

    def showComputerCode(localComputer)
        puts "\n\nComputer turn #{@turn}"
        puts "Code: #{localComputer}"

    end

    def compareAndDelete(allCombination, allCombinationLocal, codeOfXandO)
        allCombinationLocal = Marshal.load(Marshal.dump(allCombinationLocal))
        goodArray = []
        allCombination.each_with_index do |sub_array, index|
            arr = []
            sub_array.each do |el|
                if(el == "x")
                    arr.push("x")
                elsif(el == "o")
                    arr.push("o")
                end
            end

            if arr == codeOfXandO
                goodArray.push(allCombinationLocal[index])
            end
        end
        goodArray

    end

    def removeMismatchedGuess(allCombination, localComputer)
        allCombination.each do |sub_array|
            localDump = Marshal.load(Marshal.dump(localComputer))
            for i in 0..sub_array.length - 1
                for j in 0..localComputer.length - 1
                    if(sub_array[i] == localComputer[j] && (1..6) === sub_array[i].to_i)
                        if(i == j)
                            sub_array[i] = "x"
                            localComputer[j] = "x"
                            break
                        else
                            if(sub_array[j] == localComputer[j] )
                                sub_array[j] = "x"
                                localComputer[j] = "x"
                            elsif(sub_array[i] == localComputer[i])
                                sub_array[i] == "x"
                                localComputer[i] == "x"
                            else
                                sub_array[i] = "o"
                                localComputer[j] = "o"
                            end
                        end
                    end
                end
            end
            localComputer = localDump
        end
    end

    def quessToArray
        arr = []
        @player.code.each do |el|
            if(el == "x")
                arr.push("x")
            elsif(el == "o")
                arr.push("o")
            end
        end
        arr
    end

    def generate_all_combinations
        [1, 2, 3, 4, 5, 6].repeated_permutation(4).to_a
    end

    def initial_guess
        arr = [[1,1,2,2],[1,1,3,3],[1,1,4,4],[1,1,5,5],[1,1,6,6],[2,2,3,3],[2,2,4,4],[2,2,5,5],[2,2,6,6],[3,3,4,4],[3,3,5,5],[3,3,6,6],[4,4,5,5],[4,4,6,6],[5,5,6,6]]
        rand_inital_guess = arr[rand(0..arr.length-1)]

        rand_inital_guess
    end
    def code_breaker
        code_breaker_start_instruction
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