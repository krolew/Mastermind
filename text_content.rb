
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