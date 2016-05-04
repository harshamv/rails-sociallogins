class InfluencerAuthorization < ActiveRecord::Base

  @providers = %w(facebook twitter instagram)

  # Associations
  belongs_to :influencer

  # Validations
  validates :provider, inclusion: { in: @providers,
                                    message: "Please choose a valid Provider." },
                       presence: { message: 'Please choose a Provider.' }

  validates :provider_uid, presence: { message: 'Please assign a Provider UID.' }

  validates :oauth_token, presence: { message: 'Please assign a OAuth Token.' }

end
