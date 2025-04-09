# Utilise l'image Node officielle
FROM node:18

# Crée le dossier de travail dans le conteneur
WORKDIR /app

# Copie les fichiers package.json et package-lock.json
COPY package*.json ./

# Installe les dépendances
RUN npm install

# Copie le reste de l'application
COPY . .

# Expose le port (à adapter si besoin)
EXPOSE 3000

# Démarre l'application
CMD ["node", "index.mjs"]
