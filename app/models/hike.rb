class Hike < ActiveRecord::Base

  require 'date'
  require 'json'

  has_many :comments, :dependent => :destroy
  has_many :users, :through => :comments

  def self.all_ratings ; %w[ 0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 ] ; end
  def self.all_types ; %w[ T E EE EEA EAI ] ; end
  def self.all_difficulty ; %w[ P, I, E ] ; end

  attr_accessor :filename

  FILENAME_REGEX = /\.gpx$/i

  validates :name, :presence => true, :length => { :in => 3..20 }
  validates :difficulty, :presence => true, :inclusion => { :in => Hike.all_difficulty}
  #validates :filename, :format => FILENAME_REGEX
  #validates :nature, :length => { :in 0..128 }
  validates :rating, :presence => true, :inclusion => { :in => Hike.all_ratings}
  validates :tipo, :presence => true, :inclusion =>  { :in => Hike.all_types }

  before_save :parse_gpx
  after_save :destroy_gpxfile

  def self.parse_gpx
    r = Array.new
    max = 0.0
    min = 10000.0
    count = 0
    init_time = nil
    finish_time = nil
    length = 0.0

    if filename.present?
      file = File.open(filename)
      doc = Nokogiri::XML(file)
      trackpoints = doc.xpath('//xmlns:trkpt')

      trackpoints.each do |trkpt|
        if count = 0
          init_time = Time.parse(trkpt.xpath('/time').to_s).to_f
        end
        if max < trkpt.text.strip.to_f
          max = trkpt.text.strip.to_f
        end
        if min > trkpt.text.strip.to_f
          min = trkpt.text.strip.to_f
        end
        finish_time = Time.parse(trkpt.xpath('/time').to_s).to_f
        lat = trkpt.xpath('@lat').to_s.to_f
        lon = trkpt.xpath('@lon').to_s.to_f
        ele = trkpt.text.strip.to_f
        r << {lat: lat, lon: lon, ele: ele}
      end
      for i in r.length-1 do
        length+= Geocoder::Calculations.distance_between([r[i][lat].to_f, r[i][lon].to_f], [r[i+1][lat].to_f, r[i+1][lon].to_f])
      end
      count+=1
      self.avg_time = finish_time-init_time
      self.distance = length.to_f
      self.max_height = max
      self.min_height = min
      self.level_difference = max-min
      self.route = r.to_json
    end
  end

  def destroy_gpxfile
    self.filename = nil
  end

end
