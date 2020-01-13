require "./board.rb"
require "yaml"
require "byebug"
class Game

    def initialize(size = 9, saved_grid = nil)
        @board = Board.new(size, grid)
    end

    def save_game
        grid = @board.get_grid
        save_name = "saves/" + get_save_name + ".yaml"
        File.open(save_name, "w") { |file| file.write(grid.to_yaml) }
    end

    def get_save_name
        alphabet = "abcdefghijklmnopqrstuvwxyz"
        save_name = nil
        until save_name != nil
            begin
                save_prompt
                save_name = gets.chomp
                raise if !save_name.each_char.all? {|char|alphabet.include?(char.downcase)}
            rescue
                puts "invalid name"
                save_name = nil
            end
        end
        save_name
    end

    def save_prompt
        puts "Please type save name (must be letters only) :"
    end

    # def self.load_game(saved_grid)
    #     @board.load_grid(saved_grid)
    # end

    def self.run
        choice = get_menu_choice
        if choice == 'N'
            Game.new(Game.game_size).play_loop
        else
            grid = Game.select_game
            Game.new(grid.length,grid).play_loop
        end
    end

    def self.select_game
        game_name = get_game_name + ".yml"
        grid = YAML.load(File.read(game_name))
        grid
    end

    def self.get_game_name
        game_name = nil
        until game_name != nil
            begin
                puts "select game (type name) : "
                puts Dir["saves/*"]
                game_name = gets.chomp
            rescue
                puts "invalid entry"
                game_name = nil
            end
        end
        game_name
    end

    def self.menu_prompt
        puts
        puts "Play Minesweeper"
        puts "New Game 'N' or Load Game 'L' : "
    end

    def self.get_menu_choice
        choice = nil
        until choice != nil
            begin
                menu_prompt
                choice = (gets.chomp).upcase
                
                raise if !(choice == "N" || choice == "L")
            rescue
                puts "invalid choice"
                choice = nil
            end
        end
        choice
    end

    def self.game_size
        size = nil

        until size != nil
            begin
                Game.game_size_prompt
                size = Integer(gets.chomp)
                raise if !Game.valid_size(size)
            rescue
                puts "invalid size"
                size = nil
            end
        end
        size
    end

    def self.valid_size(size)
        size > 0
    end

    def self.game_size_prompt
        puts "Please choose a game size: Ex. (enter '3' for 3x3 a board) : "
    end

    def play_loop
        system "clear"
        @board.render
        win = false
        lose = false
        
        until win || lose
            turn
            if @board.lose?
                lose = true
                lose_prompt
            elsif @board.win?
                win = true
                win_prompt
            end
            system "clear"
            @board.render
        end
        game_over_prompt
    end

    def turn
        pos = get_pos
        act = get_act
        if act == "B"
            @board.reveal(pos)
        elsif act == "F"
            @board.flag(pos)
        end
    end

    def game_over_prompt
        puts "Game over."
    end

    def lose_prompt
        puts "You lose."
    end

    def win_prompt
        put "You Win!!!"
    end

    def get_act
        act = nil
        until act != nil
            begin
                prompt_act
                act = gets.chomp
                raise if !valid_act?(act)
            rescue
                puts "Invalid action"
                act = nil
            end
        end
        act
    end

    def get_pos
        pos = nil
        until pos != nil
            begin
                promt_pos
                pos = (gets.chomp).split(",").map {|coor| Integer(coor)}
                raise if !valid_pos?(pos)
            rescue
                puts "Invalid position."
                pos = nil
            end
        end
        pos
    end

    def prompt_act
        puts "Enter 'B' to Bomb or 'F' to Flag"
    end

    def promt_pos
        puts
        puts "Please enter a position. Ex. (2,1) : "
    end

    def valid_pos?(pos)
        return false if pos.length != 2
        x,y = pos
        x.between?(0,@board.length - 1) && y.between?(0,@board.length - 1)
    end

    def valid_act?(act)
        actions = ["B", "F"]
        act.length == 1 && actions.include?(act)
    end
end

Game.run