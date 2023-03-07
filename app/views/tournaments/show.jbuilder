json.id @tournament.id
json.name @tournament.name

json.racers @racers do |racer|
  json.id racer.id
  json.name racer.name
  json.born_at racer.born_at
  json.image_url racer.image_url
  json.points racer.points_from_tournament(@tournament.id)
end

json.races @tournament.races do |race|
  json.id race.id
  json.tournament_id race.tournament_id
  json.place race.place
  json.date race.date
  json.placements race.placements do |placement|
    json.id placement.id
    json.racer_id placement.racer_id
    json.position placement.position
  end
end
