class Genre
    attr_accessor :name, :songs
    extend Concerns::Findable
    @@all = []

    def initialize(name)
        @name = name
        @songs = []
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

    def artists
        self.songs.collect{|song| song.artist}.uniq
    end
end