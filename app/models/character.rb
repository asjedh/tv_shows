class Character < ActiveRecord::Base
  validates :character_name,
    presence: true,
    uniqueness: { scope: :television_show_id }
  validates :actor_name, presence: true
  validates :television_show_id, presence: true

  belongs_to :television_show
end

