class AddAttachmentVideoToMicroposts < ActiveRecord::Migration
  def self.up
    add_column :microposts, :video_file_name, :string
		add_column :microposts, :video_content_type, :string
		add_column :microposts, :video_file_size, :integer
		add_column :microposts, :video_updated_at, :datetime
  end

  def self.down
    remove_column :microposts, :pvideo_file_name
		remove_column :microposts, :video_content_type
		remove_column :microposts, :video_file_size
		remove_column :microposts, :video_updated_at
  end
end
