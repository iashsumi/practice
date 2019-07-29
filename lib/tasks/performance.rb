class Tasks::Performance
  # docker-compose exec app bundle exec rails runner Tasks::Perfprmance.execute
  def self.execute
    p Time.zone.now.strftime("%H:%M:%S")
    a = []
    User.all.each do | item |
      a << item.name
    end
    
    p a.length

    #p User.where(name: '43ca1811-fb60-4530-a6cd-727817efba22').length
    # p ActiveRecord::Base.connection.select_all('select a.* from users as a left join users as b on a.name = b.name').to_hash.length
    p Time.zone.now.strftime("%H:%M:%S")

    # p 'start'
    # p Time.now
    # users = []
    # 100000.times do | i |
    #   users << User.new(name: SecureRandom.uuid)
    # end
    # p Time.now
    # User.import(users)
    # p Time.now
  end

  def self.memory
    # find_each
    # p Time.zone.now.strftime("%H:%M:%S")
    # a = []
    # User.all.find_each do | item |
    #   a << item.name
    # end
    # p a.length
    # p Time.zone.now.strftime("%H:%M:%S")

    # no find_each
    # p Time.zone.now.strftime("%H:%M:%S")
    # a = []
    # User.all.each do | item |
    #   a << item.name
    # end
    # p a.length
    # p Time.zone.now.strftime("%H:%M:%S")

    # sort limit 指定
    p Time.zone.now.strftime("%H:%M:%S")
    a = []
    User.all.order(:name).find_each do | item |
      a << item.name
    end
    p a[0]
    p a[1]
    p a[2]
    p a[3]
    p a[4]
    p a[5]
    p Time.zone.now.strftime("%H:%M:%S")

    # p Time.zone.now.strftime("%H:%M:%S")
    # a = []
    # User.all.order(:name).each do | item |
    #   a << item.name
    # end
    # p a[0]
    # p a[1]
    # p a[2]
    # p a[3]
    # p a[4]
    # p a[5]
    # p Time.zone.now.strftime("%H:%M:%S")
  end
end


