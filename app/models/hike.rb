class Hike < ActiveRecord::Base

  require 'date'
  require 'json'

  has_many :comments, :dependent => :destroy
  belongs_to :user

  def self.all_ratings ; %w[ 0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 ] ; end
  def self.all_types ; %w[ T E EE EEA EAI ] ; end
  def self.all_difficulty ; %w[ P, I, E ] ; end

  attr_accessor :filename

  FILENAME_REGEX = /\.gpx$/i

  validates :name, :presence => true, :length => { :in => 1..20 }
  validates :difficulty, :presence => true, :inclusion => { :in => %w( P I E )}
  #validates :filename, :format => FILENAME_REGEX
  #validates :nature, :length => { :in 0..128 }
  validates :rating, :presence => true, :inclusion => 0..5
  validates :tipo, :presence => true, :inclusion =>  { :in => %w( T E EE EEA EAI ) }

  before_save :parse_gpx
  after_save :destroy_gpxfile

  def parse_gpx
    r = Array.new
    max = 0.0
    min = 10000.0
    count = 0
    init_time = 0.0
    finish_time = 0.0
    length = 0.0

    if filename.present?
      file = File.open(filename)
      doc = Nokogiri::XML(file)
      trackpoints = doc.xpath('//xmlns:trkpt')

      trackpoints.each do |trkpt|
        if count = 0
          init_time = Time.parse(trkpt.text.strip.to_s).to_f
        end
        if max < trkpt.text.strip.to_f
          max = trkpt.text.strip.to_f
        end
        if min > trkpt.text.strip.to_f
          min = trkpt.text.strip.to_f
        end
        finish_time = Time.parse(trkpt.text.strip.to_s).to_f
        lat = trkpt.xpath('@lat').to_s.to_f
        lon = trkpt.xpath('@lon').to_s.to_f
        ele = trkpt.text.strip.to_f
        r << {lat: lat, lon: lon, ele: ele}
        count += 1
      end

      for i in 0..(r.length-2) do
        length += Geocoder::Calculations.distance_between([r[i][:lat].to_f,r[i][:lon].to_f], [r[i+1][:lat].to_f,r[i+1][:lon].to_f])
      end
    end
    self.avg_time = finish_time-init_time
    self.distance = length.to_f.round(2)
    self.max_height = max.round(2)
    self.min_height = min.round(2)
    self.level_difference = (max-min).round(2)
    self.route = r.to_json
  end

  def destroy_gpxfile
    self.filename = nil
  end

end
