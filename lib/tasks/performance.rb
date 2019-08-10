class Tasks::Performance
  # docker-compose exec app bundle exec rails runner Tasks::Performance.execute
  def self.execute
    users = []
    p Time.zone.now.strftime("%H:%M:%S")
    10000.times do | i |
      user = User.new
      user.name = "test#{i}"
      user.address = "tokyo"
      user.email = "test@example.com"
      user.save
    end
    p Time.zone.now.strftime("%H:%M:%S")
  end

  def self.execute2
    users = []
    p Time.zone.now.strftime("%H:%M:%S")
    10000.times do | i |
      user = User.new
      user.name = "test#{i}"
      user.address = "tokyo"
      user.email = "test@example.com"
      users << user
    end
    p User.import(users)
    p Time.zone.now.strftime("%H:%M:%S")
  end

  # activerecord-import(add transaction)
  def self.execute3
    users = []
    p Time.zone.now.strftime("%H:%M:%S")
    User.transaction do
      100000.times do | i |
        user = User.new
        user.name = "test#{i}"
        user.address = "tokyo"
        user.email = "test@example.com"
        users << user
      end
      p User.import(users)
    end
    p Time.zone.now.strftime("%H:%M:%S")
  end
end


