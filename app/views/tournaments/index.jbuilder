json.array! @tournaments do |tournament|
  json.id tournament.id
  json.name tournament.name

  json.races tournament.races do |race|
    json.id race.id
    json.tournament_id race.tournament_id
    json.place race.place
    json.date race.date
  end
end
