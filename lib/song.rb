class Song
    attr_accessor :name
    attr_reader :artist_name, :artist, :genre
    @@all = []
    def  artist= (artist)
        @artist = artist 
        self.artist.add_song(self)  
    end

    def  genre= (genre)
        @genre = genre
        if !genre.songs.include?(self)
        genre.songs << self
        end
    end
 
    def initialize(name, artist = nil, genre = nil)
            if artist != nil 
                self.artist = artist
            end 
            if genre != nil 
                self.genre = genre
            end 
        @name = name
        save
    end
 
    def save
        @@all << self
    end

    def self.all
     @@all
    end

    def self.destroy_all
        @@all = []
    end

    def self.create(name, artist = nil, genre = nil)
        self.new(name, artist, genre)
    end
 
    def self.find_by_name(name)
        self.all.select{|song| song.name == name}[0]
    end

    def self.find_or_create_by_name(name)
        self.find_by_name(name) ? self.find_by_name(name) : self.create(name)
    end

    def self.new_from_filename(file_name)
        song =(file_name.split(" - ")[1])
        artist =Artist.find_or_create_by_name(file_name.split(" - ")[0])
        genre = Genre.find_or_create_by_name(file_name.split(" - ")[2].split(".mp3")[0])
        self.new(song, artist, genre)
    end
 
    def self.create_from_filename(file_name)
        self.new_from_filename(file_name)
    end
 end