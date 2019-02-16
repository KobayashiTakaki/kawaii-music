namespace :tracks do
  desc "tracks task"
  task random_order: :environment do
    ids = Track.ids.shuffle
    order = 0
    ids.each do |id|
      track = Track.find(id)
      track.random_order = order
      track.save!
      order += 1
    end
  end
end
