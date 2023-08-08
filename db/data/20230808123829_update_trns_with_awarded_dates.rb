# frozen_string_literal: true

class UpdateTrnsWithAwardedDates < ActiveRecord::Migration[7.0]
  def up
    [
      ["9rAgQfSXnrzvXaoyiFuJuexG", "6/30/2023"],
      ["BwURWqqBWHpMtNB8oFc49xPj", "7/28/2023"],
      ["uXNQJNt7kZ3DNWHkAvUQXNmY", "7/14/2023"],
      ["RwCeiJ59u2pAogPnqELpAHHj", "6/15/2023"],
      ["6fYuoszaYrttJKwXrYP37BTV", "7/12/2023"],
      ["W7CKqCmmVPyy6q2BdescEdTy", "7/13/2023"],
      ["j6J9NKD6vq8eJ3T6ERGWFYhC", "7/17/2023"],
      ["DUEpysaZRnQViSe9NdDePAHr", "7/28/2023"],
      ["MxWUZv2jdamwG9K5v6PUuQiX", "7/19/2023"],
      ["EWX6MiZmHhLyCTR8RRyAUg4j", "7/13/2023"],
      ["TrGPQeHdcSHsVQzbjAaxVYPx", "6/15/2023"],
      ["WEg8K8d1aLovJVDCSyco7wP2", "7/19/2023"],
      ["Kun4yHg8U1UpQXNjcmgcvqhk", "7/31/2023"],
      ["ANsbXMZ6bvywh869MJiDG843", "8/1/2000"],
      ["UiJ9yekxCnw1W5yxVBhcu1PH", "7/10/2023"],
      ["4Z49kszTdpT8Hz7VwNqhE7e2", "8/1/2023"],
      ["VhqFKDUFJik9mt9QP3cJj7DY", "7/28/2023"],
      ["ogfiuSffDEbZYDUP9agocCVf", "7/19/2023"],
      ["CQjeLF2QxqbhHhLPa5NcXha3", "8/1/2023"],
      ["xboT3ksCeTNLbDmeKKRWUPps", "5/22/2023"],
      ["nZbpQXhn4ozzdndEFTu4foWh", "7/18/2023"],
      ["VJztTm6dFjfAqbvQhaQ3VzDb", "7/28/2023"],
      ["2uZpqV2KaTKcah5v8JwoH83j", "7/13/2023"],
    ].each do |slug, awarded_at|
      trainee = Trainee.find_by(slug:)
      next unless trainee

      trainee.assign_attributes(state: :awarded, awarded_at: DateTime.parse(awarded_at), defer_date: nil, withdraw_date: nil)
      trainee.save!
    end

    Trainee.find_by(trn: 2241356)&.update!(trn: 1987821, audit_comment: "TRN needed correcting")
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
