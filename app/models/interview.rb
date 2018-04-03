class Interview < ApplicationRecord
  belongs_to :user
  enum acceptance:{"hold": 0,"accept": 1, "reject": 2}
end
