class Upload < ActiveRecord::Base
  attr_accessible :upload
  has_attached_file :upload

  include Rails.application.routes.url_helpers
  
  has_many :quality_records

  def to_jq_upload
    {
      "name" => read_attribute(:upload_file_name),
      "size" => read_attribute(:upload_file_size),
      "url" => upload.url(:original),
      "delete_url" => upload_path(self),
      "delete_type" => "DELETE" 
    }
  end
  
  def stored_file_path
    file_path = self.upload.url.split("?").first
    file_path = Rails.root.to_s + "/public/" + file_path
    return file_path
  end

  def parse_vcf
    this_file_path = self.stored_file_path
    file_handle = File.open(this_file_path, 'r')
    vcf = Parser.new
    vcf.upload_id = self.id
    vcf.headers = Array.new
    while (line = file_handle.gets)
      vcf.parse_line(line)  
    end
    return vcf
  end

end
