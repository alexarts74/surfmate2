puts "Cleaning database..."
SurfingSession.destroy_all
User.destroy_all

puts "Creating test user..."
user = User.create!(
  email: "surfer@example.com",
  password: "password123",
  name: "John Doe",
  bio: "Passionné de surf depuis 10 ans, je parcours les spots de la côte basque à la recherche des meilleures vagues.",
  age: 28,
  image: "https://avatars.githubusercontent.com/u/1234567",
  level: ["Débutant", "Intermédiaire", "Avancé", "Expert"].sample
)

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

puts "Creating 50 surf sessions..."
10.times do
  SurfingSession.create!(
    location: spots.sample,
    date: Faker::Time.between(from: 6.months.ago, to: Date.today),
    description: descriptions.sample,
    user_id: user.id
  )
end

puts "✅ Created #{SurfingSession.count} surf sessions!"
