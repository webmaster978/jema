class Post < ApplicationRecord
    has_one_attached :image
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :like_posts, dependent: :destroy
    has_many :taggings, dependent: :destroy
    has_many :tags, through: :taggings

    def tag_list
        self.tags.collect do |tag|
          tag.name
        end.join(", ")
    end

    def tag_list=(tags_string)
        tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
        new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
        self.tags = new_or_found_tags
    end

end