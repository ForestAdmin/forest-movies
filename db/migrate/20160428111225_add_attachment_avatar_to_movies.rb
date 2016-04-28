class AddAttachmentAvatarToMovies < ActiveRecord::Migration
  def self.up
    change_table :movies do |t|
      t.attachment :poster
    end

    Movie.all.each do |movie|
      if movie.poster_url && movie.poster.blank?
        begin
          URI.parse(movie.poster_url).open do |f|
            movie.poster = f
            movie.save
          end
        rescue
          puts 'err mais osef'
        end
      end
    end
  end

  def self.down
    remove_attachment :movies, :poster
  end
end
