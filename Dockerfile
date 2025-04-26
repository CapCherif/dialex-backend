# Utilise l'image Node officielle
FROM node:18
# Installer netcat
RUN apt-get update && apt-get install -y netcat-openbsd
# Crée le dossier de travail dans le conteneur
WORKDIR /app

# Copie les fichiers package.json et package-lock.json
COPY package*.json ./

# Installe les dépendances
RUN npm install

# Copie le reste de l'application
COPY . .

COPY wait-for-mysql.sh /wait-for-mysql.sh
RUN chmod +x /wait-for-mysql.sh

ENTRYPOINT ["/wait-for-mysql.sh"]
# Expose le port (à adapter si besoin)
EXPOSE 3000

# Démarre l'application
CMD ["node", "index.mjs"]