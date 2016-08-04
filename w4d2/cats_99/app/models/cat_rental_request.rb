class CatRentalRequest < ActiveRecord::Base
  validates :status, inclusion: {in: ["PENDING", "APPROVED", "DENIED"]}, presence: true
  validates :cat_id, :start_date, :end_date, presence: true
  validate :overlapping_requests

  belongs_to :cat, :dependent => :destroy

  def approve!
    pending_overlaps = overlapping_pending_requests
    self.transaction do
      self.status = 'APPROVED'
      self.save
      pending_overlaps.each do |el|
        el.deny!
      end
    end
  end

  def deny!
    self.transaction do
      self.status = "DENIED"
      self.save!
    end
  end



  def overlapping_requests
    unless no_overlapping_requests
      errors.add(:start_date, "Rental requests cannot overlap.")
    end
  end

  def no_overlapping_requests
    return true if self.status != "APPROVED"
    approved_requests = CatRentalRequest.where("cat_id = ? AND status = 'APPROVED' AND id != ?", self.cat_id, self.id)
    .where(<<-SQL)
      start_date BETWEEN '#{self.start_date}' AND '#{self.end_date}' OR
      end_date BETWEEN '#{self.start_date}' AND '#{self.end_date}'
    SQL
    .count == 0
  end

  def overlapping_pending_requests
    approved_requests = CatRentalRequest.where("cat_id = ? AND status = 'PENDING' AND id != ?", self.cat_id, self.id)
    .where(<<-SQL)
      start_date BETWEEN '#{self.start_date}' AND '#{self.end_date}' OR
      end_date BETWEEN '#{self.start_date}' AND '#{self.end_date}'
    SQL
  end

end
