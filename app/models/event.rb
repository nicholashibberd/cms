class Event 
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes
  
  belongs_to :event_series
  belongs_to :group
  
  field :title
  field :location
  field :start_time, :type => DateTime
  field :end_time, :type => DateTime
  field :summary
  field :description  
  field :content
  field :all_day
  field :period
  field :frequency
  field :position  
  field :series_id
  field :category
  
  validates_presence_of :start_time

  scope :top_level, where(:group_id => nil)  
  scope :upcoming, where(:start_time.gte => Time.now).asc(:start_time)
  scope :by_category, lambda {|category| where(:category => category)}
  scope :by_group, lambda {|group_id| where(:group_id => group_id)}
  
  #def find_events_by_month(month)
    #events.select {|event| event.start_date.month == month}
  #end  
  
  REPEATS = [
              "Does not repeat",
              "Daily"          ,
              "Weekly"         ,
              "Monthly"        ,
              "Yearly"         ,
              "Monday"         ,
              "Tuesday"        ,
              "Wednesday"      ,
              "Thursday"       ,
              "Friday"         ,
              "Saturday"       ,
              "Sunday"         ,
  ]
  
  CATEGORIES = [
              "All",
              "Service",
              "Coffee Morning",
              "Charity",
              "Fundraising",
              "Speaker",
              "Concert",
              "Meeting",
              "Social"
  ]
    
  def start_date
    start_time.to_date
  end
  
  def end_date
    end_time.to_date
  end
  
  def self.by_month_and_year(month, year)
    Event.all.select {|event| event.start_time.month == month && event.start_time.year == year}
  end
  
  def self.events_by_date(category, number_to_display)
    events_by_category = category == 'All' ? self.upcoming : self.upcoming.by_category(category)
    upcoming_events = events_by_category.limit(number_to_display).asc(:date)
    upcoming_events.group_by {|event| event.start_date}
  end  
  
  def self.grouped_by_day(category, group)
    events = self.all
    events = events.by_category(category) if category
    events = events.by_group(group.id) if group
    events.group_by {|event| event.start_date}
  end
  
    
end
