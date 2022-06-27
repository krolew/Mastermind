# MasterMind
module TextContent
    def startInstruction
        puts "\n\nComputer set 'code' now try to break the code"
    end
    def guessInformation
        puts "\nType in four numbers (1-6) to guess code"
    end
    def quessCorectness
        puts "\nYour guess should only be 4 digits between 1-6"
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
    end

    def play
        startInstruction
        quessingCode
    end

    def quessingCode
        while(@computer.code != @player.code)
            guessInformation
            @player.code = gets.chomp
            checkPlayerGueesCorrectness
            changePlayerCodeToArray
        end
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