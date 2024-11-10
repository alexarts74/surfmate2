require 'faker'

puts "Cleaning database..."
SurfingSession.destroy_all
User.destroy_all

puts "Creating test users..."
users = []

2
.times do |i|
  users << User.create!(
    email: "surfer#{i+1}@example.com",
    password: "password123",
    name: Faker::Name.name,
    bio: Faker::Lorem.paragraph(sentence_count: 3),
    age: rand(18..50),
    image: "https://avatars.githubusercontent.com/u/#{rand(1000..9999)}",
    level: ["Débutant", "Intermédiaire", "Avancé", "Expert"].sample
  )
end

puts "Creating surfing sessions..."

spots = [
  "Hossegor - La Gravière",
  "Biarritz - Grande Plage",
  "Lacanau - Super Sud",
  "Anglet - Les Cavaliers",
  "Hendaye - Plage Centrale",
  "Capbreton - Le Prevent",
  "Seignosse - Les Estagnots",
  "Biarritz - Côte des Basques",
  "Guéthary - Parlementia",
  "Bidart - Plage du Centre"
]

titles = [
  "Session matinale",
  "After-work surf",
  "Session du week-end",
  "Sunset session",
  "Session découverte",
  "Session entre potes"
]

descriptions = [
  "Session matinale avec des vagues propres. Peu de monde à l'eau.",
  "Conditions parfaites l'après-midi. Vent offshore.",
  "Session sympa malgré un peu de vent. Quelques belles séries.",
  "Vagues de 1m avec une belle forme. Eau à 18°C.",
  "Super session du soir avec un beau coucher de soleil.",
  "Grosses vagues aujourd'hui, session intense !",
  "Eau cristalline et vagues régulières.",
  "Session courte mais efficace entre deux averses.",
  "Conditions idéales pour progresser.",
  "Belle session en longboard sur des vagues douces."
]

meeting_points = [
  "Parking principal",
  "Devant le poste de secours",
  "Café du surf",
  "Entrée de la plage",
  "École de surf locale"
]

10.times do
  SurfingSession.create!(
    title: titles.sample,
    location: spots.sample,
    date: Faker::Time.between(from: 6.months.ago, to: Date.today),
    description: descriptions.sample,
    user_id: users.sample.id,
    max_participants: rand(2..8),
    level_required: ["Débutant", "Intermédiaire", "Avancé", "Expert"].sample,
    status: ["open", "full", "completed"].sample,
    wave_height: rand(0.5..2.5).round(1),
    meeting_point: meeting_points.sample
  )
end

puts "✅ Created #{User.count} users"
puts "✅ Created #{SurfingSession.count} surfing sessions"
