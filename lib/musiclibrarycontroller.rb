require 'pry'
class MusicLibraryController
    attr_accessor :path
    def initialize (path = "./db/mp3s")
        @path = path
        MusicImporter.new(path).import     
    end

    def call
        input = []
        while input != "EXIT"
            puts "Welcome to your music library!"
            puts "To list all of your songs, enter 'list songs'."
            puts "To list all of the artists in your library, enter 'list artists'."
            puts "To list all of the genres in your library, enter 'list genres'."
            puts "To list all of the songs by a particular artist, enter 'list artist'."
            puts "To list all of the songs of a particular genre, enter 'list genre'."
            puts "To play a song, enter 'play song'."
            puts "To quit, type 'exit'."
            puts "What would you like to do?"
                input = gets.strip.upcase

            case input
                when 'list songs'.upcase
                    list_songs
                when 'LIST ARTISTS'
                    list_artists
                when 'LIST GENRES'
                    list_genres
                when 'LIST ARTIST'
                    list_songs_by_artist
                when 'LIST GENRE'
                    list_songs_by_genre
                when 'PLAY SONG'
                    play_song
            end
        
        end
    end

    def list_songs
        sort = Song.all.sort{|a,b| a.name <=> b.name}
        sort.each_with_index do|song, index|
            puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
    end

    def list_artists
        sort = Artist.all.sort{|a,b| a.name <=> b.name}
        sort.each_with_index do|artist, index|
            puts "#{index+1}. #{artist.name}"
        end
    end

    def list_genres
        Genre.all.sort{|a,b| a.name <=> b.name}.each_with_index do|genre, index|
            puts "#{index+1}. #{genre.name}"
        end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.strip
            
        if Song.all.any? {|song| song.artist.name == input}
            artist = Artist.all.select{|artist| artist.name == input}[0]
            artist.songs.sort {|a, b| a.name <=> b.name}.each_with_index do|song,index|
                puts "#{index+1}. #{song.name} - #{song.genre.name}"
            end
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.strip
            
        if Song.all.any? {|song| song.genre.name == input}
            genre = Genre.all.select{|genre| genre.name == input}[0]
            genre.songs.sort {|a, b| a.name <=> b.name}.each_with_index do|song,index|
                puts "#{index+1}. #{song.artist.name} - #{song.name}"
            end
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        input = gets.strip.to_i

        if 0 < input && input <= Song.all.length
            sort = Song.all.sort{|a,b| a.name <=> b.name}
            puts "Playing #{sort[input-1].name} by #{sort[input-1].artist.name}"
        end
    end

end