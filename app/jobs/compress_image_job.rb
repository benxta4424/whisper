# app/jobs/compress_image_job.rb
class CompressImageJob < ApplicationJob
  queue_as :default

  def perform(record_id, record_class, attachment_name)
    record = record_class.constantize.find_by(id: record_id)
    return unless record && record.send(attachment_name).attached?
    
    attachment = record.send(attachment_name)
    
    # Force the creation of the variants used in your views:
    
    # 1. Variant for the large profile picture (e.g., in edit.html.erb, resize_to_limit: [300, 300])
    attachment.variant(resize_to_limit: [300, 300]).processed 
    
    # 2. Variant for the post feed thumbnail (e.g., in resize_user_logo_posts, resize_to_fill:[70,70])
    attachment.variant(resize_to_fill: [70, 70]).processed
    
    # 3. Variant for the comment thumbnail (e.g., in _render_comment_text, resize_to_fill:[40, 40])
    attachment.variant(resize_to_fill: [40, 40]).processed
  end
end
