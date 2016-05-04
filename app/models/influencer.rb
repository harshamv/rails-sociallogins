class Influencer < ActiveRecord::Base

  # Associations
  has_many :influencer_authorizations

  # Validations


  # Methods

  def name
    first_name + " " + last_name
  end

  # Private Methods
  private

end
