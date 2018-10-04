def history?(argument)
  if argument=="history"
    CityJob.users.find_by(name: @@name)
  end
end
