require "sinatra"
require "faker"

class Array
  def extract_options!
    last.is_a?(::Hash) ? pop : {}
  end

end

class Person
  attr_accessor :name, :bio, :email, :github, :twitter, :website

  def initialize
    init_name
    init_bio
    init_email
    init_twitter
  end

  private

  def init_name
    self.name = Faker::Name.name
  end

  def init_bio
    self.bio = "Bio here " + Faker::Lorem.sentences(3 + rand(5)).join("  ")
  end

  def init_email
    self.email = Faker::Internet.email
  end

  def init_twitter
    self.twitter = name.downcase.gsub(" ", '.')
  end
end

helpers do
  def partial(template, *args)
    options = args.extract_options!
    options.merge!(:layout => false)
    if collection = options.delete(:collection) then
      collection.inject([]) do |buffer, member|
        buffer << erb(template, options.merge(
          :layout => false, 
          :locals => {template.to_sym => member}
        )
                      )
      end.join("\n")
    else
      erb(template, options)
    end
  end
end

get "/" do
  @people = []
  20.times { @people << Person.new }
  @people = @people.sort_by { |person| person.name }
  erb :index
end
