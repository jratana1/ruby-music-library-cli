
class Artist
    extend Concerns::Findable
    attr_accessor :name, :songs
    
    @@all = []

    def initialize(name)
        @songs = []
        @name = name
        save
    end

    def save
        @@all << self
    end

    def self.all
        @@all
    end

    def songs
        @songs
    end

    def self.destroy_all
        @@all = []
    end

    def self.create(name)
        self.new(name)
    end

    def add_song(song)
        if song.artist == nil
            song.artist = self
        elsif !self.songs.include?(song)
            self.songs << song
        end
    end

    def genres
        self.songs.collect {|song| song.genre}.uniq
    end
end