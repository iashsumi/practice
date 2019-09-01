# rubocop:disable all
class Tasks
  class Performance
    # docker-compose exec app bundle exec rails runner Tasks::Performance.execute
    def self.execute
      Rails.logger.debug(Time.zone.now.strftime('%H:%M:%S'))
      10_000.times do |i|
        user = User.new
        user.name = "test#{i}"
        user.address = 'tokyo'
        user.email = 'test@example.com'
        user.save
      end
      Rails.logger.debug(Time.zone.now.strftime('%H:%M:%S'))
    end

    def self.execute2
      users = []
      Rails.logger.debug(Time.zone.now.strftime('%H:%M:%S'))
      10_000.times do |i|
        user = User.new
        user.name = "test#{i}"
        user.address = 'tokyo'
        user.email = 'test@example.com'
        users << user
      end
      Rails.logger.debug(User.import(users))
      Rails.logger.debug(Time.zone.now.strftime('%H:%M:%S'))
    end

    # activerecord-import(add transaction)
    def self.execute3
      users = []
      Rails.logger.debug(Time.zone.now.strftime('%H:%M:%S'))
      User.transaction do
        100_000.times do |i|
          user = User.new
          user.name = "test#{i}"
          user.address = 'tokyo'
          user.email = 'test@example.com'
          users << user
        end
        Rails.logger.debug(User.import(users))
      end
      Rails.logger.debug(Time.zone.now.strftime('%H:%M:%S'))
    end
  end
end
# rubocop:enable all
