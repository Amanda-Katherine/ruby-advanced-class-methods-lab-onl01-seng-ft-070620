require 'pry'
class Song
  attr_accessor :name, :artist_name
  @@all = []

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  def self.create
    song = self.new
    self.all << song
    song
  end

  def self.new_by_name(name)
    song = self.new
    song.name = name
    song
  end

  def self.create_by_name(name)
    # the 4 lines of code below, are correct and do the same thing as the one line of code that was submitted. 
    # song = self.new
    # song.name = name
    # self.all << song
    # song
   
    self.new_by_name(name).save.last
    #this way calls on a method already created that returns the instance of a song anytime a new song instance is created. 
    #The .save method is above and shovels any new instance into the self.class.all array
    #last returns the last element in the array
  end

  def self.find_by_name(name)
    self.all.find {|song_name| song_name.name == name }
  end

  def self.find_or_create_by_name(name)
   self.find_by_name(name) == nil ? self.create_by_name(name) : self.find_by_name(name) 
  end

    def self.alphabetical
      self.all.sort_by {|song| song.name}
    end

    def self.new_from_filename(filename)
      song = self.new
      song.name = filename.gsub(".mp3", "").split(" - ").pop
      song.artist_name = filename.split(" - ").shift    
      song   
        #self note: the only difference between this Class method and the create_from_filename below is the self.new vs the self.create (because below we need to save...the code above and below do the exact same thing minus this difference.)
    end

    def self.create_from_filename(filename) 
      song = self.create
      array = filename.split(" - ")
      song.name = array.pop.chomp(".mp3")
      song.artist_name = array[0]
      song
    end

    def self.destroy_all
      self.all.clear
    end
end
