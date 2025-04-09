import dotenv from 'dotenv';
dotenv.config();
import mysql from 'mysql2/promise';

const connectWithRetry = async (retries = 10, delay = 3000) => {
  for (let i = 0; i < retries; i++) {
    try {
      const connection = await mysql.createConnection({
        host: process.env.DB_HOST,
        user: process.env.DB_USER,
        password: process.env.DB_PASSWORD,
        database: process.env.DB_NAME,
        port: process.env.DB_PORT || 3306
      });
      console.log("✅ Connexion MySQL réussie !");
      return connection;
    } catch (err) {
      console.log(`❌ Tentative ${i + 1} : Connexion échouée. Nouvelle tentative dans ${delay / 1000}s...`);
      if (i === retries - 1) throw err;
      await new Promise(res => setTimeout(res, delay));
    }
  }
};

const connection = await connectWithRetry();
export default connection;
